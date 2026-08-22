import 'package:flutter/material.dart';
import '../../config/design_tokens.dart';
import '../../models/room_model.dart';

/// A preset door/window size pill, e.g. "90×205".
class _SizePreset {
  const _SizePreset(this.width, this.height);
  final double width;
  final double height;
  String get label =>
      '${(width * 100).toStringAsFixed(0)}×${(height * 100).toStringAsFixed(0)}';
}

const _presets = [
  _SizePreset(0.90, 2.05),
  _SizePreset(0.80, 2.05),
  _SizePreset(0.70, 2.00),
  _SizePreset(1.65, 1.80),
  _SizePreset(1.20, 1.40),
];

/// A8: Eshik/Deraza qo'shish sheet — type chips, preset size pills, and a
/// position-on-wall slider. Reuses [OpeningType] (single/dual/sliding) to
/// represent Eshik/Deraza/Balkon eshigi; the enum's mechanism-oriented
/// naming predates this reuse but avoids forking a near-duplicate type.
class DoorWindowModal extends StatefulWidget {
  const DoorWindowModal({required this.onAdd, super.key});

  /// Called with (type, width, height, offsetFromWallStart) when the user
  /// taps "Devorga qo'shish".
  final void Function(
    OpeningType type,
    double width,
    double height,
    double offset,
  )
  onAdd;

  @override
  State<DoorWindowModal> createState() => _DoorWindowModalState();
}

class _DoorWindowModalState extends State<DoorWindowModal> {
  OpeningType _selectedType = OpeningType.single;
  _SizePreset? _selectedPreset = _presets.first;
  double _offset = 1.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: DesignTokens.screenPaddingHorizontal,
        right: DesignTokens.screenPaddingHorizontal,
        top: DesignTokens.spacingMd,
        bottom:
            MediaQuery.of(context).viewInsets.bottom + DesignTokens.spacingLg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 44,
              height: 5,
              margin: const EdgeInsets.only(bottom: DesignTokens.spacingLg),
              decoration: BoxDecoration(
                color: DesignTokens.borderGray,
                borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
              ),
            ),
          ),
          const Text('Eshik/Deraza qo\'shish', style: DesignTokens.heading3),
          const SizedBox(height: DesignTokens.spacingLg),
          Wrap(
            spacing: DesignTokens.spacingSm,
            children: [
              _TypeChip(
                label: 'Eshik',
                selected: _selectedType == OpeningType.single,
                onTap: () => setState(() => _selectedType = OpeningType.single),
              ),
              _TypeChip(
                label: 'Deraza',
                selected: _selectedType == OpeningType.dual,
                onTap: () => setState(() => _selectedType = OpeningType.dual),
              ),
              _TypeChip(
                label: 'Balkon eshigi',
                selected: _selectedType == OpeningType.sliding,
                onTap: () =>
                    setState(() => _selectedType = OpeningType.sliding),
              ),
            ],
          ),
          const SizedBox(height: DesignTokens.spacingLg),
          const Text('O\'lcham (sm)', style: DesignTokens.subtitle2),
          const SizedBox(height: DesignTokens.spacingSm),
          Wrap(
            spacing: DesignTokens.spacingSm,
            runSpacing: DesignTokens.spacingSm,
            children: [
              for (final preset in _presets)
                _SizeChip(
                  label: preset.label,
                  selected: _selectedPreset == preset,
                  onTap: () => setState(() => _selectedPreset = preset),
                ),
              _SizeChip(
                label: 'Boshqa o\'lcham…',
                selected: _selectedPreset == null,
                onTap: () => setState(() => _selectedPreset = null),
              ),
            ],
          ),
          const SizedBox(height: DesignTokens.spacingLg),
          const Text('Devor bo\'ylab joylashuvi', style: DesignTokens.subtitle2),
          Slider(
            value: _offset,
            min: 0,
            max: 8,
            activeColor: DesignTokens.primaryBlue,
            onChanged: (value) => setState(() => _offset = value),
          ),
          const SizedBox(height: DesignTokens.spacingSm),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _selectedPreset == null
                  ? null
                  : () => widget.onAdd(
                      _selectedType,
                      _selectedPreset!.width,
                      _selectedPreset!.height,
                      _offset,
                    ),
              child: const Text('Devorga qo\'shish'),
            ),
          ),
        ],
      ),
    );
  }
}

class _TypeChip extends StatelessWidget {
  const _TypeChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      selectedColor: DesignTokens.primaryTint,
      labelStyle: DesignTokens.body2.copyWith(
        color: selected ? DesignTokens.primaryBlue : DesignTokens.textGray,
        fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
      ),
    );
  }
}

class _SizeChip extends StatelessWidget {
  const _SizeChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: DesignTokens.spacingMd,
          vertical: DesignTokens.spacingSm,
        ),
        decoration: BoxDecoration(
          color: selected ? DesignTokens.primaryTint : DesignTokens.white,
          border: Border.all(
            color: selected
                ? DesignTokens.primaryBlue
                : DesignTokens.borderGray,
          ),
          borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
        ),
        child: Text(
          label,
          style: DesignTokens.caption.copyWith(
            color: selected ? DesignTokens.primaryBlue : DesignTokens.textGray,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
