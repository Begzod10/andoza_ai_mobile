import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../config/design_tokens.dart';
import 'iso_projector.dart';

/// An isometric preview of a room prism (open-top box). [IsometricRoomView.polygon]
/// renders an arbitrary N-corner room with an orbit angle and per-edge length
/// labels, backed by [IsoProjector]. [heightM] runs up.
class IsometricRoomView extends StatelessWidget {
  /// Arbitrary N-corner room preview. [floorCornersM] are the floor polygon
  /// corners in METRES (x = Offset.dx, y = Offset.dy). Edges are labelled with
  /// their length when [showEdgeLengths] is true, or with [fixedLabels] (one per
  /// edge) when provided — the latter lets the 3D wizard keep its A/B/C/D wall
  /// letters. [orbitRad] rotates the floor around its centroid. [activeEdge]
  /// highlights that edge's wall in the accent colour (the wizard's active-wall
  /// highlight).
  const IsometricRoomView.polygon({
    required List<Offset> floorCornersM,
    required this.heightM,
    this.orbitRad = 0,
    this.showEdgeLengths = true,
    this.activeCorner,
    this.activeEdge,
    this.fixedLabels,
    this.zoom = 1.0,
    super.key,
  }) :
        // Private field can't be a named initialising formal.
        // ignore: prefer_initializing_formals
        _floorCornersM = floorCornersM;

  final double heightM;
  final double orbitRad;
  final bool showEdgeLengths;
  final int? activeCorner;

  /// Polygon-path active-wall highlight: the index of the edge to draw in the
  /// accent colour (null = none).
  final int? activeEdge;

  /// Polygon-path explicit per-edge labels (e.g. A/B/C/D). When null the edge
  /// length is shown if [showEdgeLengths].
  final List<String>? fixedLabels;

  /// Pinch-zoom multiplier passed straight through to the [IsoProjector].
  final double zoom;
  final List<Offset> _floorCornersM;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        size: Size.infinite,
        painter: _IsometricRoomPainter(
          floorCornersM: _floorCornersM,
          heightM: heightM,
          orbitRad: orbitRad,
          showEdgeLengths: showEdgeLengths,
          fixedLabels: fixedLabels,
          activeEdges: activeEdge == null ? const <int>{} : {activeEdge!},
          activeCorner: activeCorner,
          zoom: zoom,
        ),
      ),
    );
  }
}

class _IsometricRoomPainter extends CustomPainter {
  _IsometricRoomPainter({
    required this.floorCornersM,
    required this.heightM,
    required this.orbitRad,
    required this.showEdgeLengths,
    this.fixedLabels,
    this.activeEdges = const <int>{},
    this.activeCorner,
    this.zoom = 1.0,
  });

  final List<Offset> floorCornersM;
  final double heightM;
  final double orbitRad;
  final bool showEdgeLengths;
  final double zoom;

  /// Explicit per-edge labels (e.g. A/B/C/D). When null, edge-length labels are
  /// shown if [showEdgeLengths].
  final List<String>? fixedLabels;

  final Set<int> activeEdges;
  final int? activeCorner;

  @override
  void paint(Canvas canvas, Size size) {
    final n = floorCornersM.length;
    if (n < 3) return;

    final proj = IsoProjector(
      floorCornersM: floorCornersM,
      heightM: heightM,
      canvasSize: size,
      orbitRad: orbitRad,
      zoom: zoom,
    );

    final floor = proj.floorScreenAll;
    final top = proj.topScreenAll;

    // Floor fill.
    canvas.drawPath(
      Path()..addPolygon(floor, true),
      Paint()..color = DesignTokens.primaryBlue.withValues(alpha: 0.06),
    );

    // Build wall quads and their metadata.
    final quads = <List<Offset>>[
      for (var i = 0; i < n; i++)
        [floor[i], floor[(i + 1) % n], top[(i + 1) % n], top[i]],
    ];
    Offset quadCentre(List<Offset> q) => Offset(
          (q[0].dx + q[1].dx + q[2].dx + q[3].dx) / 4,
          (q[0].dy + q[1].dy + q[2].dy + q[3].dy) / 4,
        );

    // "Back" walls (darker/greener): the walls whose centre sits above (smaller
    // screen-y than) the floor centroid.
    final floorCentroidY =
        floor.map((p) => p.dy).reduce((a, b) => a + b) / floor.length;
    final backEdges = <int>{
      for (var i = 0; i < n; i++)
        if (quadCentre(quads[i]).dy < floorCentroidY) i,
    };

    // Draw walls back-to-front: ascending average screen-y so nearer walls
    // (larger y) paint last and win any overlap.
    final order = [for (var i = 0; i < n; i++) i]
      ..sort((a, b) => quadCentre(quads[a]).dy.compareTo(quadCentre(quads[b]).dy));

    for (final i in order) {
      _drawWall(
        canvas,
        quads[i],
        isActive: activeEdges.contains(i),
        isBack: backEdges.contains(i),
      );
    }

    // Labels drawn after all walls so they stay legible.
    for (final i in order) {
      final label = _labelFor(i, n);
      if (label != null) {
        _drawLabel(canvas, quadCentre(quads[i]), label,
            isActive: activeEdges.contains(i));
      }
    }

    // Dashed ceiling outline (open top).
    _drawDashedPolygon(canvas, top);

    // Optional active-corner highlight (polygon editing).
    if (activeCorner != null && activeCorner! >= 0 && activeCorner! < n) {
      canvas.drawCircle(
        floor[activeCorner!],
        5,
        Paint()..color = DesignTokens.accentOrange,
      );
    }
  }

  String? _labelFor(int i, int n) {
    if (fixedLabels != null) {
      return i < fixedLabels!.length ? fixedLabels![i] : null;
    }
    if (!showEdgeLengths) return null;
    final lenM = (floorCornersM[(i + 1) % n] - floorCornersM[i]).distance;
    return '${lenM.toStringAsFixed(2)} m';
  }

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

  void _drawLabel(Canvas canvas, Offset centre, String text,
      {required bool isActive}) {
    final tp = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color:
              isActive ? DesignTokens.accentOrange : DesignTokens.textMuted,
        ),
      ),
    )..layout();
    tp.paint(canvas, centre - Offset(tp.width / 2, tp.height / 2));
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
      if (total == 0) continue;
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

  @override
  bool shouldRepaint(_IsometricRoomPainter old) =>
      !_listEq(old.floorCornersM, floorCornersM) ||
      old.heightM != heightM ||
      old.orbitRad != orbitRad ||
      old.zoom != zoom ||
      old.showEdgeLengths != showEdgeLengths ||
      !_setEq(old.activeEdges, activeEdges) ||
      old.activeCorner != activeCorner;

  static bool _listEq(List<Offset> a, List<Offset> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  static bool _setEq(Set<int> a, Set<int> b) =>
      a.length == b.length && a.containsAll(b);
}
