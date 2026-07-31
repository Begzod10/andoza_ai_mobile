import 'package:flutter/material.dart';
import '../../config/design_tokens.dart';

/// Horizontal progress indicator showing current stage in design workflow
class StageProgressLine extends StatelessWidget {
  const StageProgressLine({
    required this.currentStep,
    required this.totalSteps,
    super.key,
  });

  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(totalSteps, (index) {
            final isCompleted = index < currentStep;
            final isCurrent = index == currentStep;

            return Expanded(
              child: Column(
                children: [
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: isCompleted || isCurrent
                          ? DesignTokens.primaryBlue
                          : DesignTokens.border,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  if (index < totalSteps - 1)
                    const SizedBox(width: DesignTokens.spacing8),
                ],
              ),
            );
          }),
        ),
        const SizedBox(height: DesignTokens.spacing12),
        Text(
          'Step ${currentStep + 1} of $totalSteps',
          style: DesignTokens.caption.copyWith(
            color: DesignTokens.textSecondary,
          ),
        ),
      ],
    );
  }
}
