import 'package:flutter/material.dart';
import '../../config/design_tokens.dart';
import '../../models/design_selection_model.dart' show StageDisplayState;

/// Horizontal segmented progress indicator.
///
/// Two modes:
/// - Simple (default): [currentStep]/[totalSteps] drive plain
///   completed/current/upcoming coloring — used by screens that don't
///   need the delta mechanic (e.g. a generic multi-step form).
/// - Delta-aware: pass [stageStates] (one entry per segment, from
///   [deriveStageStates]) to render the gray "already existed, excluded"
///   segments the product's delta mechanic requires — used by every
///   Batch A/B/C/D/E screen that shows renovation-stage progress.
class StageProgressLine extends StatelessWidget {
  const StageProgressLine({
    required this.currentStep,
    required this.totalSteps,
    this.stageStates,
    this.stageLabel,
    super.key,
  });

  final int currentStep;
  final int totalSteps;

  /// Delta-aware per-segment state. When provided, overrides the simple
  /// [currentStep]-based coloring entirely.
  final List<StageDisplayState>? stageStates;

  /// Overrides the default "Step X of Y" caption — e.g. the spec's
  /// "Bosqich 3/8 · ✓ suvoq va shpaklovka mavjud edi".
  final String? stageLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(totalSteps, (index) {
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: index < totalSteps - 1 ? DesignTokens.spacingSm : 0,
                ),
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: _segmentColor(index),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: DesignTokens.spacing12),
        Text(
          stageLabel ?? 'Step ${currentStep + 1} of $totalSteps',
          style: DesignTokens.caption.copyWith(
            color: DesignTokens.textSecondary,
          ),
        ),
      ],
    );
  }

  Color _segmentColor(int index) {
    final states = stageStates;
    if (states != null && index < states.length) {
      return switch (states[index]) {
        StageDisplayState.excluded => DesignTokens.existingStateGray,
        StageDisplayState.completed => DesignTokens.delta.completed,
        StageDisplayState.inProgress => DesignTokens.delta.inProgress,
        StageDisplayState.upcoming => DesignTokens.delta.upcoming,
      };
    }

    final isCompleted = index < currentStep;
    final isCurrent = index == currentStep;
    return isCompleted || isCurrent
        ? DesignTokens.primaryBlue
        : DesignTokens.border;
  }
}
