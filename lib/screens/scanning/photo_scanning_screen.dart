import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/design_tokens.dart';

/// Photo scan state
class PhotoScanState {
  final bool isScanning;
  final int photosCount;
  final double angle;
  final String instruction;
  final List<String> capturedPhotos;

  PhotoScanState({
    required this.isScanning,
    required this.photosCount,
    required this.angle,
    required this.instruction,
    required this.capturedPhotos,
  });

  PhotoScanState copyWith({
    bool? isScanning,
    int? photosCount,
    double? angle,
    String? instruction,
    List<String>? capturedPhotos,
  }) {
    return PhotoScanState(
      isScanning: isScanning ?? this.isScanning,
      photosCount: photosCount ?? this.photosCount,
      angle: angle ?? this.angle,
      instruction: instruction ?? this.instruction,
      capturedPhotos: capturedPhotos ?? this.capturedPhotos,
    );
  }
}

class PhotoScanNotifier extends StateNotifier<PhotoScanState> {
  PhotoScanNotifier()
    : super(
        PhotoScanState(
          isScanning: false,
          photosCount: 0,
          angle: 0,
          instruction: 'Start by positioning at north',
          capturedPhotos: [],
        ),
      );

  void startScan() {
    state = state.copyWith(isScanning: true, photosCount: 0, angle: 0);
    _simulateScan();
  }

  void capturePhoto() {
    if (state.photosCount < 12) {
      final newPhotos = List<String>.from(state.capturedPhotos);
      newPhotos.add('photo_${state.photosCount}');

      state = state.copyWith(
        photosCount: state.photosCount + 1,
        capturedPhotos: newPhotos,
      );

      if (state.photosCount == 12) {
        state = state.copyWith(
          isScanning: false,
          instruction: 'Scan complete!',
        );
      }
    }
  }

  void _simulateScan() {
    if (state.isScanning && state.photosCount < 12) {
      Future.delayed(const Duration(milliseconds: 3000), () {
        state = state.copyWith(
          angle: ((state.photosCount + 1) / 12) * 360,
          instruction:
              'Rotate ${((state.photosCount + 1) * 30)} degrees and capture',
        );
      });
    }
  }

  void stopScan() {
    state = state.copyWith(isScanning: false);
  }
}

final photoScanProvider =
    StateNotifierProvider<PhotoScanNotifier, PhotoScanState>(
      (ref) => PhotoScanNotifier(),
    );

/// Photo Scanning Screen (A5)
/// Captures 360° photos with guided positioning
class PhotoScanningScreen extends ConsumerWidget {
  const PhotoScanningScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scanState = ref.watch(photoScanProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: DesignTokens.darkBg,
        title: const Text('360° Photo Scan'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: DesignTokens.darkBg,
      body: Column(
        children: [
          // Camera Preview with compass
          Expanded(
            child: Container(
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
              child: Stack(
                children: [
                  // Camera placeholder
                  Center(
                    child: Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: DesignTokens.accentOrange,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(
                          DesignTokens.radiusLg,
                        ),
                      ),
                      child: CustomPaint(
                        painter: _CompassPainter(
                          angle: scanState.angle,
                          photosCount: scanState.photosCount,
                        ),
                      ),
                    ),
                  ),
                  // Instruction overlay
                  Positioned(
                    bottom: DesignTokens.spacingLg,
                    left: DesignTokens.spacingMd,
                    right: DesignTokens.spacingMd,
                    child: Container(
                      padding: const EdgeInsets.all(DesignTokens.spacingMd),
                      decoration: BoxDecoration(
                        color: DesignTokens.darkBg.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(
                          DesignTokens.radiusMd,
                        ),
                        border: Border.all(
                          color: DesignTokens.accentOrange.withOpacity(0.5),
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            scanState.instruction,
                            style: DesignTokens.body1.copyWith(
                              color: DesignTokens.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: DesignTokens.spacingSm),
                          Text(
                            'Photos: ${scanState.photosCount}/12',
                            style: DesignTokens.subtitle2.copyWith(
                              color: DesignTokens.accentOrange,
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
                // Progress indicator
                if (scanState.photosCount > 0)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Photos Captured',
                            style: DesignTokens.body2.copyWith(
                              color: DesignTokens.white,
                            ),
                          ),
                          Text(
                            '${scanState.photosCount}/12',
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
                          value: scanState.photosCount / 12,
                          minHeight: 8,
                          backgroundColor: DesignTokens.borderGray.withOpacity(
                            0.3,
                          ),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            DesignTokens.successGreen,
                          ),
                        ),
                      ),
                      const SizedBox(height: DesignTokens.spacingMd),
                    ],
                  ),
                // Photo preview grid
                if (scanState.capturedPhotos.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Captured Photos',
                        style: DesignTokens.body2.copyWith(
                          color: DesignTokens.white,
                        ),
                      ),
                      const SizedBox(height: DesignTokens.spacingSm),
                      SizedBox(
                        height: 70,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: scanState.capturedPhotos.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                right: DesignTokens.spacingSm,
                              ),
                              child: Container(
                                width: 70,
                                decoration: BoxDecoration(
                                  color: DesignTokens.borderGray.withOpacity(
                                    0.3,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    DesignTokens.radiusMd,
                                  ),
                                  border: Border.all(
                                    color: DesignTokens.accentOrange
                                        .withOpacity(0.5),
                                  ),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.check_circle,
                                    color: DesignTokens.successGreen,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: DesignTokens.spacingMd),
                    ],
                  ),
                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close),
                        label: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: DesignTokens.spacingMd),
                    if (!scanState.isScanning)
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: scanState.photosCount > 0
                              ? () {
                                  Navigator.of(
                                    context,
                                  ).pushNamed('/dimensions-entry');
                                }
                              : null,
                          icon: const Icon(Icons.arrow_forward),
                          label: const Text('Next'),
                        ),
                      )
                    else
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            ref.read(photoScanProvider.notifier).capturePhoto();
                          },
                          icon: const Icon(Icons.camera),
                          label: const Text('Capture'),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: DesignTokens.spacingMd),
                if (!scanState.isScanning && scanState.photosCount == 0)
                  SizedBox(
                    width: double.infinity,
                    height: DesignTokens.buttonHeightLarge,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ref.read(photoScanProvider.notifier).startScan();
                      },
                      icon: const Icon(Icons.videocam),
                      label: const Text('Start 360° Capture'),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CompassPainter extends CustomPainter {
  final double angle;
  final int photosCount;

  _CompassPainter({required this.angle, required this.photosCount});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;

    // Draw compass circle
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = const Color(0xFFF97316).withOpacity(0.1)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    // Draw cardinal directions
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    const directions = ['N', 'E', 'S', 'W'];
    for (int i = 0; i < 4; i++) {
      final angle = (i * 90) * 3.14159 / 180;
      final x = center.dx + radius * sin(angle);
      final y = center.dy - radius * cos(angle);

      textPainter.text = TextSpan(
        text: directions[i],
        style: const TextStyle(
          color: Color(0xFFF97316),
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, y - textPainter.height / 2),
      );
    }

    // Draw rotation indicator
    final rotationPaint = Paint()
      ..color = const Color(0xFFF97316)
      ..strokeWidth = 3;

    final rotationAngle = angle * 3.14159 / 180;
    final endX = center.dx + radius * sin(rotationAngle);
    final endY = center.dy - radius * cos(rotationAngle);

    canvas.drawLine(center, Offset(endX, endY), rotationPaint);

    // Draw center point with photo count
    canvas.drawCircle(center, 8, Paint()..color = const Color(0xFFF97316));

    if (photosCount > 0) {
      textPainter.text = TextSpan(
        text: '$photosCount',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          center.dx - textPainter.width / 2,
          center.dy - textPainter.height / 2,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(_CompassPainter oldDelegate) {
    return oldDelegate.angle != angle || oldDelegate.photosCount != photosCount;
  }
}
