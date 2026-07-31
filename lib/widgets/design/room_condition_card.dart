import 'package:flutter/material.dart';
import '../../config/design_tokens.dart';
import '../../models/design_selection_model.dart';

/// Three texture cards for choosing a surface's baseline [SurfaceCondition]
/// — korobka (brick pattern) / suvoq qilingan (speckled) / shpaklovka
/// qilingan (smooth) — each with a radio mark, per spec's B1 "Xonangiz
/// hozir qaysi holatda?" question.
class RoomConditionCard extends StatelessWidget {
  const RoomConditionCard({
    required this.condition,
    required this.onChanged,
    super.key,
  });

  final SurfaceCondition condition;
  final ValueChanged<SurfaceCondition> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final option in SurfaceCondition.values) ...[
          _TextureOption(
            condition: option,
            selected: option == condition,
            onTap: () => onChanged(option),
          ),
          if (option != SurfaceCondition.values.last)
            const SizedBox(height: DesignTokens.spacingMd),
        ],
      ],
    );
  }
}

class _TextureOption extends StatelessWidget {
  const _TextureOption({
    required this.condition,
    required this.selected,
    required this.onTap,
  });

  final SurfaceCondition condition;
  final bool selected;
  final VoidCallback onTap;

  String get _label => switch (condition) {
    SurfaceCondition.raw => 'Korobka (xom)',
    SurfaceCondition.plastered => 'Suvoq qilingan',
    SurfaceCondition.puttied => 'Shpaklovka qilingan',
  };

  Color get _textureColor => switch (condition) {
    SurfaceCondition.raw => DesignTokens.roomState.korobka,
    SurfaceCondition.plastered => DesignTokens.roomState.suvoq,
    SurfaceCondition.puttied => DesignTokens.roomState.shpaklovka,
  };

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
      child: Container(
        padding: const EdgeInsets.all(DesignTokens.spacingMd),
        decoration: BoxDecoration(
          color: selected ? DesignTokens.primaryTint : DesignTokens.white,
          borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
          border: Border.all(
            color: selected
                ? DesignTokens.primaryBlue
                : DesignTokens.borderGray,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
              child: SizedBox(
                width: 56,
                height: 56,
                child: CustomPaint(
                  painter: _TexturePainter(
                    condition: condition,
                    color: _textureColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: DesignTokens.spacingMd),
            Expanded(child: Text(_label, style: DesignTokens.subtitle2)),
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected
                      ? DesignTokens.primaryBlue
                      : DesignTokens.borderGray,
                  width: 2,
                ),
              ),
              child: selected
                  ? Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          color: DesignTokens.primaryBlue,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

/// Paints a small texture swatch per condition: brick lines for korobka,
/// speckled dots for suvoq, flat/smooth for shpaklovka.
class _TexturePainter extends CustomPainter {
  _TexturePainter({required this.condition, required this.color});

  final SurfaceCondition condition;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = color);

    switch (condition) {
      case SurfaceCondition.raw:
        final brickPaint = Paint()
          ..color = Colors.black.withValues(alpha: 0.12)
          ..strokeWidth = 1;
        const rowHeight = 10.0;
        for (double y = 0; y < size.height; y += rowHeight) {
          canvas.drawLine(Offset(0, y), Offset(size.width, y), brickPaint);
        }
        var offset = 0.0;
        for (double y = 0; y < size.height; y += rowHeight) {
          final startX = offset % 20;
          for (double x = startX; x < size.width; x += 20) {
            canvas.drawLine(Offset(x, y), Offset(x, y + rowHeight), brickPaint);
          }
          offset += 10;
        }
      case SurfaceCondition.plastered:
        final speckPaint = Paint()
          ..color = Colors.black.withValues(alpha: 0.15);
        for (var i = 0; i < 18; i++) {
          final dx = (i * 37) % size.width.toInt();
          final dy = (i * 53) % size.height.toInt();
          canvas.drawCircle(
            Offset(dx.toDouble(), dy.toDouble()),
            1.2,
            speckPaint,
          );
        }
      case SurfaceCondition.puttied:
        break; // Smooth, flat fill only.
    }
  }

  @override
  bool shouldRepaint(_TexturePainter oldDelegate) =>
      oldDelegate.condition != condition || oldDelegate.color != color;
}
