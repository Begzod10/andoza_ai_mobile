import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:tamir_uy_mobile_flutter/geometry/room_geometry.dart';
import 'package:tamir_uy_mobile_flutter/models/room_plan.dart';
import 'package:tamir_uy_mobile_flutter/providers/room_provider.dart';

/// A plain 4×3 axis-aligned rectangle (metres).
List<Vec2> _rect() => const [Vec2(0, 0), Vec2(4, 0), Vec2(4, 3), Vec2(0, 3)];

void main() {
  group('activeRoomPlanProvider ↔ activeRoomProvider sync', () {
    test('setPlan holds the plan AND mirrors a bounding Room', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(activeRoomPlanProvider), isNull);
      expect(container.read(activeRoomProvider), isNull);

      final plan = RoomPlan.fromCorners(
        _rect(),
        ceilingHeightM: 2.8,
        source: RoomSource.wizard,
        name: 'Zal',
      );
      container.read(activeRoomPlanProvider.notifier).setPlan(plan);

      // The plan itself is the polygon source of truth.
      expect(container.read(activeRoomPlanProvider), same(plan));

      // The legacy Room mirrors the plan's bounding box for display consumers.
      final room = container.read(activeRoomProvider);
      expect(room, isNotNull);
      expect(room!.name, 'Zal');
      expect(room.dimensions.width, closeTo(4.0, 1e-9));
      expect(room.dimensions.length, closeTo(3.0, 1e-9));
      expect(room.dimensions.height, closeTo(2.8, 1e-9));
      expect(room.walls, hasLength(4));
    });

    test('clear resets the plan', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final plan = RoomPlan.fromCorners(
        _rect(),
        ceilingHeightM: 2.8,
        source: RoomSource.wizard,
      );
      container.read(activeRoomPlanProvider.notifier).setPlan(plan);
      expect(container.read(activeRoomPlanProvider), isNotNull);

      container.read(activeRoomPlanProvider.notifier).clear();
      expect(container.read(activeRoomPlanProvider), isNull);
    });
  });
}
