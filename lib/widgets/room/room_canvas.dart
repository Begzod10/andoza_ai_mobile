import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../config/design_tokens.dart';
import '../../models/room_model.dart';
import '../../models/room_plan.dart';

/// 2D top-down room rendering with walls, doors, windows, and furniture.
///
/// When a [plan] is supplied its true polygon [RoomPlan.corners] are drawn
/// (an L-shape renders as an L-shape, a trapezoid as a trapezoid, …) and each
/// opening is placed on its actual wall. Without a plan the widget falls back to
/// the legacy bounding rectangle derived from [room]'s dimensions, with doors on
/// the top wall (the historical behaviour).
class RoomCanvas extends StatefulWidget {
  const RoomCanvas({
    required this.room,
    required this.onItemSelected,
    this.plan,
    this.selectedItemId,
    this.scale = 1.0,
    super.key,
  });

  final Room room;

  /// The true polygon plan, when available. Preferred over [room]'s bounding
  /// rectangle for rendering the actual room outline.
  final RoomPlan? plan;
  final ValueChanged<String> onItemSelected;
  final String? selectedItemId;
  final double scale;

  @override
  State<RoomCanvas> createState() => _RoomCanvasState();
}

class _RoomCanvasState extends State<RoomCanvas> {
  Offset _panOffset = Offset.zero;
  double _zoomLevel = 1.0;
  double _baseZoom = 1.0;

  // Scale is a superset of pan: a one-finger drag reports focalPointDelta with
  // scale == 1.0, a pinch reports the scale factor. Using a single scale
  // recognizer avoids the redundant pan+scale gesture-arena conflict.
  void _handleScaleStart(ScaleStartDetails details) {
    _baseZoom = _zoomLevel;
  }

  void _handleScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      _panOffset += details.focalPointDelta;
      _zoomLevel = (_baseZoom * details.scale).clamp(0.5, 3.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final painter = RoomCanvasPainter(
      room: widget.room,
      plan: widget.plan,
      selectedItemId: widget.selectedItemId,
      onItemSelected: widget.onItemSelected,
    );
    return GestureDetector(
      onScaleStart: _handleScaleStart,
      onScaleUpdate: _handleScaleUpdate,
      child: Container(
        decoration: BoxDecoration(
          color: DesignTokens.surface,
          border: Border.all(color: DesignTokens.border),
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        ),
        child: Transform.translate(
          offset: _panOffset,
          child: Transform.scale(
            scale: _zoomLevel,
            child: RepaintBoundary(
              child: CustomPaint(
                painter: painter,
                size: painter.canvasSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A single opening (door/window) resolved onto its actual wall for drawing.
class RoomCanvasOpening {
  /// Centre of the opening, in canvas pixels.
  final Offset centerPx;

  /// Unit vector along the wall the opening sits on, in canvas pixels.
  final Offset dirPx;

  /// Opening width in pixels.
  final double widthPx;

  final bool isWindow;

  const RoomCanvasOpening({
    required this.centerPx,
    required this.dirPx,
    required this.widthPx,
    required this.isWindow,
  });
}

class RoomCanvasPainter extends CustomPainter {
  RoomCanvasPainter({
    required this.room,
    required this.selectedItemId,
    required this.onItemSelected,
    this.plan,
  })  : outlineCornersM = computeOutlineM(plan, room),
        _openings = plan != null ? _resolvePlanOpenings(plan) : null;

  final Room room;
  final RoomPlan? plan;
  final String? selectedItemId;
  final Function(String) onItemSelected;

  /// The room outline in METRES, translated so the min corner sits at (0, 0).
  /// A plain rectangle yields 4 corners; an L-shape yields 6, etc.
  final List<Offset> outlineCornersM;

  /// Openings resolved onto their actual walls (from the plan), or null for the
  /// legacy rectangle fallback (which draws doors/windows on the top wall).
  final List<RoomCanvasOpening>? _openings;

  static const double scale = 100; // pixels per meter

  /// Computes the room outline (metres, origin-normalised) preferring the true
  /// polygon [plan] over [room]'s bounding rectangle.
  static List<Offset> computeOutlineM(RoomPlan? plan, Room room) {
    if (plan != null && plan.corners.length >= 3) {
      var minX = plan.corners.first.x;
      var minY = plan.corners.first.y;
      for (final c in plan.corners) {
        minX = math.min(minX, c.x);
        minY = math.min(minY, c.y);
      }
      return [
        for (final c in plan.corners) Offset(c.x - minX, c.y - minY),
      ];
    }
    final w = room.dimensions.width;
    final l = room.dimensions.length;
    return [
      const Offset(0, 0),
      Offset(w, 0),
      Offset(w, l),
      Offset(0, l),
    ];
  }

  static List<RoomCanvasOpening> _resolvePlanOpenings(RoomPlan plan) {
    var minX = plan.corners.first.x;
    var minY = plan.corners.first.y;
    for (final c in plan.corners) {
      minX = math.min(minX, c.x);
      minY = math.min(minY, c.y);
    }
    final out = <RoomCanvasOpening>[];
    for (final wall in plan.walls) {
      if (wall.a >= plan.corners.length || wall.b >= plan.corners.length) {
        continue;
      }
      final a = plan.corners[wall.a];
      final b = plan.corners[wall.b];
      final ax = (a.x - minX) * scale, ay = (a.y - minY) * scale;
      final bx = (b.x - minX) * scale, by = (b.y - minY) * scale;
      final dx = bx - ax, dy = by - ay;
      final len = math.sqrt(dx * dx + dy * dy);
      final dir = len == 0 ? const Offset(1, 0) : Offset(dx / len, dy / len);
      for (final o in wall.openings) {
        out.add(RoomCanvasOpening(
          centerPx: Offset(ax + dx * o.position, ay + dy * o.position),
          dirPx: dir,
          widthPx: o.width * scale,
          isWindow: o.type == 'window',
        ));
      }
    }
    return out;
  }

  /// Bounding size of the outline in pixels.
  Size get canvasSize {
    var maxX = 0.0, maxY = 0.0;
    for (final c in outlineCornersM) {
      maxX = math.max(maxX, c.dx);
      maxY = math.max(maxY, c.dy);
    }
    return Size(maxX * scale, maxY * scale);
  }

  /// The outline as a closed path in canvas pixels.
  List<Offset> get outlineCornersPx =>
      [for (final c in outlineCornersM) c * scale];

  @override
  void paint(Canvas canvas, Size size) {
    // Draw background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = DesignTokens.surface,
    );

    // Draw grid
    _drawGrid(canvas, size);

    // Draw walls (true polygon outline)
    _drawWalls(canvas, size);

    // Draw doors
    _drawDoors(canvas, size);

    // Draw windows
    _drawWindows(canvas, size);

    // Draw furniture (if available in design selection)
    _drawFurniture(canvas, size);

    // Draw dimensions
    _drawDimensions(canvas, size);
  }

  void _drawGrid(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = DesignTokens.border.withValues(alpha: 0.2)
      ..strokeWidth = 0.5;

    const gridSpacing = 20.0; // 0.2m grid

    for (double x = 0; x <= size.width; x += gridSpacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }

    for (double y = 0; y <= size.height; y += gridSpacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
  }

  void _drawWalls(Canvas canvas, Size size) {
    final wallPaint = Paint()
      ..color = DesignTokens.text
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    // Draw the actual room perimeter as a closed polygon.
    final pts = outlineCornersPx;
    if (pts.length < 2) return;
    final path = Path()..addPolygon(pts, true);
    canvas.drawPath(path, wallPaint);
  }

  void _drawDoors(Canvas canvas, Size size) {
    final arcPaint = Paint()
      ..color = DesignTokens.primaryBlue.withValues(alpha: 0.5)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    final handlePaint = Paint()
      ..color = DesignTokens.primaryBlue
      ..style = PaintingStyle.fill;
    const arcRadius = 30.0;

    if (_openings != null) {
      // Plan path: place each door on its actual wall.
      for (final o in _openings.where((o) => !o.isWindow)) {
        final rect = Rect.fromCircle(center: o.centerPx, radius: arcRadius);
        canvas.drawArc(rect, 0, math.pi / 2, false, arcPaint);
        canvas.drawCircle(
          o.centerPx + o.dirPx * arcRadius,
          4,
          handlePaint,
        );
      }
      return;
    }

    // Legacy fallback: doors along the top wall (position is a 0..1 fraction).
    for (final door in room.doors) {
      final pos = Offset(door.position * size.width, 0);
      final rect = Rect.fromCircle(center: pos, radius: arcRadius);
      canvas.drawArc(rect, 0, math.pi / 2, false, arcPaint);
      canvas.drawCircle(pos + const Offset(arcRadius, 0), 4, handlePaint);
    }
  }

  void _drawWindows(Canvas canvas, Size size) {
    final windowPaint = Paint()
      ..color = DesignTokens.accentOrange.withValues(alpha: 0.6)
      ..strokeWidth = 4;

    if (_openings != null) {
      // Plan path: draw each window as a segment along its actual wall.
      for (final o in _openings.where((o) => o.isWindow)) {
        final half = o.dirPx * (o.widthPx / 2);
        canvas.drawLine(o.centerPx - half, o.centerPx + half, windowPaint);
      }
      return;
    }

    // Legacy fallback: windows along the top wall.
    for (final window in room.windows) {
      final windowX = window.position * size.width;
      const windowSize = 20.0;
      canvas.drawLine(
        Offset(windowX - windowSize / 2, 0),
        Offset(windowX + windowSize / 2, 0),
        windowPaint,
      );
    }
  }

  void _drawFurniture(Canvas canvas, Size size) {
    // Furniture would be drawn from design selection in real impl
    // For now, just draw placeholder
    final textPainter = TextPainter(
      text: const TextSpan(
        text: 'Furniture layer',
        style: TextStyle(color: Colors.grey, fontSize: 12),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(size.width / 2 - textPainter.width / 2, 10),
    );
  }

  void _drawDimensions(Canvas canvas, Size size) {
    final dimPaint = Paint()
      ..color = DesignTokens.textSecondary
      ..strokeWidth = 1;

    const padding = 30.0;
    const fontSize = 12.0;

    // Width dimension
    canvas.drawLine(
      const Offset(padding, -padding),
      Offset(size.width - padding, -padding),
      dimPaint,
    );

    final widthText = TextPainter(
      text: TextSpan(
        text: '${room.dimensions.width.toStringAsFixed(1)}m',
        style: const TextStyle(
          color: DesignTokens.textSecondary,
          fontSize: fontSize,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    widthText.layout();
    widthText.paint(
      canvas,
      Offset(size.width / 2 - widthText.width / 2, -padding - 20),
    );

    // Length dimension
    canvas.drawLine(
      const Offset(-padding, padding),
      Offset(-padding, size.height - padding),
      dimPaint,
    );

    final lengthText = TextPainter(
      text: TextSpan(
        text: '${room.dimensions.length.toStringAsFixed(1)}m',
        style: const TextStyle(
          color: DesignTokens.textSecondary,
          fontSize: fontSize,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    lengthText.layout();
    canvas.save();
    canvas.translate(-padding - 15, size.height / 2);
    canvas.rotate(-math.pi / 2);
    lengthText.paint(canvas, Offset(-lengthText.width / 2, 0));
    canvas.restore();
  }

  @override
  bool shouldRepaint(RoomCanvasPainter oldDelegate) {
    return oldDelegate.room != room ||
        oldDelegate.plan != plan ||
        oldDelegate.selectedItemId != selectedItemId;
  }
}
