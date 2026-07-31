import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../providers/measurement_provider.dart';

/// A2: Camera Measurement Screen
/// Guides user through camera-based room measurement
class A2CameraScreen extends ConsumerStatefulWidget {
  const A2CameraScreen({super.key});

  @override
  ConsumerState<A2CameraScreen> createState() => _A2CameraScreenState();
}

class _A2CameraScreenState extends ConsumerState<A2CameraScreen> {
  bool _isScanning = false;
  double _progress = 0.0;

  void _startCameraCapture() {
    setState(() => _isScanning = true);
    // Simulate camera capture progress
    for (int i = 0; i <= 10; i++) {
      Future.delayed(Duration(milliseconds: i * 100), () {
        if (mounted) {
          setState(() => _progress = (i + 1) / 10);
          if (i == 9) {
            setState(() => _isScanning = false);
            _showMeasurementResult();
          }
        }
      });
    }
  }

  void _showMeasurementResult() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Measurement Complete'),
        content: const Text('Camera measurement captured. Continue to enter room details.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Measurement'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(DesignTokens.spacing24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Position Your Camera',
                style: DesignTokens.headingMedium.copyWith(
                  color: DesignTokens.text,
                ),
              ),
              const SizedBox(height: DesignTokens.spacing16),
              Text(
                'Hold your phone steady and capture the full room',
                style: DesignTokens.bodyMedium.copyWith(
                  color: DesignTokens.textSecondary,
                ),
              ),
              const SizedBox(height: DesignTokens.spacing32),
              // Camera preview placeholder
              Container(
                height: 300,
                decoration: BoxDecoration(
                  color: DesignTokens.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(DesignTokens.radiusLarge),
                  border: Border.all(
                    color: DesignTokens.primary,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt,
                        size: 64,
                        color: DesignTokens.primary,
                      ),
                      const SizedBox(height: DesignTokens.spacing16),
                      Text(
                        'Camera Preview',
                        style: DesignTokens.bodyMedium.copyWith(
                          color: DesignTokens.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: DesignTokens.spacing32),
              // Instructions
              Container(
                padding: const EdgeInsets.all(DesignTokens.spacing16),
                decoration: BoxDecoration(
                  color: DesignTokens.warning.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                  border: Border.all(
                    color: DesignTokens.warning.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tips for best results:',
                      style: DesignTokens.subtitle2.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _TipRow(text: 'Ensure good lighting in the room'),
                    _TipRow(text: 'Keep phone steady and level'),
                    _TipRow(text: 'Capture full room including corners'),
                    _TipRow(text: 'Avoid glare and shadows'),
                  ],
                ),
              ),
              const SizedBox(height: DesignTokens.spacing32),
              // Progress indicator
              if (_isScanning) ...[
                Text(
                  'Capturing... ${(_progress * 100).toStringAsFixed(0)}%',
                  style: DesignTokens.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: DesignTokens.spacing16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
                  child: LinearProgressIndicator(
                    value: _progress,
                    minHeight: 8,
                    backgroundColor: DesignTokens.border,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      DesignTokens.success,
                    ),
                  ),
                ),
                const SizedBox(height: DesignTokens.spacing24),
              ],
              // Action buttons
              ElevatedButton.icon(
                onPressed: _isScanning ? null : _startCameraCapture,
                icon: const Icon(Icons.camera),
                label: Text(_isScanning ? 'Capturing...' : 'Capture Room'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: DesignTokens.spacing12,
                  ),
                ),
              ),
              const SizedBox(height: DesignTokens.spacing16),
              OutlinedButton(
                onPressed: _isScanning ? null : () => context.push('/measurement/a3'),
                child: const Text('Skip & Enter Manually'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TipRow extends StatelessWidget {
  const _TipRow({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: DesignTokens.spacing8),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 20,
            color: DesignTokens.success,
          ),
          const SizedBox(width: DesignTokens.spacing12),
          Expanded(
            child: Text(
              text,
              style: DesignTokens.bodySmall.copyWith(
                color: DesignTokens.text,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
