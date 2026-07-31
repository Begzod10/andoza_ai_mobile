import 'package:flutter/material.dart';
import '../../config/design_tokens.dart';
import '../../models/design_selection_model.dart';

/// Bottom sheet card for editing furniture placement and properties
class FurnitureEditCard extends StatefulWidget {
  const FurnitureEditCard({
    required this.furniture,
    required this.onSave,
    required this.onDelete,
    super.key,
  });

  final FurniturePlacement furniture;
  final ValueChanged<FurniturePlacement> onSave;
  final VoidCallback onDelete;

  @override
  State<FurnitureEditCard> createState() => _FurnitureEditCardState();
}

class _FurnitureEditCardState extends State<FurnitureEditCard> {
  late double _rotation;
  late String _selectedColor;

  @override
  void initState() {
    super.initState();
    _rotation = widget.furniture.rotationDegrees;
    _selectedColor = widget.furniture.selectedColor;
  }

  void _save() {
    final updated = widget.furniture.copyWith(
      rotationDegrees: _rotation,
      selectedColor: _selectedColor,
    );
    widget.onSave(updated);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom:
            MediaQuery.of(context).viewInsets.bottom + DesignTokens.spacing24,
        left: DesignTokens.spacing24,
        right: DesignTokens.spacing24,
        top: DesignTokens.spacing24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.furniture.name,
                style: DesignTokens.heading3.copyWith(color: DesignTokens.text),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const SizedBox(height: DesignTokens.spacing24),

          // Rotation slider
          Text(
            'Rotation',
            style: DesignTokens.subtitle2.copyWith(color: DesignTokens.text),
          ),
          const SizedBox(height: DesignTokens.spacing12),
          Slider(
            value: _rotation,
            min: 0,
            max: 360,
            divisions: 36,
            label: '${_rotation.toStringAsFixed(0)}°',
            onChanged: (value) => setState(() => _rotation = value),
          ),
          const SizedBox(height: DesignTokens.spacing24),

          // Color selection
          Text(
            'Color',
            style: DesignTokens.subtitle2.copyWith(color: DesignTokens.text),
          ),
          const SizedBox(height: DesignTokens.spacing12),
          Wrap(
            spacing: DesignTokens.spacing12,
            children: ['Black', 'White', 'Brown', 'Gray'].map((color) {
              return ChoiceChip(
                selected: _selectedColor == color,
                label: Text(color),
                onSelected: (_) => setState(() => _selectedColor = color),
              );
            }).toList(),
          ),
          const SizedBox(height: DesignTokens.spacing32),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: widget.onDelete,
                  icon: const Icon(Icons.delete),
                  label: const Text('Delete'),
                ),
              ),
              const SizedBox(width: DesignTokens.spacing12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _save,
                  icon: const Icon(Icons.check),
                  label: const Text('Save'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
