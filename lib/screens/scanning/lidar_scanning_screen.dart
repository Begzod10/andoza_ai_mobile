import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../providers/lidar_provider.dart';
import '../../services/lidar_service.dart';
import '../room_setup/wall_measurements_screen.dart';

/// LiDAR scanning state
class LiDARScanState {
  final bool isScanning;
  final double progress;
  final int wallsFound;
  final int doorsFound;
  final int windowsFound;

  /// True while a real on-device ARCore scan is running (indeterminate
  /// progress); false for the emulator simulation (0→100% timer).
  final bool isRealScan;

  LiDARScanState({
    required this.isScanning,
    required this.progress,
    required this.wallsFound,
    required this.doorsFound,
    required this.windowsFound,
    this.isRealScan = false,
  });

  LiDARScanState copyWith({
    bool? isScanning,
    double? progress,
    int? wallsFound,
    int? doorsFound,
    int? windowsFound,
    bool? isRealScan,
  }) {
    return LiDARScanState(
      isScanning: isScanning ?? this.isScanning,
      progress: progress ?? this.progress,
      wallsFound: wallsFound ?? this.wallsFound,
      doorsFound: doorsFound ?? this.doorsFound,
      windowsFound: windowsFound ?? this.windowsFound,
      isRealScan: isRealScan ?? this.isRealScan,
    );
  }
}

class LiDARScanNotifier extends StateNotifier<LiDARScanState> {
  LiDARScanNotifier()
    : super(
        LiDARScanState(
          isScanning: false,
          progress: 0.0,
          wallsFound: 0,
          doorsFound: 0,
          windowsFound: 0,
        ),
      );

  int _count = 0;

  /// Emulator / demo path: timer-driven fake progress 0→100%.
  void startScan() {
    _count = 0;
    state = state.copyWith(
      isScanning: true,
      progress: 0.0,
      wallsFound: 0,
      doorsFound: 0,
      windowsFound: 0,
      isRealScan: false,
    );
    _simulateScan();
  }

  /// Real-device path indicator: an indeterminate "launching AR" state
  /// held while the screen awaits the native `scanRoom()` call.
  void beginRealScan() {
    state = state.copyWith(
      isScanning: true,
      progress: 0.0,
      wallsFound: 0,
      doorsFound: 0,
      windowsFound: 0,
      isRealScan: true,
    );
  }

  void _simulateScan() {
    Future.delayed(const Duration(milliseconds: 60), () {
      if (!state.isScanning) return;
      if (_count < 100) {
        _count++;
        state = state.copyWith(
          progress: _count / 100,
          wallsFound: (_count / 33).floor().clamp(0, 3),
          doorsFound: _count > 40 ? 1 : 0,
          windowsFound: (_count / 45).floor().clamp(0, 2),
        );
        _simulateScan();
      } else {
        state = state.copyWith(isScanning: false);
      }
    });
  }
}

final liDARScanProvider =
    StateNotifierProvider<LiDARScanNotifier, LiDARScanState>(
      (ref) => LiDARScanNotifier(),
    );

/// A4: LiDAR skanerlash. Full-screen dark camera view with a green
/// wireframe scan sweep, corner brackets, and a progress ring — the room's
/// walls/eshik/deraza are counted live as the scan progresses.
class LiDARScanningScreen extends ConsumerStatefulWidget {
  const LiDARScanningScreen({super.key});

  @override
  ConsumerState<LiDARScanningScreen> createState() =>
      _LiDARScanningScreenState();
}

class _LiDARScanningScreenState extends ConsumerState<LiDARScanningScreen>
    with TickerProviderStateMixin {
  late final AnimationController _sweepController;
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _sweepController = AnimationController(
      vsync: this,
      duration: DesignTokens.animationScanSweep,
    )..repeat();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _start();
    });
  }

  /// Decides between the real on-device scan and the emulator simulation:
  /// - LiDAR/ARCore available  → native `scanRoom()`, then apply the
  ///   measured dimensions to [wallMeasurementsProvider] and navigate.
  /// - not available (emulator) → keep the existing timer simulation.
  Future<void> _start() async {
    final lidarService = ref.read(lidarServiceProvider);
    final available = await lidarService.isLidarAvailable();
    if (!mounted) return;

    if (!available) {
      // Emulator demo — preserve the existing simulation exactly.
      ref.read(liDARScanProvider.notifier).startScan();
      return;
    }

    // Real device: show the "launching AR" state and await the scan.
    ref.read(liDARScanProvider.notifier).beginRealScan();
    try {
      final r = await lidarService.scanRoom();
      if (!mounted) return;
      ref
          .read(wallMeasurementsProvider.notifier)
          .applyScannedDimensions(
            width: r['width']!,
            length: r['length']!,
            height: r['height']!,
          );
      if (!mounted) return;
      context.push('/setup/wall-measurements');
    } on LidarException catch (e) {
      if (!mounted) return;
      if (e.code == 'CANCELLED') {
        // User backed out of the AR session — just return.
        Navigator.of(context).pop();
      } else {
        // Any other failure: fall back to the simulation so the user
        // still reaches the wall-measurements step.
        ref.read(liDARScanProvider.notifier).startScan();
      }
    } catch (_) {
      if (!mounted) return;
      ref.read(liDARScanProvider.notifier).startScan();
    }
  }

  @override
  void dispose() {
    _sweepController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scanState = ref.watch(liDARScanProvider);

    ref.listen<LiDARScanState>(liDARScanProvider, (previous, next) {
      if (previous?.isScanning == true && !next.isScanning) {
        context.push('/setup/wall-measurements');
      }
    });

    return Scaffold(
      backgroundColor: DesignTokens.darkBg,
      body: Stack(
        children: [
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _sweepController,
              builder: (context, child) => CustomPaint(
                painter: _ScanOverlayPainter(_sweepController.value),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(DesignTokens.spacingMd),
                  child: Row(
                    children: [
                      _RoundIconButton(
                        icon: Icons.close,
                        onTap: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: 120,
                  height: 120,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        // Real ARCore scan has no % progress → indeterminate.
                        value: scanState.isRealScan ? null : scanState.progress,
                        strokeWidth: 6,
                        backgroundColor: Colors.white.withValues(alpha: 0.16),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          DesignTokens.accentOrange,
                        ),
                      ),
                      if (!scanState.isRealScan)
                        Text(
                          '${(scanState.progress * 100).toStringAsFixed(0)}%',
                          style: DesignTokens.heading2.copyWith(
                            color: DesignTokens.white,
                          ),
                        )
                      else
                        const Icon(
                          Icons.view_in_ar_outlined,
                          color: DesignTokens.white,
                          size: DesignTokens.iconLg,
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: DesignTokens.spacingLg),
                AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, child) => Opacity(
                    opacity: 0.5 + 0.5 * _pulseController.value,
                    child: child,
                  ),
                  child: Text(
                    'Skanerlanyapti...',
                    style: DesignTokens.subtitle1.copyWith(
                      color: DesignTokens.white,
                    ),
                  ),
                ),
                const Spacer(),
                _HintPill(
                  icon: Icons.screen_rotation_alt_outlined,
                  label: 'Telefonni sekin harakatlantiring',
                ),
                const SizedBox(height: DesignTokens.spacingMd),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: DesignTokens.spacingMd,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: DesignTokens.spacingMd,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _FoundStat(
                        icon: Icons.crop_square_outlined,
                        label: 'devor',
                        count: scanState.wallsFound,
                      ),
                      _FoundStat(
                        icon: Icons.door_front_door_outlined,
                        label: 'eshik',
                        count: scanState.doorsFound,
                      ),
                      _FoundStat(
                        icon: Icons.window_outlined,
                        label: 'deraza',
                        count: scanState.windowsFound,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: DesignTokens.spacingLg),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.16),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: DesignTokens.white, size: DesignTokens.iconMd),
      ),
    );
  }
}

class _HintPill extends StatelessWidget {
  const _HintPill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: DesignTokens.spacingMd,
        vertical: DesignTokens.spacingSm,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: DesignTokens.white, size: DesignTokens.iconSm),
          const SizedBox(width: DesignTokens.spacingSm),
          Text(
            label,
            style: DesignTokens.body2.copyWith(color: DesignTokens.white),
          ),
        ],
      ),
    );
  }
}

class _FoundStat extends StatelessWidget {
  const _FoundStat({
    required this.icon,
    required this.label,
    required this.count,
  });

  final IconData icon;
  final String label;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: DesignTokens.white, size: DesignTokens.iconSm),
        const SizedBox(height: DesignTokens.spacingXs),
        Text(
          '$count $label',
          style: DesignTokens.caption.copyWith(color: DesignTokens.white),
        ),
      ],
    );
  }
}

/// Faint perspective grid + sweeping green wireframe band + 4 corner
/// brackets, per spec's A4 camera-view description.
class _ScanOverlayPainter extends CustomPainter {
  _ScanOverlayPainter(this.sweepProgress);

  final double sweepProgress;
  static const _scanGreen = Color(0xFF34D399);

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.04)
      ..strokeWidth = 1;
    const gridSpacing = 40.0;
    for (double x = 0; x < size.width; x += gridSpacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += gridSpacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final sweepY = size.height * sweepProgress;
    final sweepPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          _scanGreen.withValues(alpha: 0),
          _scanGreen.withValues(alpha: 0.35),
          _scanGreen.withValues(alpha: 0),
        ],
      ).createShader(Rect.fromLTWH(0, sweepY - 40, size.width, 80));
    canvas.drawRect(Rect.fromLTWH(0, sweepY - 40, size.width, 80), sweepPaint);

    const bracketLen = 34.0;
    const inset = 24.0;
    final bracketPaint = Paint()
      ..color = _scanGreen
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    // Top-left
    canvas.drawLine(
      const Offset(inset, inset),
      const Offset(inset + bracketLen, inset),
      bracketPaint,
    );
    canvas.drawLine(
      const Offset(inset, inset),
      const Offset(inset, inset + bracketLen),
      bracketPaint,
    );
    // Top-right
    canvas.drawLine(
      Offset(size.width - inset, inset),
      Offset(size.width - inset - bracketLen, inset),
      bracketPaint,
    );
    canvas.drawLine(
      Offset(size.width - inset, inset),
      Offset(size.width - inset, inset + bracketLen),
      bracketPaint,
    );
    // Bottom-left
    canvas.drawLine(
      Offset(inset, size.height - inset),
      Offset(inset + bracketLen, size.height - inset),
      bracketPaint,
    );
    canvas.drawLine(
      Offset(inset, size.height - inset),
      Offset(inset, size.height - inset - bracketLen),
      bracketPaint,
    );
    // Bottom-right
    canvas.drawLine(
      Offset(size.width - inset, size.height - inset),
      Offset(size.width - inset - bracketLen, size.height - inset),
      bracketPaint,
    );
    canvas.drawLine(
      Offset(size.width - inset, size.height - inset),
      Offset(size.width - inset, size.height - inset - bracketLen),
      bracketPaint,
    );
  }

  @override
  bool shouldRepaint(_ScanOverlayPainter oldDelegate) =>
      oldDelegate.sweepProgress != sweepProgress;
}
