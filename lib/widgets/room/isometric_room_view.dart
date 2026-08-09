import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../config/design_tokens.dart';
import '../../models/room_model.dart';

/// An isometric preview of a rectangular room (open-top box) with the currently
/// active wall highlighted — the signature visual of the capture wizard.
///
/// [widthM] runs along walls B/D, [depthM] along walls A/C, [heightM] up.
/// [activeWall] (if any) is drawn in the accent colour; pass null on the
/// ceiling/summary steps to show the whole room neutrally.
class IsometricRoomView extends StatelessWidget {
  const IsometricRoomView({
    required this.widthM,
    required this.depthM,
    required this.heightM,
    this.activeWall,
    super.key,
  });

  final double widthM;
  final double depthM;
  final double heightM;
  final WallType? activeWall;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: _IsometricRoomPainter(
        widthM: widthM,
        depthM: depthM,
        heightM: heightM,
        activeWall: activeWall,
      ),
    );
  }
}

class _IsometricRoomPainter extends CustomPainter {
  _IsometricRoomPainter({
    required this.widthM,
    required this.depthM,
    required this.heightM,
    required this.activeWall,
  });

  final double widthM;
  final double depthM;
  final double heightM;
  final WallType? activeWall;

  static const _cos30 = 0.8660254; // cos(30°)
  static const _sin30 = 0.5; // sin(30°)

  @override
  void paint(Canvas canvas, Size size) {
    // Normalise so the largest floor dimension is 1.0, keeping aspect ratio.
    final maxDim = math.max(widthM, depthM).clamp(0.1, double.infinity);
    final w = widthM / maxDim;
    final d = depthM / maxDim;
    // Height is drawn shorter than reality so a tall room still fits nicely.
    final h = (heightM / maxDim) * 0.85;

    // Pick a scale + origin that fits the projected box inside the canvas.
    final projected = <Offset>[
      for (final z in [0.0, h])
        for (final p in [
          const Offset(0, 0),
          Offset(w, 0),
          Offset(w, d),
          Offset(0, d),
        ])
          _rawIso(p.dx, p.dy, z),
    ];
    var minX = double.infinity, maxX = -double.infinity;
    var minY = double.infinity, maxY = -double.infinity;
    for (final p in projected) {
      minX = math.min(minX, p.dx);
      maxX = math.max(maxX, p.dx);
      minY = math.min(minY, p.dy);
      maxY = math.max(maxY, p.dy);
    }
    const pad = 24.0;
    final scale = math.min(
      (size.width - 2 * pad) / (maxX - minX),
      (size.height - 2 * pad) / (maxY - minY),
    );
    final origin = Offset(
      pad - minX * scale + (size.width - 2 * pad - (maxX - minX) * scale) / 2,
      pad - minY * scale + (size.height - 2 * pad - (maxY - minY) * scale) / 2,
    );

    Offset iso(double x, double y, double z) => origin + _rawIso(x, y, z) * scale;

    // Floor corners (z=0) and top corners (z=h).
    final f00 = iso(0, 0, 0), f10 = iso(w, 0, 0), f11 = iso(w, d, 0), f01 = iso(0, d, 0);
    final t00 = iso(0, 0, h), t10 = iso(w, 0, h), t11 = iso(w, d, h), t01 = iso(0, d, h);

    // Floor.
    canvas.drawPath(
      Path()..addPolygon([f00, f10, f11, f01], true),
      Paint()..color = DesignTokens.primaryBlue.withValues(alpha: 0.06),
    );

    // Each wall = its two base corners + two top corners. Order matters for a
    // convincing look: draw the two far/back walls (A along y=d, D along x=0),
    // then the two near walls (B along x=w, C along y=0).
    final walls = <WallType, List<Offset>>{
      WallType.wallA: [f01, f11, t11, t01], // far wall (y = depth)
      WallType.wallD: [f00, f01, t01, t00], // left wall (x = 0)
      WallType.wallB: [f10, f11, t11, t10], // right wall (x = width)
      WallType.wallC: [f00, f10, t10, t00], // near wall (y = 0)
    };

    // Back walls first (A, D), then near walls (C, B) on top.
    for (final type in [WallType.wallA, WallType.wallD, WallType.wallC, WallType.wallB]) {
      _drawWall(canvas, walls[type]!, isActive: type == activeWall,
          isBack: type == WallType.wallA || type == WallType.wallD);
      _drawWallLabel(canvas, walls[type]!, _shortLabel(type),
          isActive: type == activeWall);
    }

    // Dashed ceiling outline (open top).
    _drawDashedPolygon(canvas, [t00, t10, t11, t01]);
  }

  Offset _rawIso(double x, double y, double z) =>
      Offset((x - y) * _cos30, (x + y) * _sin30 - z);

  void _drawWall(Canvas canvas, List<Offset> quad,
      {required bool isActive, required bool isBack}) {
    final fill = isActive
        ? DesignTokens.accentOrange.withValues(alpha: 0.32)
        : DesignTokens.successGreen.withValues(alpha: isBack ? 0.28 : 0.16);
    final stroke = isActive
        ? DesignTokens.accentOrange
        : DesignTokens.successGreen.withValues(alpha: 0.55);
    final path = Path()..addPolygon(quad, true);
    canvas.drawPath(path, Paint()..color = fill);
    canvas.drawPath(
      path,
      Paint()
        ..color = stroke
        ..style = PaintingStyle.stroke
        ..strokeWidth = isActive ? 2.2 : 1.2,
    );
  }

  void _drawWallLabel(Canvas canvas, List<Offset> quad, String text,
      {required bool isActive}) {
    final center = Offset(
      (quad[0].dx + quad[1].dx + quad[2].dx + quad[3].dx) / 4,
      (quad[0].dy + quad[1].dy + quad[2].dy + quad[3].dy) / 4,
    );
    final tp = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: isActive
              ? DesignTokens.accentOrange
              : DesignTokens.textMuted,
        ),
      ),
    )..layout();
    tp.paint(canvas, center - Offset(tp.width / 2, tp.height / 2));
  }

  void _drawDashedPolygon(Canvas canvas, List<Offset> pts) {
    final paint = Paint()
      ..color = DesignTokens.primaryBlue.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    const dash = 6.0, gap = 4.0;
    for (var i = 0; i < pts.length; i++) {
      final a = pts[i], b = pts[(i + 1) % pts.length];
      final total = (b - a).distance;
      final dir = (b - a) / total;
      var t = 0.0;
      while (t < total) {
        final start = a + dir * t;
        final end = a + dir * math.min(t + dash, total);
        canvas.drawLine(start, end, paint);
        t += dash + gap;
      }
    }
  }

  String _shortLabel(WallType t) => switch (t) {
        WallType.wallA => 'A',
        WallType.wallB => 'B',
        WallType.wallC => 'C',
        WallType.wallD => 'D',
      };

  @override
  bool shouldRepaint(_IsometricRoomPainter old) =>
      old.widthM != widthM ||
      old.depthM != depthM ||
      old.heightM != heightM ||
      old.activeWall != activeWall;
}
