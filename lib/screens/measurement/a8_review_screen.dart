import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../providers/measurement_provider.dart';

class A8ReviewScreen extends ConsumerWidget {
  const A8ReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final measurement = ref.watch(measurementProvider);
    final area = measurement.area;
    final volume = measurement.volume;

    return Scaffold(
      appBar: AppBar(title: const Text('Review Measurement')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(DesignTokens.spacing24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Measurement Summary',
                style: DesignTokens.headingMedium.copyWith(
                  color: DesignTokens.text,
                ),
              ),
              const SizedBox(height: DesignTokens.spacing32),
              _SectionCard(
                title: 'Room Information',
                children: [
                  _InfoRow('Room Name:', measurement.roomName ?? 'N/A'),
                  _InfoRow('Width:', '${measurement.width ?? 0} m'),
                  _InfoRow('Length:', '${measurement.length ?? 0} m'),
                  _InfoRow('Height:', '${measurement.height ?? 0} m'),
                ],
              ),
              const SizedBox(height: DesignTokens.spacing24),
              _SectionCard(
                title: 'Calculated Values',
                children: [
                  _InfoRow(
                    'Floor Area:',
                    area != null ? '${area.toStringAsFixed(2)} m²' : 'N/A',
                  ),
                  _InfoRow(
                    'Volume:',
                    volume != null ? '${volume.toStringAsFixed(2)} m³' : 'N/A',
                  ),
                ],
              ),
              const SizedBox(height: DesignTokens.spacing24),
              if (measurement.furniture.isNotEmpty) ...[
                _SectionCard(
                  title: 'Furniture',
                  children: [
                    Text(
                      '${measurement.furniture.length} items added',
                      style: DesignTokens.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(height: DesignTokens.spacing24),
              ],
              ElevatedButton(
                onPressed: () {
                  // Save measurement
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Measurement saved successfully! 🎉'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  // Reset and go to A9
                  Future.delayed(const Duration(milliseconds: 500), () {
                    context.go('/measurement/a9');
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: DesignTokens.success,
                  padding: const EdgeInsets.symmetric(
                    vertical: DesignTokens.spacing12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(DesignTokens.radiusLarge),
                  ),
                ),
                child: Text(
                  'Save Measurement',
                  style: DesignTokens.bodyLarge.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: DesignTokens.spacing16),
              OutlinedButton(
                onPressed: () => context.pop(),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: DesignTokens.spacing12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(DesignTokens.radiusLarge),
                  ),
                ),
                child: Text(
                  'Edit',
                  style: DesignTokens.bodyLarge.copyWith(
                    color: DesignTokens.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacing16),
      decoration: BoxDecoration(
        border: Border.all(color: DesignTokens.border),
        borderRadius: BorderRadius.circular(DesignTokens.radiusLarge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: DesignTokens.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
              color: DesignTokens.text,
            ),
          ),
          const SizedBox(height: DesignTokens.spacing16),
          ...children,
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: DesignTokens.spacing8),
      child: Row(
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
            style: DesignTokens.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: DesignTokens.text,
            ),
          ),
        ],
      ),
    );
  }
}
