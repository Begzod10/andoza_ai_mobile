import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/design_tokens.dart';

/// LiDAR scanning state
class LiDARScanState {
  final bool isScanning;
  final double progress;
  final int pointsCollected;
  final String status;

  LiDARScanState({
    required this.isScanning,
    required this.progress,
    required this.pointsCollected,
    required this.status,
  });

  LiDARScanState copyWith({
    bool? isScanning,
    double? progress,
    int? pointsCollected,
    String? status,
  }) {
    return LiDARScanState(
      isScanning: isScanning ?? this.isScanning,
      progress: progress ?? this.progress,
      pointsCollected: pointsCollected ?? this.pointsCollected,
      status: status ?? this.status,
    );
  }
}

class LiDARScanNotifier extends StateNotifier<LiDARScanState> {
  LiDARScanNotifier()
    : super(
        LiDARScanState(
          isScanning: false,
          progress: 0.0,
          pointsCollected: 0,
          status: 'Ready to scan',
        ),
      );

  void startScan() {
    state = state.copyWith(isScanning: true, status: 'Scanning...');
    _simulateScan();
  }

  void stopScan() {
    state = state.copyWith(isScanning: false, status: 'Scan complete');
  }

  void _simulateScan() {
    int count = 0;
    Future.delayed(const Duration(milliseconds: 100), () {
      if (state.isScanning && count < 100) {
        count++;
        state = state.copyWith(
          progress: count / 100,
          pointsCollected: count * 1500,
          status: 'Collecting point cloud data...',
        );
        _simulateScan();
      }
    });
  }
}

final liDARScanProvider =
    StateNotifierProvider<LiDARScanNotifier, LiDARScanState>(
      (ref) => LiDARScanNotifier(),
    );

/// LiDAR Scanning Screen (A4)
/// Shows real-time LiDAR scanning with progress and point cloud data
class LiDARScanningScreen extends ConsumerWidget {
  const LiDARScanningScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scanState = ref.watch(liDARScanProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: DesignTokens.darkBg,
        title: const Text('3D LiDAR Scan'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: DesignTokens.darkBg,
      body: Column(
        children: [
          // Camera Preview Area
          Expanded(
            child: Container(
              color: DesignTokens.darkBg,
              child: Stack(
                children: [
                  // Placeholder for actual camera/LiDAR feed
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          DesignTokens.darkBg,
                          DesignTokens.primaryBlue.withOpacity(0.1),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Point cloud visualization placeholder
                          Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                DesignTokens.radiusLg,
                              ),
                              border: Border.all(
                                color: DesignTokens.accentOrange,
                                width: 2,
                              ),
                            ),
                            child: CustomPaint(
                              painter: _PointCloudPainter(
                                progress: scanState.progress,
                              ),
                            ),
                          ),
                          const SizedBox(height: DesignTokens.spacingLg),
                          if (!scanState.isScanning)
                            Text(
                              'Position device and tap to start',
                              style: DesignTokens.body1.copyWith(
                                color: DesignTokens.white,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  // Grid overlay
                  if (scanState.isScanning)
                    Positioned.fill(
                      child: Opacity(
                        opacity: 0.1,
                        child: GridView.count(
                          crossAxisCount: 3,
                          children: List.generate(9, (index) {
                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: DesignTokens.accentOrange,
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  // Status indicator
                  Positioned(
                    top: DesignTokens.spacingLg,
                    right: DesignTokens.spacingLg,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: DesignTokens.spacingMd,
                        vertical: DesignTokens.spacingSm,
                      ),
                      decoration: BoxDecoration(
                        color: scanState.isScanning
                            ? DesignTokens.successGreen
                            : DesignTokens.warningYellow,
                        borderRadius: BorderRadius.circular(
                          DesignTokens.radiusMd,
                        ),
                      ),
                      child: Row(
                        children: [
                          if (scanState.isScanning)
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: DesignTokens.white,
                                borderRadius: BorderRadius.circular(
                                  DesignTokens.radiusFull,
                                ),
                              ),
                              margin: const EdgeInsets.only(
                                right: DesignTokens.spacingSm,
                              ),
                            ),
                          Text(
                            scanState.isScanning ? 'SCANNING' : 'READY',
                            style: DesignTokens.caption.copyWith(
                              color: DesignTokens.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Control Panel
          Container(
            decoration: BoxDecoration(
              color: DesignTokens.darkBg.withOpacity(0.95),
              border: Border(
                top: BorderSide(
                  color: DesignTokens.borderGray.withOpacity(0.2),
                ),
              ),
            ),
            padding: const EdgeInsets.all(DesignTokens.spacingMd),
            child: Column(
              children: [
                // Progress section
                if (scanState.isScanning) ...[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Scan Progress',
                            style: DesignTokens.body2.copyWith(
                              color: DesignTokens.white,
                            ),
                          ),
                          Text(
                            '${(scanState.progress * 100).toStringAsFixed(0)}%',
                            style: DesignTokens.subtitle2.copyWith(
                              color: DesignTokens.accentOrange,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: DesignTokens.spacingSm),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                          DesignTokens.radiusSm,
                        ),
                        child: LinearProgressIndicator(
                          value: scanState.progress,
                          minHeight: 8,
                          backgroundColor: DesignTokens.borderGray.withOpacity(
                            0.3,
                          ),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            DesignTokens.accentOrange,
                          ),
                        ),
                      ),
                      const SizedBox(height: DesignTokens.spacingMd),
                    ],
                  ),
                ],
                // Stats
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DesignTokens.spacingMd,
                    vertical: DesignTokens.spacingMd,
                  ),
                  decoration: BoxDecoration(
                    color: DesignTokens.primaryBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _StatColumn(
                        icon: Icons.cloud_outlined,
                        label: 'Points',
                        value: '${scanState.pointsCollected}',
                      ),
                      _StatColumn(icon: Icons.speed, label: 'FPS', value: '30'),
                      _StatColumn(
                        icon: Icons.battery_full,
                        label: 'Battery',
                        value: '85%',
                      ),
                      _StatColumn(
                        icon: Icons.thermostat,
                        label: 'Temp',
                        value: '35°C',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: DesignTokens.spacingLg),
                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                        label: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: DesignTokens.spacingMd),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (!scanState.isScanning) {
                            ref.read(liDARScanProvider.notifier).startScan();
                          } else {
                            ref.read(liDARScanProvider.notifier).stopScan();
                            Future.delayed(
                              const Duration(milliseconds: 500),
                              () {
                                Navigator.of(context).pushNamed('/photo-scan');
                              },
                            );
                          }
                        },
                        icon: Icon(
                          scanState.isScanning
                              ? Icons.check_circle
                              : Icons.fiber_manual_record,
                        ),
                        label: Text(
                          scanState.isScanning ? 'Complete' : 'Start Scan',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatColumn({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: DesignTokens.iconMd, color: DesignTokens.accentOrange),
        const SizedBox(height: DesignTokens.spacingSm),
        Text(
          label,
          style: DesignTokens.caption.copyWith(color: DesignTokens.textGray),
        ),
        const SizedBox(height: DesignTokens.spacingSm),
        Text(
          value,
          style: DesignTokens.subtitle2.copyWith(color: DesignTokens.white),
        ),
      ],
    );
  }
}

class _PointCloudPainter extends CustomPainter {
  final double progress;

  _PointCloudPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFF97316)
      ..strokeWidth = 2;

    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width / 2 - 10;

    // Draw rotating points as indication of scanning
    final pointCount = (100 * progress).toInt();
    for (int i = 0; i < pointCount; i++) {
      final angle = (i / 100) * 2 * 3.14159 + (progress * 6.28318);
      final radius = maxRadius * (1 - (i / 100) * 0.7);

      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);

      canvas.drawCircle(Offset(x, y), 2, paint);
    }
  }

  @override
  bool shouldRepaint(_PointCloudPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
