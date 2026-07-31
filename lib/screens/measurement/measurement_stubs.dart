import 'package:flutter/material.dart';
import '../../config/design_tokens.dart';

class MeasurementStub extends StatelessWidget {
  const MeasurementStub({
    required this.title,
    required this.description,
    super.key,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.construction, size: 64, color: DesignTokens.primary),
            const SizedBox(height: DesignTokens.spacing24),
            Text(
              title,
              style: DesignTokens.headingMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: DesignTokens.spacing12),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DesignTokens.spacing24,
              ),
              child: Text(
                description,
                style: DesignTokens.bodyMedium.copyWith(
                  color: DesignTokens.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: DesignTokens.spacing24),
            Container(
              padding: const EdgeInsets.all(DesignTokens.spacing16),
              decoration: BoxDecoration(
                color: DesignTokens.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(DesignTokens.radiusLarge),
              ),
              child: Text(
                'Phase 1 - Under Development',
                style: DesignTokens.labelMedium.copyWith(
                  color: DesignTokens.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
