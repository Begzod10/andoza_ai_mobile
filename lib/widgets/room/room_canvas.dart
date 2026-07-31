import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../config/design_tokens.dart';
import '../../models/room_model.dart';

/// 2D top-down room rendering with walls, doors, windows, and furniture
class RoomCanvas extends StatefulWidget {
  const RoomCanvas({
    required this.room,
    required this.onItemSelected,
    this.selectedItemId,
    this.scale = 1.0,
    super.key,
  });

  final Room room;
  final ValueChanged<String> onItemSelected;
  final String? selectedItemId;
  final double scale;

  @override
  State<RoomCanvas> createState() => _RoomCanvasState();
}

class _RoomCanvasState extends State<RoomCanvas> {
  late Offset _panOffset;
  double _zoomLevel = 1.0;

  @override
  void initState() {
    super.initState();
    _panOffset = Offset.zero;
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    setState(() {
      _panOffset += details.delta;
    });
  }

  void _handleScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      _zoomLevel = (_zoomLevel * details.scale).clamp(0.5, 3.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _handlePanUpdate,
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
            child: CustomPaint(
              painter: RoomCanvasPainter(
                room: widget.room,
                selectedItemId: widget.selectedItemId,
                onItemSelected: widget.onItemSelected,
              ),
              size: Size(
                widget.room.dimensions.width * 100,
                widget.room.dimensions.length * 100,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RoomCanvasPainter extends CustomPainter {
  RoomCanvasPainter({
    required this.room,
    required this.selectedItemId,
    required this.onItemSelected,
  });

  final Room room;
  final String? selectedItemId;
  final Function(String) onItemSelected;

  static const double scale = 100; // pixels per meter

  @override
  void paint(Canvas canvas, Size size) {
    // Draw background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = DesignTokens.surface,
    );

    // Draw grid
    _drawGrid(canvas, size);

    // Draw walls
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
      ..strokeJoin = StrokeJoin.round;

    // Draw room perimeter
    canvas.drawLine(Offset(0, 0), Offset(size.width, 0), wallPaint);
    canvas.drawLine(
        Offset(size.width, 0), Offset(size.width, size.height), wallPaint);
    canvas.drawLine(Offset(size.width, size.height), Offset(0, size.height),
        wallPaint);
    canvas.drawLine(Offset(0, size.height), Offset(0, 0), wallPaint);
  }

  void _drawDoors(Canvas canvas, Size size) {
    for (final door in room.doors) {
      // Position door along the wall (position is 0.0-1.0 fraction)
      final doorX = door.position * size.width;
      final pos = Offset(doorX, 0); // Assume door is on top wall for now

      // Draw door swing arc
      final arcPaint = Paint()
        ..color = DesignTokens.primaryBlue.withValues(alpha: 0.5)
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke;

      const arcRadius = 30.0;
      final rect =
          Rect.fromCircle(center: pos, radius: arcRadius);
      canvas.drawArc(rect, 0, math.pi / 2, false, arcPaint);

      // Draw door handle
      final handlePaint = Paint()
        ..color = DesignTokens.primaryBlue
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
        pos + Offset(arcRadius, 0),
        4,
        handlePaint,
      );
    }
  }

  void _drawWindows(Canvas canvas, Size size) {
    final windowPaint = Paint()
      ..color = DesignTokens.accentOrange.withValues(alpha: 0.6)
      ..strokeWidth = 4;

    for (final window in room.windows) {
      // Position window along the wall (position is 0.0-1.0 fraction)
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
    textPainter.paint(canvas, Offset(size.width / 2 - textPainter.width / 2, 10));
  }

  void _drawDimensions(Canvas canvas, Size size) {
    final dimPaint = Paint()
      ..color = DesignTokens.textSecondary
      ..strokeWidth = 1;

    const padding = 30.0;
    const fontSize = 12.0;

    // Width dimension
    canvas.drawLine(
      Offset(padding, -padding),
      Offset(size.width - padding, -padding),
      dimPaint,
    );

    final widthText = TextPainter(
      text: TextSpan(
        text: '${room.dimensions.width.toStringAsFixed(1)}m',
        style: const TextStyle(color: DesignTokens.textSecondary, fontSize: fontSize),
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
      Offset(-padding, padding),
      Offset(-padding, size.height - padding),
      dimPaint,
    );

    final lengthText = TextPainter(
      text: TextSpan(
        text: '${room.dimensions.length.toStringAsFixed(1)}m',
        style: const TextStyle(color: DesignTokens.textSecondary, fontSize: fontSize),
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
        oldDelegate.selectedItemId != selectedItemId;
  }
}
