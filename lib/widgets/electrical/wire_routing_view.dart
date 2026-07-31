import 'package:flutter/material.dart';
import '../../config/design_tokens.dart';
import '../../models/electrical_model.dart';

/// Displays 2D plan with wire and pipe routing overlays
class WireRoutingView extends StatelessWidget {
  const WireRoutingView({
    required this.width,
    required this.length,
    required this.layout,
    super.key,
  });

  final double width;
  final double length;
  final ElectricalLayout layout;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: DesignTokens.border),
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
      ),
      child: CustomPaint(
        painter: WireRoutingPainter(
          layout: layout,
          width: width,
          length: length,
        ),
        size: Size.fromHeight(300),
      ),
    );
  }
}

class WireRoutingPainter extends CustomPainter {
  WireRoutingPainter({
    required this.layout,
    required this.width,
    required this.length,
  });

  final ElectricalLayout layout;
  final double width;
  final double length;

  @override
  void paint(Canvas canvas, Size size) {
    // Draw room outline
    _drawRoomOutline(canvas, size);

    // Draw wires
    _drawWires(canvas, size);

    // Draw pipes
    _drawPipes(canvas, size);

    // Draw devices
    _drawDevices(canvas, size);
  }

  void _drawRoomOutline(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = DesignTokens.text.withValues(alpha: 0.3)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rect, paint);
  }

  void _drawWires(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = DesignTokens.primaryBlue
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    for (final wire in layout.wires) {
      final from = _scaleOffset(wire.from, size);
      final to = _scaleOffset(wire.to, size);
      canvas.drawLine(from, to, paint);
    }
  }

  void _drawPipes(Canvas canvas, Size size) {
    final hotPaint = Paint()
      ..color = DesignTokens.accentOrange
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    final coldPaint = Paint()
      ..color = DesignTokens.primaryBlue
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    for (final pipe in layout.pipes) {
      final from = _scaleOffset(pipe.from, size);
      final to = _scaleOffset(pipe.to, size);

      if (pipe.type == PipeType.hot) {
        canvas.drawLine(from, to, hotPaint);
      } else {
        canvas.drawLine(from, to, coldPaint);
      }
    }
  }

  void _drawDevices(Canvas canvas, Size size) {
    for (final device in layout.devices) {
      final pos = _scaleOffset(device.position, size);
      _drawDevice(canvas, pos, device);
    }
  }

  void _drawDevice(Canvas canvas, Offset position, ElectricalDevice device) {
    final paint = Paint()
      ..color = _getDeviceColor(device.type)
      ..style = PaintingStyle.fill;

    final size = 12.0;
    canvas.drawRect(
      Rect.fromCenter(center: position, width: size, height: size),
      paint,
    );

    // Label
    final tp = TextPainter(
      text: TextSpan(
        text: device.type.toString().split('.').last[0].toUpperCase(),
        style: const TextStyle(color: Colors.white, fontSize: 8),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, position - Offset(tp.width / 2, tp.height / 2));
  }

  Color _getDeviceColor(DeviceType type) {
    switch (type) {
      case DeviceType.outlet:
        return DesignTokens.primaryBlue;
      case DeviceType.lightSwitch:
        return DesignTokens.accentOrange;
      case DeviceType.light:
        return Colors.amber;
      case DeviceType.breaker:
        return Colors.green;
    }
  }

  Offset _scaleOffset(Offset offset, Size canvasSize) {
    return Offset(
      (offset.dx / width) * canvasSize.width,
      (offset.dy / length) * canvasSize.height,
    );
  }

  @override
  bool shouldRepaint(WireRoutingPainter oldDelegate) {
    return oldDelegate.layout != layout ||
        oldDelegate.width != width ||
        oldDelegate.length != length;
  }
}
