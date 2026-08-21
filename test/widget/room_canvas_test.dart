import 'dart:ui' show PictureRecorder;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tamir_uy_mobile_flutter/geometry/room_geometry.dart';
import 'package:tamir_uy_mobile_flutter/models/room_plan.dart';
import 'package:tamir_uy_mobile_flutter/widgets/room/room_canvas.dart';

/// An L-shaped room: 4×4 bounding box, 6 corners.
List<Vec2> _lShape() => const [
      Vec2(0, 0),
      Vec2(4, 0),
      Vec2(4, 2),
      Vec2(2, 2),
      Vec2(2, 4),
      Vec2(0, 4),
    ];

RoomCanvasPainter _painterFor(RoomPlan? plan, {required RoomPlan legacyFrom}) {
  final room = legacyFrom.toLegacyRoom();
  return RoomCanvasPainter(
    room: room,
    plan: plan,
    selectedItemId: null,
    onItemSelected: (_) {},
  );
}

void main() {
  group('RoomCanvasPainter.computeOutlineM', () {
    test('a rectangle plan renders its 4 corners', () {
      final rect = RoomPlan.rectangle(
        width: 3.2,
        length: 4.5,
        ceilingHeightM: 2.8,
        source: RoomSource.wizard,
      );
      final painter = _painterFor(rect, legacyFrom: rect);
      expect(painter.outlineCornersM, hasLength(4));
    });

    test('an L-shape plan renders its 6-corner outline', () {
      final l = RoomPlan.fromCorners(
        _lShape(),
        ceilingHeightM: 2.8,
        source: RoomSource.sketch,
      );
      final painter = _painterFor(l, legacyFrom: l);
      expect(painter.outlineCornersM, hasLength(6));
      // Origin-normalised: the min corner sits at (0, 0).
      expect(painter.outlineCornersM.first, const Offset(0, 0));
    });

    test('no plan falls back to the legacy bounding rectangle (4 corners)', () {
      final rect = RoomPlan.rectangle(
        width: 3.0,
        length: 5.0,
        ceilingHeightM: 2.8,
        source: RoomSource.wizard,
      );
      final painter = _painterFor(null, legacyFrom: rect);
      expect(painter.outlineCornersM, hasLength(4));
      // Bounding rectangle spans width × length.
      expect(painter.canvasSize.width, closeTo(3.0 * 100, 1e-6));
      expect(painter.canvasSize.height, closeTo(5.0 * 100, 1e-6));
    });

    test('plan openings are resolved onto walls, legacy fallback has none', () {
      final rect = RoomPlan.rectangle(
        width: 3.2,
        length: 4.5,
        ceilingHeightM: 2.8,
        source: RoomSource.wizard,
        wallOpenings: [
          [const RoomOpening(type: 'door', width: 0.9, height: 2.1)],
          const [],
          const [],
          [const RoomOpening(type: 'window', width: 1.2, height: 1.0)],
        ],
      );
      final withPlan = _painterFor(rect, legacyFrom: rect);
      // Draws without throwing across a realistically sized canvas.
      final recorder = PictureRecorder();
      withPlan.paint(Canvas(recorder), withPlan.canvasSize);
      recorder.endRecording();
      expect(withPlan.outlineCornersM, hasLength(4));
    });
  });

  testWidgets('RoomCanvas builds with an L-shape plan and exposes 6 corners',
      (tester) async {
    final l = RoomPlan.fromCorners(
      _lShape(),
      ceilingHeightM: 2.8,
      source: RoomSource.sketch,
    );
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 500,
              height: 500,
              child: RoomCanvas(
                room: l.toLegacyRoom(),
                plan: l,
                onItemSelected: (_) {},
              ),
            ),
          ),
        ),
      ),
    );

    final customPaint = tester.widget<CustomPaint>(
      find.descendant(
        of: find.byType(RoomCanvas),
        matching: find.byWidgetPredicate(
          (w) => w is CustomPaint && w.painter is RoomCanvasPainter,
        ),
      ),
    );
    final painter = customPaint.painter as RoomCanvasPainter;
    expect(painter.outlineCornersM, hasLength(6));
  });
}
