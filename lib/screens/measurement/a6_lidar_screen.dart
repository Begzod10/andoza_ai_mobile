import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';

/// A6: LiDAR Scanning Screen
/// Shows LiDAR scanning progress for precise 3D measurement
class A6LidarScreen extends ConsumerStatefulWidget {
  const A6LidarScreen({super.key});

  @override
  ConsumerState<A6LidarScreen> createState() => _A6LidarScreenState();
}

class _A6LidarScreenState extends ConsumerState<A6LidarScreen> {
  bool _isScanning = false;
  double _progress = 0.0;
  int _pointsScanned = 0;

  void _startLidarScan() {
    setState(() => _isScanning = true);
    // Simulate LiDAR scan progress
    for (int i = 0; i <= 20; i++) {
      Future.delayed(Duration(milliseconds: i * 150), () {
        if (mounted) {
          setState(() {
            _progress = (i + 1) / 20;
            _pointsScanned = (i + 1) * 5000;
          });
          if (i == 19) {
            setState(() => _isScanning = false);
            _showScanComplete();
          }
        }
      });
    }
  }

  void _showScanComplete() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('LiDAR Scan Complete'),
        content: Text('Scanned $_pointsScanned point cloud data points'),
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
        title: const Text('LiDAR Scan'),
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
                '3D LiDAR Measurement',
                style: DesignTokens.headingMedium.copyWith(
                  color: DesignTokens.text,
                ),
              ),
              const SizedBox(height: DesignTokens.spacing16),
              Text(
                'Use LiDAR for precise 3D room capture',
                style: DesignTokens.bodyMedium.copyWith(
                  color: DesignTokens.textSecondary,
                ),
              ),
              const SizedBox(height: DesignTokens.spacing32),
              // LiDAR visualization placeholder
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
                      if (_isScanning) ...[
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: CircularProgressIndicator(
                            value: _progress,
                            strokeWidth: 4,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              DesignTokens.primary,
                            ),
                          ),
                        ),
                      ] else ...[
                        Icon(
                          Icons.cloud_upload_outlined,
                          size: 80,
                          color: DesignTokens.primary.withValues(alpha: 0.5),
                        ),
                      ],
                      const SizedBox(height: DesignTokens.spacing16),
                      if (_isScanning) ...[
                        Text(
                          '${(_progress * 100).toStringAsFixed(0)}%',
                          style: DesignTokens.headingMedium.copyWith(
                            color: DesignTokens.primary,
                          ),
                        ),
                        const SizedBox(height: DesignTokens.spacing12),
                        Text(
                          'Scanning...',
                          style: DesignTokens.bodyMedium.copyWith(
                            color: DesignTokens.textSecondary,
                          ),
                        ),
                      ] else ...[
                        Text(
                          'Point Cloud Visualization',
                          style: DesignTokens.bodyMedium.copyWith(
                            color: DesignTokens.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: DesignTokens.spacing32),
              // Statistics
              if (_pointsScanned > 0) ...[
                Container(
                  padding: const EdgeInsets.all(DesignTokens.spacing16),
                  decoration: BoxDecoration(
                    color: DesignTokens.primary.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                  ),
                  child: Column(
                    children: [
                      _StatRow(
                        label: 'Points Scanned',
                        value: '${_pointsScanned ~/ 1000}K',
                      ),
                      const SizedBox(height: DesignTokens.spacing16),
                      _StatRow(
                        label: 'Coverage',
                        value: '${(_progress * 100).toStringAsFixed(0)}%',
                      ),
                      const SizedBox(height: DesignTokens.spacing16),
                      _StatRow(
                        label: 'Status',
                        value: _isScanning ? 'Scanning' : 'Complete',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: DesignTokens.spacing24),
              ],
              // Action buttons
              ElevatedButton.icon(
                onPressed: _isScanning ? null : _startLidarScan,
                icon: const Icon(Icons.camera),
                label: Text(_isScanning ? 'Scanning...' : 'Start LiDAR Scan'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: DesignTokens.spacing12,
                  ),
                ),
              ),
              const SizedBox(height: DesignTokens.spacing16),
              OutlinedButton(
                onPressed: _isScanning ? null : () => context.push('/measurement/a7'),
                child: const Text('Next: Photo Measurement'),
              ),
              const SizedBox(height: DesignTokens.spacing16),
              OutlinedButton(
                onPressed: _isScanning ? null : () => context.push('/measurement/a8'),
                child: const Text('Skip to Review'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: DesignTokens.bodyMedium.copyWith(
            color: DesignTokens.textSecondary,
          ),
        ),
        Text(
          value,
          style: DesignTokens.subtitle2.copyWith(
            color: DesignTokens.primary,
          ),
        ),
      ],
    );
  }
}
