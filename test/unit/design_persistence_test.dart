import 'package:flutter_test/flutter_test.dart';
import 'package:tamir_uy_mobile_flutter/models/api/api.dart';

/// Fixtures are REAL responses captured from the running backend on 2026-08-05
/// (PUT decoration + PUT electrical), verifying the Phase 4 models.
void main() {
  group('Decoration', () {
    test('parses a real decoration payload', () {
      final d = Decoration.fromJson({
        'room_id': 'ad739348-d884-4810-96ab-5395120a4909',
        'walls': {
          'material_id': '2f772bf6-867a-4904-9039-b81f6b8f0b18',
          'finish': 'paint',
          'color': '#FFFFFF',
        },
        'floor': {'material_id': '3d34403f-3b69-4793-a4d8-55d5be546d3a'},
        'ceiling': {'material_id': null},
        'furniture': [],
        'updated_at': '2026-08-05T18:47:48.300064Z',
      });

      expect(d.walls.materialId, '2f772bf6-867a-4904-9039-b81f6b8f0b18');
      expect(d.walls.finish, 'paint');
      expect(d.walls.color, '#FFFFFF');
      expect(d.floor.materialId, '3d34403f-3b69-4793-a4d8-55d5be546d3a');
      expect(d.ceiling.materialId, isNull);
      expect(d.furniture, isEmpty);
    });
  });

  group('ElectricalPlan', () {
    test('parses a real electrical plan (two devices + wiring)', () {
      final plan = ElectricalPlan.fromJson({
        'room_id': 'ad739348-d884-4810-96ab-5395120a4909',
        'devices': [
          {
            'id': 'baa82bd0-caa6-4ebb-aac8-0768b9559657',
            'room_id': 'ad739348-d884-4810-96ab-5395120a4909',
            'type': 'socket',
            'variant': 'double',
            'wall_index': 0,
            'x': 1.2,
            'y': 0.3,
            'count': 2,
          },
          {
            'id': 'faaa54b2-818a-425b-9a5a-15ebddfadab0',
            'room_id': 'ad739348-d884-4810-96ab-5395120a4909',
            'type': 'switch',
            'variant': null,
            'wall_index': 0,
            'x': 0.1,
            'y': 1.4,
            'count': 1,
          },
        ],
        'wiring_meters': 42.5,
        'updated_at': '2026-08-05T18:47:48.357219Z',
      });

      expect(plan.devices, hasLength(2));
      expect(plan.wiringMeters, 42.5);

      final socket = plan.devices.first;
      expect(socket.type, ElectricalDeviceType.socket);
      expect(socket.variant, 'double');
      expect(socket.count, 2);

      final sw = plan.devices.last;
      expect(sw.type, ElectricalDeviceType.switch_);
      expect(sw.variant, isNull);
      expect(sw.wallIndex, 0);
    });
  });
}
