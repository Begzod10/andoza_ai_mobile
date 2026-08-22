import 'package:flutter/material.dart';
import '../../config/design_tokens.dart';
import '../../models/design_selection_model.dart';

/// B1-alt: optional sheet for when the floor or ceiling differs from the
/// wall condition — "Pol yoki shift boshqacha bo'lsa →" from B1.
class B1AltSurfaceSheet extends StatefulWidget {
  const B1AltSurfaceSheet({
    required this.initialFloor,
    required this.initialCeiling,
    required this.onSave,
    super.key,
  });

  final SurfaceCondition initialFloor;
  final SurfaceCondition initialCeiling;
  final void Function(SurfaceCondition floor, SurfaceCondition ceiling) onSave;

  @override
  State<B1AltSurfaceSheet> createState() => _B1AltSurfaceSheetState();
}

class _B1AltSurfaceSheetState extends State<B1AltSurfaceSheet> {
  late SurfaceCondition _floor = widget.initialFloor;
  late SurfaceCondition _ceiling = widget.initialCeiling;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: DesignTokens.screenPaddingHorizontal,
        right: DesignTokens.screenPaddingHorizontal,
        top: DesignTokens.spacingMd,
        bottom:
            MediaQuery.of(context).viewInsets.bottom + DesignTokens.spacingLg,
      ),
      decoration: const BoxDecoration(
        color: DesignTokens.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(DesignTokens.radiusSheet),
          topRight: Radius.circular(DesignTokens.radiusSheet),
        ),
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
          const Text('Pol', style: DesignTokens.subtitle2),
          const SizedBox(height: DesignTokens.spacingSm),
          _CompactRow(
            options: const {
              SurfaceCondition.raw: 'Xom beton',
              SurfaceCondition.plastered: 'Styajka',
              SurfaceCondition.puttied: 'Qoplama bor',
            },
            selected: _floor,
            onSelected: (v) => setState(() => _floor = v),
          ),
          const SizedBox(height: DesignTokens.spacingLg),
          const Text('Shift', style: DesignTokens.subtitle2),
          const SizedBox(height: DesignTokens.spacingSm),
          _CompactRow(
            options: const {
              SurfaceCondition.raw: 'Xom',
              SurfaceCondition.plastered: 'Suvoq',
              SurfaceCondition.puttied: 'Tayyor',
            },
            selected: _ceiling,
            onSelected: (v) => setState(() => _ceiling = v),
          ),
          const SizedBox(height: DesignTokens.spacingLg),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                widget.onSave(_floor, _ceiling);
                Navigator.of(context).pop();
              },
              child: const Text('Saqlash'),
            ),
          ),
        ],
      ),
    );
  }
}

class _CompactRow extends StatelessWidget {
  const _CompactRow({
    required this.options,
    required this.selected,
    required this.onSelected,
  });

  final Map<SurfaceCondition, String> options;
  final SurfaceCondition selected;
  final ValueChanged<SurfaceCondition> onSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final entry in options.entries) ...[
          Expanded(
            child: GestureDetector(
              onTap: () => onSelected(entry.key),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: DesignTokens.spacingSm,
                ),
                decoration: BoxDecoration(
                  color: entry.key == selected
                      ? DesignTokens.primaryTint
                      : DesignTokens.white,
                  border: Border.all(
                    color: entry.key == selected
                        ? DesignTokens.primaryBlue
                        : DesignTokens.borderGray,
                  ),
                  borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                ),
                child: Text(
                  entry.value,
                  textAlign: TextAlign.center,
                  style: DesignTokens.caption.copyWith(
                    color: entry.key == selected
                        ? DesignTokens.primaryBlue
                        : DesignTokens.textGray,
                    fontWeight: entry.key == selected
                        ? FontWeight.w700
                        : FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
          if (entry.key != options.keys.last)
            const SizedBox(width: DesignTokens.spacingSm),
        ],
      ],
    );
  }
}
