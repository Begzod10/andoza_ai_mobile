import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/room_scan/flat_layout.dart';
import '../features/room_scan/room_scan_converter.dart';
import '../models/room_plan.dart';
import '../providers/apartment_provider.dart';
import '../providers/room_persistence_provider.dart';
import '../utils/room_geometry_mapper.dart';
import 'room_plan_handoff.dart';

/// Room creation stopped part-way; [createdIds] are the rooms already saved.
class FlatHandoffException implements Exception {
  const FlatHandoffException(this.createdIds, this.cause);
  final List<String> createdIds;
  final Object cause;

  @override
  String toString() => 'FlatHandoffException(created: $createdIds, cause: $cause)';
}

/// Saves the rooms of one multi-room scan into one apartment, each at its
/// place in the flat (`state.layoutPos`, which the web studio reads), and
/// returns their backend ids in input order.
///
/// The first room goes through [handoffRoomPlan], so the apartment is picked
/// (or created) exactly as for a single scanned room; the others are created
/// in that apartment.
Future<List<String>> handoffScannedFlat(
  WidgetRef ref,
  List<RoomScanDraft> drafts, {
  required List<String> names,
  required List<double> ceilings,
}) async {
  final positions = flatLayoutPositions(drafts);
  final repo = ref.read(apartmentRepositoryProvider);
  final ids = <String>[];
  try {
    for (var i = 0; i < drafts.length; i++) {
      final p = drafts[i].plan;
      final plan = RoomPlan(
        corners: p.corners,
        walls: p.walls,
        ceilingHeightM: ceilings[i],
        source: p.source,
        name: names[i],
      );
      final String id;
      if (i == 0) {
        final first = await handoffRoomPlan(ref, plan);
        if (first == null) throw StateError('the first room was not saved');
        id = first;
      } else {
        final aptId = ref.read(roomPersistenceProvider).valueOrNull!.room.apartmentId;
        id = (await repo.createRoom(aptId, roomPlanToPolygonRoomCreate(plan, name: names[i]))).id;
      }
      ids.add(id);
      await repo.updateRoom(id, name: names[i], state: {
        'layoutPos': {'x': positions[i].x, 'z': positions[i].z},
      });
    }
  } catch (e) {
    throw FlatHandoffException(List.unmodifiable(ids), e);
  }
  return ids;
}
