import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:tamir_uy_mobile_flutter/features/room_scan/models/captured_room.dart';

/// The shared fixture — the SAME file backs the backend converter parity test
/// (Phase 4). If you edit one, edit both.
Map<String, dynamic> _loadFixture() {
  final raw = File('test/features/room_scan/fixtures/captured_room_sample.json')
      .readAsStringSync();
  return jsonDecode(raw) as Map<String, dynamic>;
}

void main() {
  group('parseCapturedRoom (fixture)', () {
    late CapturedRoom room;

    setUp(() => room = parseCapturedRoom(_loadFixture()));

    test('counts each surface list and objects', () {
      expect(room.walls, hasLength(4));
      expect(room.doors, hasLength(1));
      expect(room.windows, hasLength(1));
      expect(room.openings, isEmpty);
      expect(room.objects, hasLength(2));
    });

    test('wall dimensions parse as [x=length, y=height, z=thickness] metres', () {
      expect(room.walls[0].dimensions.x, 4.0);
      expect(room.walls[0].dimensions.y, 2.5);
      expect(room.walls[1].dimensions.x, 3.0);
    });

    test('transform translation is the 4th column (indices 12,13,14)', () {
      final t = room.walls[0].transform.translation;
      expect(t.x, 0.0);
      expect(t.y, 1.25);
      expect(t.z, -1.5);
    });

    test('yaw of an axis-aligned wall (identity rotation) is 0', () {
      expect(room.walls[0].transform.yRotationRad, closeTo(0.0, 1e-9));
    });

    test('confidence strings map to the enum', () {
      expect(room.walls[0].confidence, ScanConfidence.high);
      expect(room.walls[2].confidence, ScanConfidence.medium);
    });

    test('object categories map to the internal enum', () {
      expect(room.objects[0].category, ScanObjectCategory.table);
      expect(room.objects[1].category, ScanObjectCategory.chair);
      expect(room.objects[0].dimensions.x, 1.2);
    });
  });

  group('parseCapturedRoom (defensive)', () {
    test('empty / non-map input yields an empty room, never throws', () {
      final room = parseCapturedRoom(<String, dynamic>{});
      expect(room.walls, isEmpty);
      expect(room.objects, isEmpty);
    });

    test('unknown object category falls back to other', () {
      final room = parseCapturedRoom({
        'objects': [
          {
            'category': 'spaceship',
            'dimensions': [1.0, 1.0, 1.0],
            'transform': [1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1],
          }
        ],
      });
      expect(room.objects, hasLength(1));
      expect(room.objects.single.category, ScanObjectCategory.other);
    });

    test('single-key object category form {"chair": {}} is accepted', () {
      final room = parseCapturedRoom({
        'objects': [
          {
            'category': {'chair': <String, dynamic>{}},
            'dimensions': [0.5, 0.9, 0.5],
            'transform': [1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1],
          }
        ],
      });
      expect(room.objects.single.category, ScanObjectCategory.chair);
    });

    test('surface with missing/short dimensions is skipped', () {
      final room = parseCapturedRoom({
        'walls': [
          {'dimensions': [4.0, 2.5, 0.1], 'transform': null},
          {'transform': [1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1]}, // no dims
          {'dimensions': [1.0, 2.0]}, // too short
        ],
      });
      expect(room.walls, hasLength(1));
    });

    test('malformed transform falls back to identity', () {
      final room = parseCapturedRoom({
        'walls': [
          {'dimensions': [4.0, 2.5, 0.1], 'transform': 'not-a-matrix'},
        ],
      });
      final t = room.walls.single.transform;
      expect(t.translation.x, 0.0);
      expect(t.translation.y, 0.0);
      expect(t.translation.z, 0.0);
      expect(t.yRotationRad, 0.0);
    });

    test('nested 4x4 (column-major) transform is flattened correctly', () {
      final room = parseCapturedRoom({
        'walls': [
          {
            'dimensions': [4.0, 2.5, 0.1],
            'transform': [
              [1, 0, 0, 0],
              [0, 1, 0, 0],
              [0, 0, 1, 0],
              [2.0, 1.25, -3.0, 1],
            ],
          }
        ],
      });
      final t = room.walls.single.transform.translation;
      expect(t.x, 2.0);
      expect(t.y, 1.25);
      expect(t.z, -3.0);
    });
  });
}
