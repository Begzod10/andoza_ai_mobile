import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:tamir_uy_mobile_flutter/features/ar_scan/arcore_plan.dart';
import 'package:tamir_uy_mobile_flutter/geometry/room_geometry.dart';
import 'package:tamir_uy_mobile_flutter/models/room_plan.dart';

ArScanRaw _raw(List<List<double>> pts, {bool closed = false, double height = 2.7}) => ArScanRaw(
      corners: [for (final p in pts) Vec2(p[0], p[1])],
      height: height,
      heightMeasured: true,
      closed: closed,
      trackingLossCount: 0,
      durationSec: 60,
    );

RoomPlan _ok(ArPlanResult r) {
  expect(r, isA<ArPlanOk>(), reason: r is ArPlanRejected ? r.reason : null);
  return (r as ArPlanOk).plan;
}

String _rejected(ArPlanResult r) {
  expect(r, isA<ArPlanRejected>());
  return (r as ArPlanRejected).reason;
}

/// Interior angle at corner i, in degrees.
double _angleAt(List<Vec2> c, int i) {
  final n = c.length;
  final a = c[(i - 1 + n) % n] - c[i];
  final b = c[(i + 1) % n] - c[i];
  final cos = a.dot(b) / (a.length * b.length);
  return math.acos(cos.clamp(-1.0, 1.0)) * 180 / math.pi;
}

List<double> _sortedWalls(RoomPlan p) => [for (final w in p.walls) w.lengthM]..sort();

void main() {
  test('squares a slightly skewed rectangle', () {
    final plan = _ok(buildArcorePlan(_raw([
      [0, 0], [4.02, 0.05], [3.98, 3.03], [-0.03, 2.98],
    ])));
    expect(plan.corners, hasLength(4));
    for (var i = 0; i < 4; i++) {
      expect(_angleAt(plan.corners, i), closeTo(90, 0.01));
    }
    expect(plan.areaM2, closeTo(12.0, 0.25));
  });

  test('squares a rectangle that is rotated in the ARCore frame', () {
    // Same room, but ARCore's x axis sits 30° off the walls.
    final r = 30 * math.pi / 180;
    Vec2 rot(double x, double y) => Vec2(x * math.cos(r) - y * math.sin(r), x * math.sin(r) + y * math.cos(r));
    final pts = [rot(0, 0), rot(4.02, 0.05), rot(3.98, 3.03), rot(-0.03, 2.98)];
    final plan = _ok(buildArcorePlan(_raw([for (final p in pts) [p.x, p.y]])));
    for (var i = 0; i < 4; i++) {
      expect(_angleAt(plan.corners, i), closeTo(90, 0.01));
    }
  });

  test('keeps all six corners of an L-shape', () {
    final plan = _ok(buildArcorePlan(_raw([
      [0, 0], [4, 0], [4, 2], [2, 2], [2, 4], [0, 4],
    ])));
    expect(plan.corners, hasLength(6));
    expect(plan.areaM2, closeTo(12.0, 0.05));
  });

  test('leaves a genuinely slanted wall slanted', () {
    // Trapezoid: the right wall leans 15° (75° corner at the bottom right).
    final dx = 3 / math.tan(75 * math.pi / 180);
    final plan = _ok(buildArcorePlan(_raw([
      [0, 0], [5, 0], [5 - dx, 3], [0, 3],
    ])));
    final angles = [for (var i = 0; i < 4; i++) _angleAt(plan.corners, i)]..sort();
    expect(angles.first, closeTo(75, 1));
  });

  test('spreads the closure error along the walls', () {
    // A true 4 × 3 room measured with drift that grows linearly to (0.10, 0.06)
    // by the time the user is back at the first corner.
    const ex = 0.10, ey = 0.06, total = 14.0;
    List<double> drifted(double x, double y, double walked) =>
        [x + ex * walked / total, y + ey * walked / total];
    final plan = _ok(buildArcorePlan(_raw([
      drifted(0, 0, 0), drifted(4, 0, 4), drifted(4, 3, 7), drifted(0, 3, 11),
      drifted(0, 0, 14),
    ], closed: true)));
    expect(plan.corners, hasLength(4));
    expect(perimeter(plan.corners), closeTo(14.0, 0.05));
  });

  test('merges corners closer than 10 cm', () {
    final plan = _ok(buildArcorePlan(_raw([
      [0, 0], [4, 0], [4.06, 0.0], [4, 3], [0, 3],
    ])));
    expect(plan.corners, hasLength(4));
  });

  test('closes an open outline without redistributing', () {
    final plan = _ok(buildArcorePlan(_raw([
      [0, 0], [4, 0], [4, 3], [0, 3],
    ])));
    expect(plan.walls, hasLength(4));
    expect(_sortedWalls(plan), [3.0, 3.0, 4.0, 4.0]);
  });

  test('clockwise and counter-clockwise give the same plan', () {
    final ccw = _ok(buildArcorePlan(_raw([[0, 0], [4, 0], [4, 3], [0, 3]])));
    final cw = _ok(buildArcorePlan(_raw([[0, 0], [0, 3], [4, 3], [4, 0]])));
    expect(cw.areaM2, closeTo(ccw.areaM2, 1e-6));
    expect(_sortedWalls(cw), _sortedWalls(ccw));
  });

  test('rejects fewer than 3 corners', () {
    expect(_rejected(buildArcorePlan(_raw([[0, 0], [4, 0]]))), 'too_few_corners');
  });

  test('rejects a self-intersecting outline', () {
    expect(_rejected(buildArcorePlan(_raw([[0, 0], [4, 3], [4, 0], [0, 3]]))), 'self_intersecting');
  });

  test('rejects an outlier corner', () {
    expect(_rejected(buildArcorePlan(_raw([[0, 0], [35, 0], [35, 3], [0, 3]]))), 'wall_too_long');
  });

  test('tags the plan as arcore and rounds to 1 cm', () {
    final plan = _ok(buildArcorePlan(_raw([[0, 0], [4.123, 0], [4.123, 3.0567], [0, 3.0567]])));
    expect(plan.source, RoomSource.arcore);
    expect(plan.ceilingHeightM, 2.7);
    for (final w in plan.walls) {
      expect((w.lengthM * 100 - (w.lengthM * 100).round()).abs(), lessThan(1e-6));
    }
  });

  test('ArScanRaw.fromMap parses the channel payload', () {
    final raw = ArScanRaw.fromMap({
      'corners': [[0.0, 0.0], [4.0, 0.0], [4.0, 3.0]],
      'height': 2.74,
      'heightMeasured': true,
      'closed': true,
      'trackingLossCount': 2,
      'durationSec': 95,
    });
    expect(raw.corners, [const Vec2(0, 0), const Vec2(4, 0), const Vec2(4, 3)]);
    expect(raw.height, 2.74);
    expect(raw.heightMeasured, isTrue);
    expect(raw.closed, isTrue);
    expect(raw.trackingLossCount, 2);
    expect(raw.durationSec, 95);
  });
}
