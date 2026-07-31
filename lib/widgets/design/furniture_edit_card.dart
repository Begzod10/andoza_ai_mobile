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
          // Header — no price anywhere on this card, per spec's hard rule.
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
          const SizedBox(height: DesignTokens.spacing12),
          Wrap(
            spacing: DesignTokens.spacingSm,
            children: ['Qora', 'Oq', 'Jigarrang'].map((color) {
              return ChoiceChip(
                selected: _selectedColor == color,
                label: Text(color),
                onSelected: (_) => setState(() => _selectedColor = color),
              );
            }).toList(),
          ),
          const SizedBox(height: DesignTokens.spacing24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: widget.onDelete,
                  icon: const Icon(Icons.close),
                  label: const Text('O\'chirish'),
                ),
              ),
              const SizedBox(width: DesignTokens.spacing12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () =>
                      setState(() => _rotation = (_rotation + 90) % 360),
                  icon: const Icon(Icons.rotate_right),
                  label: const Text('Aylantirish'),
                ),
              ),
            ],
          ),
          const SizedBox(height: DesignTokens.spacing12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _save,
              child: const Text('Saqlash'),
            ),
          ),
        ],
      ),
    );
  }
}
