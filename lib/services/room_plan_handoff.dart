import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/design_selection_model.dart';
import '../models/room_plan.dart';
import '../providers/design_provider.dart';
import '../providers/room_persistence_provider.dart';
import '../providers/room_provider.dart';
import '../screens/home/home_empty_screen.dart';
import '../utils/room_geometry_mapper.dart';

/// The historical name every drawn room has always carried. Kept constant so
/// the persisted room name (and the Home project name) don't change when the
/// in-app source of truth is the polygon plan.
const _drawnRoomName = 'Mening xonam';

/// Maps a [RoomPlan] onto the existing room pipeline and persists it, returning
/// the backend room id (or null when offline).
///
/// Local display: the polygon plan is the source of truth
/// ([activeRoomPlanProvider]) — so estimates are accurate for
/// L-shapes/trapezoids — while display widgets still receive a bounding
/// rectangle via [RoomPlan.toLegacyRoom] pushed into [activeRoomProvider].
///
/// What gets PERSISTED depends on the shape:
/// - a plain axis-aligned rectangle keeps the legacy 4-wall A–D bounding body
///   (its studio renderer is nicer for plain boxes);
/// - a real polygon (L-shape, trapezoid, triangle, skewed quad, …) is persisted
///   with its true [RoomGeometryCreate.vertices] + one wall per edge (ids
///   `'0'..'N-1'`), so the web 3D Studio's N-wall renderer draws the actual
///   shape instead of a box.
Future<String?> handoffRoomPlan(WidgetRef ref, RoomPlan plan) async {
  // Polygon source of truth. The derived bounding room (named as before) feeds
  // display widgets and the rectangle-persistence path, so backend behavior is
  // unchanged; the true plan feeds estimates.
  final roomId = DateTime.now().microsecondsSinceEpoch.toString();
  ref.read(activeRoomPlanProvider.notifier).setPlan(
        plan,
        legacyRoomId: roomId,
        legacyName: _drawnRoomName,
      );
  _registerDesignAndHome(ref, roomId, _drawnRoomName);

  // Rectangles → legacy A–D bounding body; real polygons → true vertices + N
  // non-ABCD walls so the studio renders the actual shape.
  final override = plan.isAxisAlignedRect
      ? null
      : roomPlanToPolygonRoomCreate(
          plan,
          name: ref.read(activeRoomProvider)?.name ?? 'Xona',
        );

  await ref
      .read(roomPersistenceProvider.notifier)
      .ensurePersisted(override: override);
  return ref.read(roomPersistenceProvider).valueOrNull?.roomId;
}

/// Registers the drawn room's design selection and Home project so it appears on
/// Home.
void _registerDesignAndHome(WidgetRef ref, String roomId, String name) {
  ref.read(activeDesignProvider.notifier).setLocal(
        DesignSelection(
          id: '${roomId}_design',
          roomId: roomId,
          stage: DesignStage.floor,
          renovationStage: RenovationStage.suvoq,
        ),
      );
  ref.read(homeStateProvider.notifier).addProject(
        ProjectItem(
          id: roomId,
          name: name,
          location: '',
          roomCount: 1,
          createdAt: DateTime.now(),
        ),
      );
}
