import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tamir_uy_mobile_flutter/geometry/room_geometry.dart';
import 'package:tamir_uy_mobile_flutter/models/api/api.dart';
import 'package:tamir_uy_mobile_flutter/models/room_plan.dart';
import 'package:tamir_uy_mobile_flutter/providers/estimate_provider.dart';
import 'package:tamir_uy_mobile_flutter/providers/room_persistence_provider.dart';
import 'package:tamir_uy_mobile_flutter/providers/room_provider.dart';
import 'package:tamir_uy_mobile_flutter/services/room_plan_handoff.dart';

/// A no-op persistence notifier so the handoff doesn't hit the network — we only
/// assert on the local (in-app) source-of-truth state the handoff sets.
class _FakePersistence extends RoomPersistenceNotifier {
  _FakePersistence(super.ref);
  @override
  Future<void> ensurePersisted({RoomCreate? override}) async {}
}

/// An L-shaped room: 4×4 bounding box, true polygon area 12 m² (6 corners).
List<Vec2> _lShape() => const [
      Vec2(0, 0),
      Vec2(4, 0),
      Vec2(4, 2),
      Vec2(2, 2),
      Vec2(2, 4),
      Vec2(0, 4),
    ];

void main() {
  testWidgets(
    'drawn L-shape handoff makes the polygon plan the source of truth',
    (tester) async {
      late WidgetRef ref;
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            roomPersistenceProvider.overrideWith((r) => _FakePersistence(r)),
          ],
          child: Consumer(
            builder: (context, r, _) {
              ref = r;
              return const SizedBox();
            },
          ),
        ),
      );

      final plan = RoomPlan.fromCorners(
        _lShape(),
        ceilingHeightM: 2.8,
        source: RoomSource.sketch,
      );

      await handoffRoomPlan(ref, plan);
      await tester.pump();

      final container = ProviderScope.containerOf(
        tester.element(find.byType(SizedBox)),
      );

      // The true polygon is now the in-app source of truth.
      final active = container.read(activeRoomPlanProvider);
      expect(active, isNotNull);
      expect(active!.corners.length, greaterThan(4));
      expect(active.areaM2, closeTo(12.0, 1e-9));

      // Display widgets still get a bounding rectangle (4 walls) via toLegacyRoom.
      final legacy = container.read(activeRoomProvider);
      expect(legacy, isNotNull);
      expect(legacy!.walls, hasLength(4));
      // Persistence name is preserved so backend behavior is unchanged.
      expect(legacy.name, 'Mening xonam');

      // The estimate uses the TRUE polygon area (12 m²), not the 16 m² box.
      final estimate = container.read(estimateProvider);
      expect(estimate.roomArea, closeTo(12.0, 1e-9));
    },
  );
}
