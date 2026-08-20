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

/// Maps a [RoomPlan] onto the existing (rectangular) room pipeline and persists
/// it, returning the backend room id (or null when offline).
///
/// The backend room + web 3D Studio currently render a rectangular room, so a
/// general N-corner plan is handed off by its axis-aligned bounding size
/// (width × length). This is the single funnel every capture method already
/// uses: wallMeasurementsProvider → active room → ensurePersisted → /studio.
/// The full polygon lives on in [RoomPlan] as a clean extension point for a
/// future polygon-aware Studio.
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

  await ref.read(roomPersistenceProvider.notifier).ensurePersisted();
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
