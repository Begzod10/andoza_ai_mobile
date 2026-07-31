import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../providers/measurement_provider.dart';

/// A7: Photo Measurement Screen
/// Guide user through photo-based measurement using reference objects
class A7PhotoScreen extends ConsumerStatefulWidget {
  const A7PhotoScreen({super.key});

  @override
  ConsumerState<A7PhotoScreen> createState() => _A7PhotoScreenState();
}

class _A7PhotoScreenState extends ConsumerState<A7PhotoScreen> {
  int _photosCapture = 0;
  final int _targetPhotos = 3;

  void _capturePhoto() {
    if (_photosCapture < _targetPhotos) {
      setState(() => _photosCapture++);
      if (_photosCapture == _targetPhotos) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('All reference photos captured! ✓'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final measurement = ref.watch(measurementProvider);
    final progress = _photosCapture / _targetPhotos;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Measurement'),
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
                'Capture Reference Photos',
                style: DesignTokens.headingMedium.copyWith(
                  color: DesignTokens.text,
                ),
              ),
              const SizedBox(height: DesignTokens.spacing16),
              Text(
                'Use standard objects for scale reference',
                style: DesignTokens.bodyMedium.copyWith(
                  color: DesignTokens.textSecondary,
                ),
              ),
              const SizedBox(height: DesignTokens.spacing32),
              // Progress bar
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Photos Captured',
                        style: DesignTokens.bodyMedium,
                      ),
                      Text(
                        '$_photosCapture/$_targetPhotos',
                        style: DesignTokens.subtitle2.copyWith(
                          color: DesignTokens.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 8,
                      backgroundColor: DesignTokens.border,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        DesignTokens.success,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: DesignTokens.spacing32),
              // Camera preview placeholder
              Container(
                height: 280,
                decoration: BoxDecoration(
                  color: DesignTokens.primary.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(DesignTokens.radiusLarge),
                  border: Border.all(
                    color: DesignTokens.primary.withValues(alpha: 0.3),
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt_outlined,
                        size: 80,
                        color: DesignTokens.primary.withValues(alpha: 0.5),
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
              // Reference guides
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
                      'Suggested References:',
                      style: DesignTokens.subtitle2.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _ReferenceGuide(text: 'Door frame (standard 80-90 cm)'),
                    _ReferenceGuide(text: 'Window opening (60-100 cm)'),
                    _ReferenceGuide(text: 'Furniture items'),
                  ],
                ),
              ),
              const SizedBox(height: DesignTokens.spacing32),
              // Captured photos
              if (_photosCapture > 0) ...[
                Container(
                  padding: const EdgeInsets.all(DesignTokens.spacing16),
                  decoration: BoxDecoration(
                    color: DesignTokens.success.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Captured Photos',
                        style: DesignTokens.subtitle2,
                      ),
                      const SizedBox(height: DesignTokens.spacing12),
                      SizedBox(
                        height: 60,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _photosCapture,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                right: DesignTokens.spacing8,
                              ),
                              child: Container(
                                width: 60,
                                decoration: BoxDecoration(
                                  color: DesignTokens.success
                                      .withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(
                                    DesignTokens.radiusMd,
                                  ),
                                  border: Border.all(
                                    color: DesignTokens.success,
                                  ),
                                ),
                                child: Icon(
                                  Icons.check_circle,
                                  color: DesignTokens.success,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: DesignTokens.spacing24),
              ],
              // Action buttons
              ElevatedButton.icon(
                onPressed: _photosCapture < _targetPhotos ? _capturePhoto : null,
                icon: const Icon(Icons.camera),
                label: Text(
                  _photosCapture < _targetPhotos
                      ? 'Capture Photo'
                      : 'Complete',
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: DesignTokens.spacing12,
                  ),
                ),
              ),
              const SizedBox(height: DesignTokens.spacing16),
              OutlinedButton(
                onPressed: () => context.push('/measurement/a8'),
                child: const Text('Continue to Review'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReferenceGuide extends StatelessWidget {
  const _ReferenceGuide({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: DesignTokens.spacing8),
      child: Row(
        children: [
          Icon(
            Icons.image_outlined,
            size: 20,
            color: DesignTokens.warning,
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
