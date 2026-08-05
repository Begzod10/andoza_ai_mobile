import 'package:flutter_test/flutter_test.dart';
import 'package:tamir_uy_mobile_flutter/models/api/api.dart';
import 'package:tamir_uy_mobile_flutter/models/room_model.dart' as client;
import 'package:tamir_uy_mobile_flutter/utils/room_geometry_mapper.dart';

/// Fixtures below are REAL responses captured from the running backend on
/// 2026-08-04 (create room, then GET delta), so these verify the Phase 2
/// models against the actual wire format.
void main() {
  group('RoomOut', () {
    test('parses a real created-room payload with computed metrics', () {
      final room = RoomOut.fromJson({
        'id': 'b37bf2ae-4113-4f25-a7d7-7e04c2331e18',
        'apartment_id': '21f0673f-7626-472c-a2cc-1a5f3ce24c8e',
        'name': 'Mehmonxona',
        'ceiling_h': 2.8,
        'geometry': {
          'walls': [
            {'id': 'A', 'length': 4.5, 'elements': []},
          ],
          'vertices': [
            [0.0, 0.0],
            [4.5, 0.0],
          ],
        },
        'surfaces': null,
        'furniture_layout': null,
        'state': null,
        'floor_area': 16.2,
        'net_wall_area': 41.37,
        'perimeter': 16.2,
        'openings_count': 2,
        'updated_at': '2026-08-04T17:18:30.822139Z',
      });

      expect(room.apartmentId, '21f0673f-7626-472c-a2cc-1a5f3ce24c8e');
      expect(room.ceilingH, 2.8);
      expect(room.floorArea, 16.2);
      expect(room.openingsCount, 2);
      expect(room.surfaces, isNull);
      expect(room.geometry, isNotNull);
    });
  });

  group('DeltaResponse', () {
    test('parses a real delta payload (stages + lines)', () {
      final delta = DeltaResponse.fromJson({
        'room_id': 'b37bf2ae-4113-4f25-a7d7-7e04c2331e18',
        'current_state': 'suvoq',
        'full_lines': [
          {
            'label': 'Elektr kabel (taxminiy)',
            'formula': '8 nuqta × 8.0 m × 1.15 (zaxira) = 74 m',
            'quantity': 74.0,
            'unit': 'm',
            'unit_price': 10000,
            'total_uzs': 740000,
            'is_approximate': true,
            'store_id': null,
            'category': 'elektr',
          },
        ],
        'full_total_uzs': 0,
        'delta_lines': [],
        'delta_total_uzs': 0,
        'delta_savings_uzs': 0,
        'completed_stages': [
          {'stage': 'xom', 'label_uz': 'Qora qurilish (korobka)', 'already_done': true},
        ],
        'remaining_stages': [
          {'stage': 'suvoq', 'label_uz': 'Suvoq', 'already_done': false},
          {'stage': 'shpaklovka', 'label_uz': 'Shpaklovka / Grunt', 'already_done': false},
          {'stage': 'tayyor', 'label_uz': 'Pardoz (tayyor)', 'already_done': false},
        ],
      });

      expect(delta.currentState, RoomStateValue.suvoq);
      expect(delta.deltaSavingsUzs, 0);
      expect(delta.fullLines.single.label, 'Elektr kabel (taxminiy)');
      expect(delta.fullLines.single.isApproximate, isTrue);
      expect(delta.completedStages.single.stage, RoomStateValue.xom);
      expect(delta.remainingStages, hasLength(3));
      expect(delta.remainingStages.first.labelUz, 'Suvoq');
    });
  });

  group('roomToRoomCreate mapper', () {
    test('maps a captured 4-wall room with a door and window', () {
      final room = client.Room(
        id: 'r1',
        name: 'Mehmonxona',
        createdAt: DateTime(2026, 1, 1),
        dimensions: const client.RoomDimensions(width: 4.5, height: 2.8, length: 3.6),
        walls: [
          client.Wall(
            id: 'wA',
            type: client.WallType.wallA,
            measurements: client.WallMeasurements(height: 2.8, length: 4.5),
          ),
          client.Wall(
            id: 'wB',
            type: client.WallType.wallB,
            measurements: client.WallMeasurements(height: 2.8, length: 3.6),
          ),
          client.Wall(
            id: 'wC',
            type: client.WallType.wallC,
            measurements: client.WallMeasurements(height: 2.8, length: 4.5),
          ),
        ],
        doors: [
          client.Door(
            id: 'd1',
            wallId: 'wA',
            position: 0.5,
            width: 0.9,
            height: 2.1,
            type: client.OpeningType.single,
          ),
        ],
        windows: [
          client.Window(
            id: 'win1',
            wallId: 'wB',
            position: 0.4,
            width: 1.4,
            height: 1.5,
            type: client.OpeningType.single,
          ),
        ],
      );

      final body = roomToRoomCreate(room);
      expect(body.name, 'Mehmonxona');
      expect(body.ceilingH, 2.8);
      expect(body.geometry.walls, hasLength(3)); // backend requires >= 3

      final wallA = body.geometry.walls.firstWhere((w) => w.id == 'A');
      expect(wallA.length, 4.5);
      expect(wallA.elements.single.type, WallElementType.eshik);
      expect(wallA.elements.single.sillHeight, 0.0);

      final wallB = body.geometry.walls.firstWhere((w) => w.id == 'B');
      expect(wallB.elements.single.type, WallElementType.deraza);
      expect(wallB.elements.single.sillHeight, 0.9);
      expect(wallB.elements.single.position, 0.4);
    });

    test('clamps out-of-range measurements into backend bounds', () {
      final room = client.Room(
        id: 'r2',
        name: '',
        createdAt: DateTime(2026, 1, 1),
        dimensions: const client.RoomDimensions(width: 3, height: 9, length: 3),
        walls: [
          client.Wall(
            id: 'wA',
            type: client.WallType.wallA,
            measurements: client.WallMeasurements(height: 9, length: 40),
          ),
          client.Wall(
            id: 'wB',
            type: client.WallType.wallB,
            measurements: client.WallMeasurements(height: 9, length: 3),
          ),
          client.Wall(
            id: 'wC',
            type: client.WallType.wallC,
            measurements: client.WallMeasurements(height: 9, length: 3),
          ),
        ],
      );

      final body = roomToRoomCreate(room);
      expect(body.name, 'Xona'); // empty name gets a default
      expect(body.ceilingH, 6.0); // 9 clamped to max
      expect(body.geometry.walls.first.length, 24.9); // 40 clamped
    });
  });
}
