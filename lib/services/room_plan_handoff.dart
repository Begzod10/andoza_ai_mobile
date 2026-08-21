import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/design_selection_model.dart';
import '../models/room_model.dart' as room_model;
import '../models/room_model.dart' show WallType;
import '../models/room_plan.dart';
import '../providers/design_provider.dart';
import '../providers/room_persistence_provider.dart';
import '../providers/room_provider.dart';
import '../screens/home/home_empty_screen.dart';
import '../screens/room_setup/wall_measurements_screen.dart';
import '../utils/room_geometry_mapper.dart';

/// Maps a [RoomPlan] onto the existing room pipeline and persists it, returning
/// the backend room id (or null when offline).
///
/// The local display providers (active room, home project) always use the plan's
/// axis-aligned bounding size (width × length) — that keeps Home and the
/// Studio-open flow on the single funnel every capture method already uses:
/// wallMeasurementsProvider → active room → ensurePersisted → /studio.
///
/// What gets PERSISTED depends on the shape:
/// - a plain axis-aligned rectangle keeps the legacy 4-wall A–D bounding body
///   (its studio renderer is nicer for plain boxes);
/// - a real polygon (L-shape, trapezoid, triangle, skewed quad, …) is persisted
///   with its true [RoomGeometryCreate.vertices] + one wall per edge (ids
///   `'0'..'N-1'`), so the web 3D Studio's N-wall renderer draws the actual
///   shape instead of a box.
Future<String?> handoffRoomPlan(WidgetRef ref, RoomPlan plan) async {
  final b = plan.boundingSize;
  final w = double.parse(b.width.toStringAsFixed(2));
  final l = double.parse(b.length.toStringAsFixed(2));
  final h = plan.ceilingHeightM;

  final wm = ref.read(wallMeasurementsProvider.notifier);
  wm.updateWall(WallType.wallA, length: l, height: h);
  wm.updateWall(WallType.wallB, length: w, height: h);
  wm.updateWall(WallType.wallC, length: l, height: h);
  wm.updateWall(WallType.wallD, length: w, height: h);

  _setupActiveRoom(ref);

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

/// Builds the active room/design/home-project from the current wall
/// measurements — mirrors the 3D wizard's setup so downstream flows match.
void _setupActiveRoom(WidgetRef ref) {
  final walls = ref.read(wallMeasurementsProvider);
  final roomId = DateTime.now().microsecondsSinceEpoch.toString();

  final modelWalls = <room_model.Wall>[
    for (final wall in walls)
      room_model.Wall(
        id: '${roomId}_${wall.type.name}',
        type: wall.type,
        measurements: room_model.WallMeasurements(
          height: wall.height,
          length: wall.length,
        ),
      ),
  ];

  final wallA = walls.firstWhere((w) => w.type == WallType.wallA);
  final wallB = walls.firstWhere((w) => w.type == WallType.wallB);

  final room = room_model.Room(
    id: roomId,
    name: 'Mening xonam',
    dimensions: room_model.RoomDimensions(
      width: wallB.length,
      length: wallA.length,
      height: wallA.height,
    ),
    walls: modelWalls,
    doors: const [],
    windows: const [],
    createdAt: DateTime.now(),
  );
  ref.read(activeRoomProvider.notifier).setLocal(room);
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
          name: room.name,
          location: '',
          roomCount: 1,
          createdAt: DateTime.now(),
        ),
      );
}
