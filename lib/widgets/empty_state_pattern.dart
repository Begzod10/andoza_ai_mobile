import 'package:flutter/material.dart';
import '../config/design_tokens.dart';

/// E11: Bo'sh holatlar — the one reusable empty-state pattern used
/// everywhere the app has nothing to show yet ("Hali loyiha yo'q",
/// "Buyurtma yo'q", "Saqlangan dizayn yo'q", etc.): dashed card, icon
/// tile, title, one-line explanation, single action button.
class EmptyStatePattern extends StatelessWidget {
  const EmptyStatePattern({
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
    super.key,
  });

  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(
        color: DesignTokens.borderGray,
        radius: DesignTokens.radiusXl,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(DesignTokens.spacingLg),
        child: Column(
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: DesignTokens.borderGrayAlt,
                borderRadius: BorderRadius.circular(DesignTokens.radiusXl),
              ),
              child: Icon(
                icon,
                size: DesignTokens.iconXxl,
                color: DesignTokens.primaryBlue,
              ),
            ),
            const SizedBox(height: DesignTokens.spacingMd),
            Text(
              title,
              style: DesignTokens.subtitle1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: DesignTokens.spacingSm),
            Text(
              message,
              style: DesignTokens.body2,
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: DesignTokens.spacingMd),
              ElevatedButton(onPressed: onAction, child: Text(actionLabel!)),
            ],
          ],
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  const _DashedBorderPainter({required this.color, required this.radius});

  final Color color;
  final double radius;
  static const dashWidth = 6.0;
  static const gapWidth = 5.0;
  static const strokeWidth = 2.0;

  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        strokeWidth / 2,
        strokeWidth / 2,
        size.width - strokeWidth,
        size.height - strokeWidth,
      ),
      Radius.circular(radius),
    );
    final path = Path()..addRRect(rrect);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        final next = distance + dashWidth;
        canvas.drawPath(
          metric.extractPath(distance, next.clamp(0, metric.length)),
          paint,
        );
        distance = next + gapWidth;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.radius != radius;
}
