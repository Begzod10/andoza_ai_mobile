import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:tamir_uy_mobile_flutter/features/room_scan/models/captured_room.dart';
import 'package:tamir_uy_mobile_flutter/features/room_scan/room_scan_converter.dart';
import 'package:tamir_uy_mobile_flutter/geometry/room_geometry.dart';
import 'package:tamir_uy_mobile_flutter/models/room_plan.dart';

CapturedRoom _fixtureRoom() {
  final raw = File('test/features/room_scan/fixtures/captured_room_sample.json')
      .readAsStringSync();
  return parseCapturedRoom(jsonDecode(raw) as Map<String, dynamic>);
}

/// Build a wall surface running along [angleDeg] on the app floor plane, centred
/// at world `(cx, _, cz)`. Only column 0 (direction) + column 3 (translation) of
/// the transform are consumed by the converter, but we emit a proper Y-rotation
/// so the matrix is realistic.
ScanSurface _wall({
  required double cx,
  required double cz,
  required double angleDeg,
  required double length,
  double height = 2.7,
}) {
  final a = angleDeg * math.pi / 180;
  final c = math.cos(a), s = math.sin(a);
  return ScanSurface(
    dimensions: Vec3(length, height, 0.1),
    transform: ScanTransform(<double>[
      c, 0, s, 0, //
      0, 1, 0, 0, //
      -s, 0, c, 0, //
      cx, height / 2, cz, 1, //
    ]),
  );
}

/// Four walls of an axis-aligned [w]×[l] room centred on the origin, the whole
/// room rotated by [rotDeg] about the vertical axis.
CapturedRoom _rect({
  required double w,
  required double l,
  double rotDeg = 0,
  double height = 2.7,
}) {
  final r = rotDeg * math.pi / 180;
  final cr = math.cos(r), sr = math.sin(r);
  Vec3Point rot(double x, double z) => Vec3Point(x * cr - z * sr, x * sr + z * cr);
  final centres = <(Vec3Point, double, double)>[
    (rot(0, -l / 2), 0 + rotDeg, w), // bottom, along X
    (rot(w / 2, 0), 90 + rotDeg, l), // right, along Z
    (rot(0, l / 2), 0 + rotDeg, w), // top
    (rot(-w / 2, 0), 90 + rotDeg, l), // left
  ];
  return CapturedRoom(
    walls: [
      for (final (c, ang, len) in centres)
        _wall(cx: c.x, cz: c.z, angleDeg: ang, length: len, height: height),
    ],
  );
}

class Vec3Point {
  final double x;
  final double z;
  const Vec3Point(this.x, this.z);
}

double _minX(List<Vec2> p) => p.map((v) => v.x).reduce(math.min);
double _minY(List<Vec2> p) => p.map((v) => v.y).reduce(math.min);

void main() {
  group('RoomScanConverter — fixture (4×3 room, 1 door, 1 window, 2 objects)', () {
    late RoomScanDraft draft;

    setUp(() => draft = RoomScanConverter.toRoomDraft(_fixtureRoom()));

    test('produces a 4-corner axis-aligned rectangle', () {
      expect(draft.plan.corners, hasLength(4));
      expect(draft.plan.isAxisAlignedRect, isTrue);
      expect(draft.plan.source, RoomSource.lidar);
    });

    test('normalises the origin to the bounding-box min corner', () {
      expect(_minX(draft.plan.corners), closeTo(0, 1e-6));
      expect(_minY(draft.plan.corners), closeTo(0, 1e-6));
    });

    test('bounding size is 4 m × 3 m', () {
      final b = draft.plan.boundingSize;
      expect(b.width, closeTo(4, 0.05));
      expect(b.length, closeTo(3, 0.05));
    });

    test('wall lengths are {3, 3, 4, 4}', () {
      final lens = draft.plan.walls.map((w) => w.lengthM).toList()..sort();
      expect(lens[0], closeTo(3, 0.05));
      expect(lens[1], closeTo(3, 0.05));
      expect(lens[2], closeTo(4, 0.05));
      expect(lens[3], closeTo(4, 0.05));
    });

    test('ceiling height = median wall height (2.5 m), kept raw', () {
      expect(draft.plan.ceilingHeightM, closeTo(2.5, 1e-6));
    });

    test('door + window land on walls with correct type/size/sill', () {
      final openings = [for (final w in draft.plan.walls) ...w.openings];
      expect(openings, hasLength(2));

      final door = openings.firstWhere((o) => o.type == 'door');
      expect(door.width, closeTo(0.9, 0.01));
      expect(door.height, closeTo(2.1, 0.01));
      expect(door.sillHeight, 0.0);
      expect(door.position, inInclusiveRange(0.0, 1.0));

      final window = openings.firstWhere((o) => o.type == 'window');
      expect(window.width, closeTo(1.5, 0.01));
      expect(window.height, closeTo(1.2, 0.01));
      // sill = centre.y (1.4) - height/2 (0.6) = 0.8
      expect(window.sillHeight, closeTo(0.8, 0.01));
    });

    test('objects go to scanObjects, not into the room geometry', () {
      expect(draft.objects, hasLength(2));
      final cats = draft.objects.map((o) => o.category).toSet();
      expect(cats, containsAll(<ScanObjectCategory>[
        ScanObjectCategory.table,
        ScanObjectCategory.chair,
      ]));
      final table = draft.objects.firstWhere(
          (o) => o.category == ScanObjectCategory.table);
      expect(table.width, closeTo(1.2, 0.01)); // dims.x
      expect(table.depth, closeTo(0.8, 0.01)); // dims.z
      expect(table.height, closeTo(0.75, 0.01)); // dims.y
    });
  });

  group('RoomScanConverter — parity with the manual rectangle flow', () {
    test('a scanned 4×3 yields the same rectangle DTO the manual flow would', () {
      final scanned = RoomScanConverter.toRoomDraft(
        _rect(w: 4, l: 3, height: 2.5),
      ).plan;
      final manual = RoomPlan.rectangle(
        width: 4,
        length: 3,
        ceilingHeightM: 2.5,
        source: RoomSource.lidar,
      );

      // Same rectangle family → both take the manual (roomToRoomCreate) path.
      expect(scanned.isAxisAlignedRect, isTrue);
      expect(manual.isAxisAlignedRect, isTrue);
      expect(scanned.boundingSize.width, closeTo(manual.boundingSize.width, 0.05));
      expect(scanned.boundingSize.length, closeTo(manual.boundingSize.length, 0.05));
      expect(scanned.ceilingHeightM, closeTo(manual.ceilingHeightM, 1e-6));

      final sLens = scanned.walls.map((w) => w.lengthM).toList()..sort();
      final mLens = manual.walls.map((w) => w.lengthM).toList()..sort();
      for (var i = 0; i < 4; i++) {
        expect(sLens[i], closeTo(mLens[i], 0.05));
      }
    });
  });

  group('RoomScanConverter — straightening (±3°)', () {
    test('a room rotated 2° snaps square (within tolerance)', () {
      final plan = RoomScanConverter.toRoomDraft(_rect(w: 4, l: 3, rotDeg: 2)).plan;
      expect(plan.corners, hasLength(4));
      expect(plan.isAxisAlignedRect, isTrue,
          reason: 'a 2° tilt is within ±3° and should snap to axis');
      expect(plan.boundingSize.width, closeTo(4, 0.1));
      expect(plan.boundingSize.length, closeTo(3, 0.1));
    });

    test('a room rotated 15° keeps its free angle (not over-straightened)', () {
      final plan = RoomScanConverter.toRoomDraft(_rect(w: 4, l: 3, rotDeg: 15)).plan;
      expect(plan.corners, hasLength(4));
      expect(plan.isAxisAlignedRect, isFalse,
          reason: '15° is well outside ±3° and must not be forced square');
    });
  });

  group('RoomScanConverter — defensive', () {
    test('empty room yields an invalid plan (no crash)', () {
      final draft = RoomScanConverter.toRoomDraft(const CapturedRoom());
      expect(draft.objects, isEmpty);
      expect(draft.plan.isValid, isFalse);
    });
  });
}
