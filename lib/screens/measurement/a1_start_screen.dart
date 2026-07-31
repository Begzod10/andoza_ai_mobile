import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../providers/measurement_provider.dart';

class A1StartScreen extends ConsumerStatefulWidget {
  const A1StartScreen({super.key});

  @override
  ConsumerState<A1StartScreen> createState() => _A1StartScreenState();
}

class _A1StartScreenState extends ConsumerState<A1StartScreen> {
  @override
  void initState() {
    super.initState();
    // Reset measurement state on entry to A1
    ref.read(measurementProvider.notifier).reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Measurement')),
      body: Padding(
        padding: const EdgeInsets.all(DesignTokens.spacing24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Start Room Measurement',
              style: DesignTokens.headingLarge.copyWith(
                color: DesignTokens.text,
              ),
            ),
            const SizedBox(height: DesignTokens.spacing16),
            Text(
              'Choose how you want to measure your room',
              style: DesignTokens.bodyMedium.copyWith(
                color: DesignTokens.textSecondary,
              ),
            ),
            const SizedBox(height: DesignTokens.spacing32),
            _MeasurementOption(
              icon: Icons.phone_android,
              title: 'Use Camera',
              description: 'Use your phone camera to measure',
              onTap: () {
                // Set method and route through A3 (room name)
                ref.read(measurementMethodProvider.notifier).state =
                    MeasurementMethod.camera;
                context.push('/measurement/a3');
              },
            ),
            const SizedBox(height: DesignTokens.spacing16),
            _MeasurementOption(
              icon: Icons.input,
              title: 'Manual Entry',
              description: 'Manually enter room dimensions',
              onTap: () {
                // Set method and route through A3 (room name)
                ref.read(measurementMethodProvider.notifier).state =
                    MeasurementMethod.manual;
                context.push('/measurement/a3');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _MeasurementOption extends StatelessWidget {
  const _MeasurementOption({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(DesignTokens.spacing16),
        decoration: BoxDecoration(
          border: Border.all(color: DesignTokens.border),
          borderRadius: BorderRadius.circular(DesignTokens.radiusLarge),
        ),
        child: Row(
          children: [
            Icon(icon, size: 32, color: DesignTokens.primary),
            const SizedBox(width: DesignTokens.spacing16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: DesignTokens.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    description,
                    style: DesignTokens.bodySmall.copyWith(
                      color: DesignTokens.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: DesignTokens.textTertiary),
          ],
        ),
      ),
    );
  }
}
