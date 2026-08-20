import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:tamir_uy_mobile_flutter/geometry/room_geometry.dart';

/// Orientation of edge a→b in degrees (-180..180].
double _orientDeg(Vec2 a, Vec2 b) =>
    math.atan2(b.y - a.y, b.x - a.x) * 180 / math.pi;

/// Smallest angular distance (deg) from [deg] to the nearest multiple of 90°.
double _distTo90(double deg) {
  var d = (deg - (deg / 90).round() * 90).abs() % 360;
  if (d > 180) d = 360 - d;
  return d;
}

/// Sample points along edge a→b (excluding b), with small perpendicular noise.
List<Vec2> _edge(Vec2 a, Vec2 b, int n, double noise) {
  final dir = (b - a).normalized;
  final nrm = Vec2(-dir.y, dir.x);
  return [
    for (var i = 0; i < n; i++)
      a +
          (b - a) * (i / n) +
          nrm * (noise * math.sin(i * 1.7)), // deterministic wobble
  ];
}

void main() {
  group('measures', () {
    test('shoelace area + perimeter of a rectangle', () {
      final r = [const Vec2(0, 0), Vec2(2, 0), Vec2(2, 3), Vec2(0, 3)];
      expect(shoelaceArea(r), closeTo(6.0, 1e-9));
      expect(perimeter(r), closeTo(10.0, 1e-9));
    });

    test('bounding size', () {
      final p = [const Vec2(1, 1), Vec2(5, 1), Vec2(5, 4), Vec2(1, 4)];
      final b = boundingSize(p);
      expect(b.width, closeTo(4.0, 1e-9));
      expect(b.length, closeTo(3.0, 1e-9));
    });
  });

  group('snapAngle', () {
    test('snaps near-axis to 90°', () {
      final r = snapAngleRad(88 * math.pi / 180);
      expect(r * 180 / math.pi, closeTo(90, 1e-6));
    });
    test('keeps a free 30° angle (beyond tolerance of 0/45)', () {
      final r = snapAngleRad(30 * math.pi / 180);
      expect(r * 180 / math.pi, closeTo(30, 1e-6));
    });
  });

  group('regularize', () {
    test('a wobbly square → clean axis-aligned rectangle (~4 corners)', () {
      const a = Vec2(0, 0), b = Vec2(4, 0), c = Vec2(4, 4), d = Vec2(0, 4);
      final raw = [
        ..._edge(a, b, 12, 0.03),
        ..._edge(b, c, 12, 0.03),
        ..._edge(c, d, 12, 0.03),
        ..._edge(d, a, 12, 0.03),
        a, // close back to start
      ];
      final poly = regularizeFreehand(raw);
      expect(poly.length, inInclusiveRange(4, 5));
      // Every edge should be within a few degrees of an axis.
      for (var i = 0; i < poly.length; i++) {
        final o = _orientDeg(poly[i], poly[(i + 1) % poly.length]);
        expect(_distTo90(o), lessThan(8),
            reason: 'edge $i orientation $o not axis-aligned');
      }
      expect(shoelaceArea(poly), closeTo(16, 3));
    });

    test('an L-shape keeps its 6 corners and stays rectilinear', () {
      final l = [
        const Vec2(0, 0),
        Vec2(4, 0),
        Vec2(4, 2),
        Vec2(2, 2),
        Vec2(2, 4),
        Vec2(0, 4),
      ];
      final poly = regularize(l);
      expect(poly.length, 6);
      for (var i = 0; i < poly.length; i++) {
        final o = _orientDeg(poly[i], poly[(i + 1) % poly.length]);
        expect(_distTo90(o), lessThan(2));
      }
      expect(shoelaceArea(poly), closeTo(12, 0.5));
    });

    test('a deliberately skewed room is NOT forced to 90°', () {
      final para = [
        const Vec2(0, 0),
        Vec2(3, 0),
        Vec2(4, 2),
        Vec2(1, 2),
      ];
      final poly = regularize(para);
      // At least one edge must remain clearly off-axis (the slanted walls).
      final anySkew = [
        for (var i = 0; i < poly.length; i++)
          _distTo90(_orientDeg(poly[i], poly[(i + 1) % poly.length]))
      ].any((d) => d > 20);
      expect(anySkew, isTrue,
          reason: 'skewed walls were wrongly snapped to right angles');
    });
  });

  group('self-intersection', () {
    test('a simple square does not self-intersect', () {
      final sq = [const Vec2(0, 0), Vec2(2, 0), Vec2(2, 2), Vec2(0, 2)];
      expect(isSelfIntersecting(sq), isFalse);
    });
    test('a bow-tie self-intersects', () {
      final bow = [const Vec2(0, 0), Vec2(2, 2), Vec2(2, 0), Vec2(0, 2)];
      expect(isSelfIntersecting(bow), isTrue);
    });
  });
}
