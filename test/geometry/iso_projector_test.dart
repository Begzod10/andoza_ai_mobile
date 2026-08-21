import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:tamir_uy_mobile_flutter/widgets/room/iso_projector.dart';

void main() {
  group('IsoProjector', () {
    const canvas = Size(300, 240);
    final unitSquare = <Offset>[
      const Offset(0, 0),
      const Offset(1, 0),
      const Offset(1, 1),
      const Offset(0, 1),
    ];

    test('project is finite and inside the padded canvas', () {
      final p = IsoProjector(
        floorCornersM: unitSquare,
        heightM: 2.5,
        canvasSize: canvas,
      );
      for (final z in [0.0, p.heightM]) {
        for (final c in unitSquare) {
          final s = p.project(c.dx, c.dy, z);
          expect(s.dx.isFinite, isTrue);
          expect(s.dy.isFinite, isTrue);
          expect(s.dx, inInclusiveRange(0, canvas.width));
          expect(s.dy, inInclusiveRange(0, canvas.height));
        }
      }
    });

    test('floorDeltaFromScreen round-trips the floor (x,y) map', () {
      final p = IsoProjector(
        floorCornersM: unitSquare,
        heightM: 2.5,
        canvasSize: canvas,
      );
      final screenDelta = p.project(1, 0, 0) - p.project(0, 0, 0);
      final world = p.floorDeltaFromScreen(screenDelta);
      expect(world.dx, closeTo(1.0, 1e-6));
      expect(world.dy, closeTo(0.0, 1e-6));

      // Second basis vector, and with a non-zero orbit.
      final rotated = IsoProjector(
        floorCornersM: unitSquare,
        heightM: 2.5,
        canvasSize: canvas,
        orbitRad: 0.6,
      );
      final sd = rotated.project(0, 1, 0) - rotated.project(0, 0, 0);
      final w = rotated.floorDeltaFromScreen(sd);
      expect(w.dx, closeTo(0.0, 1e-6));
      expect(w.dy, closeTo(1.0, 1e-6));
    });

    test('floorScreen/topScreen match project and expose all corners', () {
      final p = IsoProjector(
        floorCornersM: unitSquare,
        heightM: 3,
        canvasSize: canvas,
      );
      expect(p.cornerCount, unitSquare.length);
      expect(p.floorScreenAll.length, unitSquare.length);
      expect(p.topScreenAll.length, unitSquare.length);
      expect(p.floorScreen(2), p.project(1, 1, 0));
      expect(p.topScreen(2), p.project(1, 1, p.heightM));
    });

    test('zoom scales screen vectors and floorDeltaFromScreen inverts it', () {
      final base = IsoProjector(
        floorCornersM: unitSquare,
        heightM: 2.5,
        canvasSize: canvas,
      );
      final zoomed = IsoProjector(
        floorCornersM: unitSquare,
        heightM: 2.5,
        canvasSize: canvas,
        zoom: 2.0,
      );

      // The vector between two projected floor points is exactly 2x longer.
      final baseVec = base.project(1, 0, 0) - base.project(0, 0, 0);
      final zoomVec = zoomed.project(1, 0, 0) - zoomed.project(0, 0, 0);
      expect(zoomVec.dx, closeTo(baseVec.dx * 2, 1e-6));
      expect(zoomVec.dy, closeTo(baseVec.dy * 2, 1e-6));

      // zoom=1 leaves the projector identical to the unzoomed one.
      final unit = IsoProjector(
        floorCornersM: unitSquare,
        heightM: 2.5,
        canvasSize: canvas,
        zoom: 1.0,
      );
      expect(unit.scale, closeTo(base.scale, 1e-9));
      expect(unit.origin.dx, closeTo(base.origin.dx, 1e-9));
      expect(unit.origin.dy, closeTo(base.origin.dy, 1e-9));

      // floorDeltaFromScreen still round-trips under zoom (inverse accounts
      // for the extra scale factor).
      final screenDelta = zoomed.project(1, 0, 0) - zoomed.project(0, 0, 0);
      final world = zoomed.floorDeltaFromScreen(screenDelta);
      expect(world.dx, closeTo(1.0, 1e-6));
      expect(world.dy, closeTo(0.0, 1e-6));

      final sd = zoomed.project(0, 1, 0) - zoomed.project(0, 0, 0);
      final w = zoomed.floorDeltaFromScreen(sd);
      expect(w.dx, closeTo(0.0, 1e-6));
      expect(w.dy, closeTo(1.0, 1e-6));
    });

    test('heightMetrePerScreenY converts a vertical drag to metres', () {
      final p = IsoProjector(
        floorCornersM: unitSquare,
        heightM: 2.5,
        canvasSize: canvas,
      );
      final dyPixels = p.project(0, 0, 0).dy - p.project(0, 0, 1).dy;
      // Raising by 1 metre lifts the point on screen (smaller y ⇒ positive dy).
      expect(dyPixels, greaterThan(0));
      expect(p.heightMetrePerScreenY * dyPixels, closeTo(1.0, 1e-6));
    });
  });
}
