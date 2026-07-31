import 'package:flutter/material.dart';
import '../../config/design_tokens.dart';
import '../../models/design_selection_model.dart';

/// Card for selecting surface condition (texture state)
class RoomConditionCard extends StatelessWidget {
  const RoomConditionCard({
    required this.surface,
    required this.condition,
    required this.onChanged,
    super.key,
  });

  final String surface;
  final SurfaceCondition condition;
  final ValueChanged<SurfaceCondition> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacing16),
      decoration: BoxDecoration(
        border: Border.all(color: DesignTokens.border),
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            surface,
            style: DesignTokens.subtitle2.copyWith(
              color: DesignTokens.text,
            ),
          ),
          const SizedBox(height: DesignTokens.spacing12),
          Wrap(
            spacing: DesignTokens.spacing12,
            children: SurfaceCondition.values.map((sc) {
              final isSelected = sc == condition;
              return ChoiceChip(
                selected: isSelected,
                label: Text(_getLabel(sc)),
                onSelected: (_) => onChanged(sc),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  String _getLabel(SurfaceCondition condition) {
    switch (condition) {
      case SurfaceCondition.raw:
        return 'Raw';
      case SurfaceCondition.plastered:
        return 'Plastered';
      case SurfaceCondition.puttied:
        return 'Puttied';
    }
  }
}
