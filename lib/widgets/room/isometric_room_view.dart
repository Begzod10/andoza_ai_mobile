import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../config/design_tokens.dart';
import '../../models/room_model.dart';
import 'iso_projector.dart';

/// An isometric preview of a room prism (open-top box). The default constructor
/// renders a rectangular room — the signature visual of the capture wizard —
/// while [IsometricRoomView.polygon] renders an arbitrary N-corner room with an
/// orbit angle and per-edge length labels. Both share the same polygon renderer
/// backed by [IsoProjector].
///
/// For the rectangle: [widthM] runs along walls B/D, [depthM] along walls A/C,
/// [heightM] up, and [activeWall] (if any) is drawn in the accent colour.
class IsometricRoomView extends StatelessWidget {
  /// Rectangular room preview (unchanged wizard look: A/B/C/D wall labels).
  const IsometricRoomView({
    required this.widthM,
    required this.depthM,
    required this.heightM,
    this.activeWall,
    super.key,
  })  : _floorCornersM = null,
        orbitRad = 0,
        showEdgeLengths = false,
        activeCorner = null;

  /// Arbitrary N-corner room preview. [floorCornersM] are the floor polygon
  /// corners in METRES (x = Offset.dx, y = Offset.dy). Edges are labelled with
  /// their length when [showEdgeLengths] is true. [orbitRad] rotates the floor
  /// around its centroid.
  const IsometricRoomView.polygon({
    required List<Offset> floorCornersM,
    required this.heightM,
    this.orbitRad = 0,
    this.showEdgeLengths = true,
    this.activeCorner,
    super.key,
  })  :
        // Private field can't be a named initialising formal.
        // ignore: prefer_initializing_formals
        _floorCornersM = floorCornersM,
        widthM = 0,
        depthM = 0,
        activeWall = null;

  final double widthM;
  final double depthM;
  final double heightM;
  final WallType? activeWall;
  final double orbitRad;
  final bool showEdgeLengths;
  final int? activeCorner;
  final List<Offset>? _floorCornersM;

  @override
  Widget build(BuildContext context) {
    if (_floorCornersM != null) {
      // Polygon path: generic edge labels (lengths) + computed back walls.
      return CustomPaint(
        size: Size.infinite,
        painter: _IsometricRoomPainter(
          floorCornersM: _floorCornersM,
          heightM: heightM,
          orbitRad: orbitRad,
          showEdgeLengths: showEdgeLengths,
          activeCorner: activeCorner,
        ),
      );
    }

    // Rectangle path: reproduce the original wizard look exactly.
    // Floor corners: C along y=0, B along x=width, A along y=depth, D along x=0.
    final floor = <Offset>[
      const Offset(0, 0),
      Offset(widthM, 0),
      Offset(widthM, depthM),
      Offset(0, depthM),
    ];
    // Edge i connects corner i → corner i+1:
    //   edge0 = wallC (near, y=0), edge1 = wallB (right, x=width),
    //   edge2 = wallA (far, y=depth), edge3 = wallD (left, x=0).
    const edgeWalls = [
      WallType.wallC,
      WallType.wallB,
      WallType.wallA,
      WallType.wallD,
    ];
    final labels = [for (final w in edgeWalls) _shortLabel(w)];
    // Preserve the original's darker "back" pair: walls A and D.
    final backEdges = <int>{
      for (var i = 0; i < edgeWalls.length; i++)
        if (edgeWalls[i] == WallType.wallA || edgeWalls[i] == WallType.wallD) i,
    };
    final activeEdges = <int>{
      for (var i = 0; i < edgeWalls.length; i++)
        if (activeWall != null && edgeWalls[i] == activeWall) i,
    };

    return CustomPaint(
      size: Size.infinite,
      painter: _IsometricRoomPainter(
        floorCornersM: floor,
        heightM: heightM,
        orbitRad: 0,
        showEdgeLengths: false,
        fixedLabels: labels,
        fixedBackEdges: backEdges,
        activeEdges: activeEdges,
      ),
    );
  }

  static String _shortLabel(WallType t) => switch (t) {
        WallType.wallA => 'A',
        WallType.wallB => 'B',
        WallType.wallC => 'C',
        WallType.wallD => 'D',
      };
}

class _IsometricRoomPainter extends CustomPainter {
  _IsometricRoomPainter({
    required this.floorCornersM,
    required this.heightM,
    required this.orbitRad,
    required this.showEdgeLengths,
    this.fixedLabels,
    this.fixedBackEdges,
    this.activeEdges = const <int>{},
    this.activeCorner,
  });

  final List<Offset> floorCornersM;
  final double heightM;
  final double orbitRad;
  final bool showEdgeLengths;

  /// Explicit per-edge labels (rectangle path: A/B/C/D). When null, edge-length
  /// labels are shown if [showEdgeLengths].
  final List<String>? fixedLabels;

  /// Explicit "back" (darker) edges (rectangle path). When null the back walls
  /// are computed from screen depth.
  final Set<int>? fixedBackEdges;

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

    // "Back" walls (darker/greener): explicit for the rectangle, otherwise the
    // walls whose centre sits above (smaller screen-y than) the floor centroid.
    Set<int> backEdges;
    if (fixedBackEdges != null) {
      backEdges = fixedBackEdges!;
    } else {
      final floorCentroidY =
          floor.map((p) => p.dy).reduce((a, b) => a + b) / floor.length;
      backEdges = {
        for (var i = 0; i < n; i++)
          if (quadCentre(quads[i]).dy < floorCentroidY) i,
      };
    }

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
