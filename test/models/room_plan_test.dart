import 'package:flutter_test/flutter_test.dart';
import 'package:tamir_uy_mobile_flutter/geometry/geometry_config.dart';
import 'package:tamir_uy_mobile_flutter/geometry/room_geometry.dart';
import 'package:tamir_uy_mobile_flutter/models/room_model.dart' show WallType;
import 'package:tamir_uy_mobile_flutter/models/room_plan.dart';

/// A plain 4×3 axis-aligned rectangle (metres).
List<Vec2> _rect() =>
    const [Vec2(0, 0), Vec2(4, 0), Vec2(4, 3), Vec2(0, 3)];

/// An L-shaped room (6 rectilinear corners).
List<Vec2> _lShape() => const [
      Vec2(0, 0),
      Vec2(4, 0),
      Vec2(4, 2),
      Vec2(2, 2),
      Vec2(2, 4),
      Vec2(0, 4),
    ];

/// A trapezoid: 4 corners but the top edge is slanted, so it is not an
/// axis-aligned rectangle.
List<Vec2> _trapezoid() =>
    const [Vec2(0, 0), Vec2(4, 0), Vec2(3, 3), Vec2(1, 3)];

void main() {
  group('RoomPlan.fromCorners — walls', () {
    test('derives one wall per corner, closing the polygon', () {
      final plan = RoomPlan.fromCorners(
        _rect(),
        ceilingHeightM: 2.8,
        source: RoomSource.wizard,
      );
      expect(plan.walls, hasLength(4));
      // Wall i connects corner i → corner (i+1) mod n; the last wall closes
      // the loop back to corner 0.
      expect(plan.walls.first.a, 0);
      expect(plan.walls.first.b, 1);
      expect(plan.walls.last.a, 3);
      expect(plan.walls.last.b, 0);
    });

    test('wall lengths match corner distances (incl. the closing edge)', () {
      final plan = RoomPlan.fromCorners(
        _rect(),
        ceilingHeightM: 2.8,
        source: RoomSource.wizard,
      );
      // 4×3 rectangle: horizontal walls 4 m, vertical walls 3 m.
      expect(plan.walls[0].lengthM, closeTo(4.0, 1e-9));
      expect(plan.walls[1].lengthM, closeTo(3.0, 1e-9));
      expect(plan.walls[2].lengthM, closeTo(4.0, 1e-9));
      expect(plan.walls[3].lengthM, closeTo(3.0, 1e-9)); // closing edge
    });

    test('an L-shape keeps all 6 walls (not collapsed to a box)', () {
      final plan = RoomPlan.fromCorners(
        _lShape(),
        ceilingHeightM: 2.8,
        source: RoomSource.sketch,
      );
      expect(plan.walls, hasLength(6));
      expect(plan.corners, hasLength(6));
    });
  });

  group('RoomPlan.areaM2 / perimeterM / boundingSize', () {
    test('rectangle area, perimeter and bounding size', () {
      final plan = RoomPlan.fromCorners(
        _rect(),
        ceilingHeightM: 2.8,
        source: RoomSource.wizard,
      );
      expect(plan.areaM2, closeTo(12.0, 1e-9));
      expect(plan.perimeterM, closeTo(14.0, 1e-9));
      expect(plan.boundingSize.width, closeTo(4.0, 1e-9));
      expect(plan.boundingSize.length, closeTo(3.0, 1e-9));
    });

    test('L-shape area is the true polygon area, not the bounding box', () {
      final plan = RoomPlan.fromCorners(
        _lShape(),
        ceilingHeightM: 2.8,
        source: RoomSource.sketch,
      );
      // The 4×4 bounding box is 16 m²; the actual L covers 12 m².
      expect(plan.areaM2, closeTo(12.0, 1e-9));
      expect(plan.boundingSize.width, closeTo(4.0, 1e-9));
      expect(plan.boundingSize.length, closeTo(4.0, 1e-9));
    });
  });

  group('RoomPlan.isAxisAlignedRect', () {
    test('true for a plain 4-corner axis rectangle', () {
      final plan = RoomPlan.fromCorners(
        _rect(),
        ceilingHeightM: 2.8,
        source: RoomSource.wizard,
      );
      expect(plan.isAxisAlignedRect, isTrue);
      expect(plan.isRectangleLike, isTrue);
    });

    test('false for an L-shape (more than 4 corners)', () {
      final plan = RoomPlan.fromCorners(
        _lShape(),
        ceilingHeightM: 2.8,
        source: RoomSource.sketch,
      );
      expect(plan.isAxisAlignedRect, isFalse);
      expect(plan.isRectangleLike, isFalse);
    });

    test('false for a trapezoid (4 corners but a slanted edge)', () {
      final plan = RoomPlan.fromCorners(
        _trapezoid(),
        ceilingHeightM: 2.8,
        source: RoomSource.drag,
      );
      expect(plan.isAxisAlignedRect, isFalse);
      // Still "rectangle-like" by corner count, which is why the stricter
      // axis check exists.
      expect(plan.isRectangleLike, isTrue);
    });
  });

  group('RoomPlan.netWallAreaM2', () {
    test('with no openings equals perimeter × ceiling height', () {
      final plan = RoomPlan.fromCorners(
        _rect(),
        ceilingHeightM: 2.8,
        source: RoomSource.wizard,
      );
      // 14 m perimeter × 2.8 m = 39.2 m².
      expect(plan.netWallAreaM2, closeTo(14.0 * 2.8, 1e-9));
    });

    test('subtracts a 0.9×2.1 door (1.89 m²)', () {
      final rect = _rect();
      final walls = <RoomWall>[
        for (var i = 0; i < rect.length; i++)
          RoomWall(
            i,
            (i + 1) % rect.length,
            rect[i].distanceTo(rect[(i + 1) % rect.length]),
            openings: i == 0
                ? const [
                    RoomOpening(
                      type: 'door',
                      width: 0.9,
                      height: 2.1,
                      position: 0.5,
                    ),
                  ]
                : const [],
          ),
      ];
      final plan = RoomPlan(
        corners: rect,
        walls: walls,
        ceilingHeightM: 2.8,
        source: RoomSource.wizard,
      );
      expect(plan.netWallAreaM2, closeTo(14.0 * 2.8 - 1.89, 1e-9));
    });
  });

  group('RoomPlan.toLegacyRoom', () {
    test('round-trips width/length/height and yields 4 A–D walls', () {
      final plan = RoomPlan.fromCorners(
        _rect(),
        ceilingHeightM: 2.8,
        source: RoomSource.wizard,
        name: 'Zal',
      );
      final room = plan.toLegacyRoom(id: 'room1');
      expect(room.id, 'room1');
      expect(room.name, 'Zal');
      expect(room.dimensions.width, closeTo(4.0, 1e-9));
      expect(room.dimensions.length, closeTo(3.0, 1e-9));
      expect(room.dimensions.height, closeTo(2.8, 1e-9));
      expect(room.walls, hasLength(4));
      expect(room.walls.map((w) => w.type).toSet(), {
        WallType.wallA,
        WallType.wallB,
        WallType.wallC,
        WallType.wallD,
      });
    });
  });

  group('RoomPlan.areaM2 ≡ bounding for rectangles (equivalence guard)', () {
    test('rectangle plan area equals bounding width × length', () {
      final plan = RoomPlan.fromCorners(
        _rect(),
        ceilingHeightM: 2.8,
        source: RoomSource.wizard,
      );
      expect(
        plan.areaM2,
        closeTo(plan.boundingSize.width * plan.boundingSize.length, 1e-9),
      );
    });
  });

  group('RoomPlan.rectangle', () {
    test('lays out 4 A–D walls: A/C run length, B/D run width', () {
      final plan = RoomPlan.rectangle(
        width: 3.2,
        length: 4.5,
        ceilingHeightM: 2.8,
        source: RoomSource.wizard,
      );
      expect(plan.corners, hasLength(4));
      expect(plan.walls, hasLength(4));
      expect(plan.isAxisAlignedRect, isTrue);
      // Wall index 0=A, 1=B, 2=C, 3=D (matches toLegacyRoom's mapping).
      expect(plan.walls[0].lengthM, closeTo(4.5, 1e-9)); // A = length
      expect(plan.walls[1].lengthM, closeTo(3.2, 1e-9)); // B = width
      expect(plan.walls[2].lengthM, closeTo(4.5, 1e-9)); // C = length
      expect(plan.walls[3].lengthM, closeTo(3.2, 1e-9)); // D = width
      expect(plan.boundingSize.width, closeTo(3.2, 1e-9));
      expect(plan.boundingSize.length, closeTo(4.5, 1e-9));
    });

    test('editing wall B (width) changes boundingSize.width only', () {
      final before = RoomPlan.rectangle(
        width: 3.2,
        length: 4.5,
        ceilingHeightM: 2.8,
        source: RoomSource.wizard,
      );
      // Wizard edits wall B by setting the width dimension; length is untouched.
      final after = RoomPlan.rectangle(
        width: 5.0,
        length: before.boundingSize.length,
        ceilingHeightM: 2.8,
        source: RoomSource.wizard,
      );
      expect(after.boundingSize.width, closeTo(5.0, 1e-9));
      expect(after.boundingSize.length, closeTo(4.5, 1e-9)); // unchanged
      expect(after.walls[1].lengthM, closeTo(5.0, 1e-9)); // B changed
      expect(after.walls[0].lengthM, closeTo(4.5, 1e-9)); // A unchanged
    });

    test('per-wall openings land on the right legacy wall via toLegacyRoom', () {
      final plan = RoomPlan.rectangle(
        width: 3.2,
        length: 4.5,
        ceilingHeightM: 2.8,
        source: RoomSource.wizard,
        wallOpenings: const [
          [], // A
          [RoomOpening(type: 'door', width: 0.9, height: 2.1)], // B
          [], // C
          [RoomOpening(type: 'window', width: 1.2, height: 1.4)], // D
        ],
      );
      // The opening is preserved on the plan wall.
      expect(plan.walls[1].openings, hasLength(1));
      expect(plan.walls[1].openings.first.type, 'door');
      // netWallAreaM2 subtracts both openings' face area.
      final openingArea = 0.9 * 2.1 + 1.2 * 1.4;
      expect(
        plan.netWallAreaM2,
        closeTo(plan.perimeterM * 2.8 - openingArea, 1e-9),
      );
      // toLegacyRoom maps the door onto wall B and the window onto wall D.
      final room = plan.toLegacyRoom(id: 'r');
      final bWall = room.walls.firstWhere((w) => w.type == WallType.wallB);
      final dWall = room.walls.firstWhere((w) => w.type == WallType.wallD);
      expect(room.doors.where((d) => d.wallId == bWall.id), hasLength(1));
      expect(room.windows.where((w) => w.wallId == dWall.id), hasLength(1));
    });
  });

  group('RoomPlan.isValid / invalidReason', () {
    test('a well-formed rectangle is valid with no reason', () {
      final plan = RoomPlan.fromCorners(
        _rect(),
        ceilingHeightM: 2.8,
        source: RoomSource.wizard,
      );
      expect(plan.isValid, isTrue);
      expect(plan.invalidReason, isNull);
    });

    test('fewer than 3 corners is invalid', () {
      final plan = RoomPlan.fromCorners(
        const [Vec2(0, 0), Vec2(4, 0)],
        ceilingHeightM: 2.8,
        source: RoomSource.wizard,
      );
      expect(plan.isValid, isFalse);
      expect(plan.invalidReason, 'Kamida 3 ta burchak kerak');
    });

    test('a self-intersecting (bow-tie) polygon is invalid', () {
      final plan = RoomPlan.fromCorners(
        const [Vec2(0, 0), Vec2(2, 2), Vec2(2, 0), Vec2(0, 2)],
        ceilingHeightM: 2.8,
        source: RoomSource.sketch,
      );
      expect(plan.isValid, isFalse);
      expect(plan.invalidReason, 'Devorlar kesishmasligi kerak');
    });

    test('a wall shorter than the minimum is invalid', () {
      // One 0.1 m edge, well under GeometryConfig.minWallM (0.30 m).
      final plan = RoomPlan.fromCorners(
        const [Vec2(0, 0), Vec2(0.1, 0), Vec2(0.1, 3), Vec2(0, 3)],
        ceilingHeightM: 2.8,
        source: RoomSource.drag,
      );
      expect(plan.isValid, isFalse);
      expect(plan.invalidReason, contains('Har bir devor'));
    });

    test('a ceiling height out of range is invalid', () {
      final plan = RoomPlan.fromCorners(
        _rect(),
        ceilingHeightM: GeometryConfig.minHeightM - 0.5,
        source: RoomSource.wizard,
      );
      expect(plan.isValid, isFalse);
      expect(plan.invalidReason, contains('Balandlik'));
    });
  });
}
