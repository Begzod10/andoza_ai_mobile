import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// The andoza.ai stepladder, put together from its own pieces — rails, rungs,
/// cap, base — while small renovation and design tools (roller, hammer, tape,
/// palette, lamp, …) drift in around it and are drawn into it.
///
/// Driven from outside: [progress] runs 0→1 once for the assembly, [idle]
/// loops 0→1 afterwards (it only adds a soft pulse on the orange rung, so a
/// slow start-up keeps looking alive). Pure paint + transforms, no assets.
class AssemblingLogo extends StatelessWidget {
  const AssemblingLogo({
    required this.progress,
    required this.idle,
    this.size = 260,
    super.key,
  });

  final Animation<double> progress;
  final Animation<double> idle;
  final double size;

  /// What is being built: the work of a renovation and design studio.
  static const List<IconData> tools = [
    Icons.format_paint, // roller
    Icons.handyman_outlined, // hammer + wrench
    Icons.straighten, // ruler / tape
    Icons.palette_outlined, // colours
    Icons.lightbulb_outline, // lighting
    Icons.chair_alt_outlined, // furniture
    Icons.architecture, // plan
    Icons.door_front_door_outlined, // doors and windows
  ];

  @override
  Widget build(BuildContext context) {
    final chip = size * 0.17;
    return SizedBox(
      width: size,
      height: size,
      child: AnimatedBuilder(
        animation: Listenable.merge([progress, idle]),
        builder: (context, _) {
          final t = progress.value;
          return Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: Size.square(size),
                painter: _LadderPainter(t: t, idle: idle.value),
              ),
              for (var i = 0; i < tools.length; i++) _tool(i, t, chip),
            ],
          );
        },
      ),
    );
  }

  Widget _tool(int i, double t, double chip) {
    final n = tools.length;
    // They arrive one after another, hang around the ladder, then are pulled
    // into it one after another as it nears completion.
    final arrive = _iv(t, 0.00 + 0.035 * i, 0.22 + 0.035 * i, Curves.easeOutCubic);
    final pull = _iv(t, 0.48 + 0.030 * i, 0.80 + 0.018 * i, Curves.easeInBack);

    final orbit = size * 0.5;
    final radius = orbit * (1.35 - 0.35 * arrive) * (1 - pull) + orbit * 0.06 * pull;
    // Each tool spirals a little as it settles, and spins the other way as it goes in.
    final angle = (-math.pi / 2) +
        2 * math.pi * i / n +
        (1 - arrive) * 0.9 -
        pull * 1.1;
    final opacity = (arrive * (1 - pull)).clamp(0.0, 1.0);
    if (opacity <= 0.001) return const SizedBox.shrink();
    final scale = (0.45 + 0.55 * arrive) * (1 - 0.8 * pull);

    return Transform.translate(
      offset: Offset(math.cos(angle) * radius, math.sin(angle) * radius),
      child: Opacity(
        opacity: opacity,
        child: Transform.rotate(
          angle: (1 - arrive) * 0.7 + pull * 0.9,
          child: Transform.scale(
            scale: scale,
            child: Container(
              width: chip,
              height: chip,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.07),
                border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
              ),
              child: Icon(tools[i], size: chip * 0.52, color: Colors.white.withValues(alpha: 0.88)),
            ),
          ),
        ),
      ),
    );
  }
}

/// [t] mapped onto the window [a, b] and eased; 0 before it, 1 after.
double _iv(double t, double a, double b, [Curve curve = Curves.easeOut]) =>
    curve.transform(((t - a) / (b - a)).clamp(0.0, 1.0));

class _LadderPainter extends CustomPainter {
  _LadderPainter({required this.t, required this.idle});

  final double t;
  final double idle;

  // The mark's own geometry (512×512 icon space), as in the web app's icon.svg:
  // the artwork is drawn at 0.8 around (256, 254).
  static const _white = Color(0xFFFFFFFF);
  static const _soft = Color(0xFFC7D6FF);
  static const _blue = Color(0xFF9DB8FF);
  static const _orange = Color(0xFFFDBA74);

  @override
  void paint(Canvas canvas, Size size) {
    final k = size.width / 512;
    Offset p(double x, double y) =>
        Offset((256 + 0.8 * (x - 256)) * k, (256 + 0.8 * (y - 254)) * k);
    final w = 0.8 * k; // stroke widths scale with the artwork

    final rail = ui.Gradient.linear(p(0, 96), p(0, 400), [_white, _soft]);

    // Draws [paint] inside a layer that is moved, scaled and faded as one piece.
    void piece({
      required double opacity,
      Offset move = Offset.zero,
      double scaleX = 1,
      double scaleY = 1,
      required Offset about,
      required void Function() draw,
    }) {
      if (opacity <= 0.001) return;
      canvas.save();
      canvas.translate(move.dx, move.dy);
      canvas.translate(about.dx, about.dy);
      canvas.scale(scaleX, scaleY);
      canvas.translate(-about.dx, -about.dy);
      canvas.saveLayer(null, Paint()..color = Colors.white.withValues(alpha: opacity.clamp(0.0, 1.0)));
      draw();
      canvas.restore();
      canvas.restore();
    }

    Paint stroke(Color c, double width, {Shader? shader}) => Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = width
      ..color = c
      ..shader = shader;

    final s = size.width;

    // Rails: the left one comes in from the left, the right one from the right.
    final l = _iv(t, 0.08, 0.42, Curves.easeOutCubic);
    piece(
      opacity: l * 1.6,
      move: Offset(-0.5 * s * (1 - l), 0.12 * s * (1 - l)),
      about: p(112, 400),
      draw: () => canvas.drawLine(p(216, 96), p(112, 400), stroke(_white, 42 * w, shader: rail)),
    );
    final r = _iv(t, 0.14, 0.48, Curves.easeOutCubic);
    piece(
      opacity: r * 1.6,
      move: Offset(0.5 * s * (1 - r), 0.12 * s * (1 - r)),
      about: p(400, 400),
      draw: () => canvas.drawLine(p(296, 96), p(400, 400), stroke(_white, 42 * w, shader: rail)),
    );

    // Rungs slide in from alternating sides and snap to length.
    final r1 = _iv(t, 0.38, 0.62, Curves.easeOutBack);
    piece(
      opacity: r1 * 2,
      move: Offset(-0.6 * s * (1 - r1), 0),
      scaleX: 0.3 + 0.7 * r1.clamp(0.0, 1.2),
      about: p(256, 187),
      draw: () => canvas.drawLine(p(184.9, 187), p(327.1, 187), stroke(_blue, 32 * w)),
    );
    final r2 = _iv(t, 0.50, 0.74, Curves.easeOutBack);
    piece(
      opacity: r2 * 2,
      move: Offset(0.6 * s * (1 - r2), 0),
      scaleX: 0.3 + 0.7 * r2.clamp(0.0, 1.2),
      scaleY: 1 + 0.25 * math.sin(math.pi * _iv(t, 0.70, 0.84)), // a little pop when it lands
      about: p(256, 269),
      draw: () => canvas.drawLine(p(156.8, 269), p(355.2, 269), stroke(_orange, 32 * w)),
    );
    final r3 = _iv(t, 0.58, 0.82, Curves.easeOutBack);
    piece(
      opacity: r3 * 2,
      move: Offset(-0.6 * s * (1 - r3), 0),
      scaleX: 0.3 + 0.7 * r3.clamp(0.0, 1.2),
      about: p(256, 351),
      draw: () => canvas.drawLine(p(128.8, 351), p(383.2, 351), stroke(_blue, 32 * w)),
    );

    // The cap drops on last and bounces.
    final cap = _iv(t, 0.68, 0.92, Curves.bounceOut);
    piece(
      opacity: cap * 4,
      move: Offset(0, -0.45 * s * (1 - cap)),
      about: p(256, 77),
      draw: () {
        final rect = Rect.fromPoints(p(186, 58), p(326, 96));
        canvas.drawRRect(
          RRect.fromRectAndRadius(rect, Radius.circular(19 * w)),
          Paint()..shader = rail,
        );
      },
    );

    // Ground line draws out from the middle; its shadow fades in.
    final base = _iv(t, 0.82, 0.97);
    piece(
      opacity: base,
      scaleX: base,
      about: p(256, 436),
      draw: () {
        canvas.drawOval(
          Rect.fromCenter(center: p(256, 436), width: 340 * w, height: 26 * w),
          Paint()..color = _white.withValues(alpha: 0.16),
        );
        canvas.drawLine(p(84, 436), p(428, 436), stroke(_white.withValues(alpha: 0.55), 12 * w));
      },
    );

    // A ring leaves the finished mark.
    final ring = _iv(t, 0.88, 1.0);
    if (ring > 0 && ring < 1) {
      canvas.drawCircle(
        size.center(Offset.zero),
        s * (0.26 + 0.38 * ring),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = _orange.withValues(alpha: 0.55 * (1 - ring)),
      );
    }

    // Once built it keeps breathing on the orange rung.
    if (t >= 0.999) {
      final glow = 0.5 + 0.5 * math.sin(idle * 2 * math.pi);
      canvas.drawLine(
        p(156.8, 269),
        p(355.2, 269),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 32 * w
          ..color = _orange.withValues(alpha: 0.10 + 0.22 * glow)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10 * w),
      );
      canvas.drawLine(p(156.8, 269), p(355.2, 269), stroke(_orange, 32 * w));
    }
  }

  @override
  bool shouldRepaint(_LadderPainter old) => old.t != t || old.idle != idle;
}
