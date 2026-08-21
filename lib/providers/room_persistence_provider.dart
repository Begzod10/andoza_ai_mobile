import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/api/api.dart';
import '../models/design_selection_model.dart';
import '../utils/room_geometry_mapper.dart';
import 'apartment_provider.dart';
import 'design_provider.dart';
import 'estimate_api_provider.dart';
import 'room_provider.dart';

/// A room that has been persisted to the backend, tying the local client-room
/// id to the returned server [RoomOut] (whose `id` is the backend room id used
/// for state/delta/estimate calls).
class PersistedRoom {
  const PersistedRoom({required this.clientRoomId, required this.room});

  final String clientRoomId;
  final RoomOut room;

  String get roomId => room.id;
}

/// Persists the active captured room to the backend (creating an apartment if
/// the user has none) and records its construction state from the captured room
/// condition. Idempotent per client room: calling [ensurePersisted] again for
/// the same local room is a no-op.
///
/// State is an [AsyncValue]: `AsyncData(null)` = nothing persisted yet,
/// `AsyncData(PersistedRoom)` = done, `AsyncError` = the backend was
/// unreachable/unauthenticated (callers fall back to local computation).
class RoomPersistenceNotifier
    extends StateNotifier<AsyncValue<PersistedRoom?>> {
  RoomPersistenceNotifier(this._ref) : super(const AsyncValue.data(null));

  final Ref _ref;

  /// Persists the active room. When [override] is provided it is sent to the
  /// backend verbatim instead of mapping the (bounding-rectangle) active room —
  /// used by the sketch handoff to persist a real polygon's true vertices + N
  /// walls while the local display providers keep the bounding room for Home /
  /// Studio-open. Idempotency is still keyed on the active client room id.
  Future<void> ensurePersisted({RoomCreate? override}) async {
    final clientRoom = _ref.read(activeRoomProvider);
    if (clientRoom == null) {
      state = const AsyncValue.data(null);
      return;
    }

    // Already persisted this exact captured room — nothing to do.
    final current = state.valueOrNull;
    if (current != null && current.clientRoomId == clientRoom.id) return;

    state = const AsyncValue.loading();
    try {
      final aptRepo = _ref.read(apartmentRepositoryProvider);
      final stateRepo = _ref.read(roomStateRepositoryProvider);

      // Reuse the user's first apartment, or create a default one.
      final apartments = await aptRepo.listApartments();
      final apartmentId = apartments.isNotEmpty
          ? apartments.first.id
          : (await aptRepo.createApartment(name: 'Mening uyim')).id;

      final room = await aptRepo.createRoom(
        apartmentId,
        override ?? roomToRoomCreate(clientRoom),
      );

      // Record the captured starting condition so the delta excludes stages
      // the room already has (the "tejaldingiz" mechanic).
      final condition = _ref.read(activeDesignProvider)?.roomCondition?.wall;
      final stateValue = _conditionToState(condition);
      if (stateValue != null && stateValue != RoomStateValue.xom) {
        await stateRepo.setState(room.id, currentState: stateValue);
      }

      state = AsyncValue.data(
        PersistedRoom(clientRoomId: clientRoom.id, room: room),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Assigns [materialId] to the given [surfaces] (e.g. `['A','B','C','D']` or
  /// `['floor']`) on the persisted backend room, merging with any existing
  /// surface map. This is what makes the smeta and delta reflect the user's
  /// real material choices (the engine prices from `room.surfaces`).
  ///
  /// No-op if nothing is persisted yet. Refreshes the estimate/delta providers
  /// so dependent screens recompute. Returns silently on failure — surface
  /// persistence is best-effort and must never block the design UI.
  Future<void> setSurfaceMaterials({
    required List<String> surfaces,
    required String materialId,
  }) async {
    final persisted = state.valueOrNull;
    if (persisted == null) return;
    try {
      final aptRepo = _ref.read(apartmentRepositoryProvider);
      final merged = <String, dynamic>{
        ...?persisted.room.surfaces,
        for (final s in surfaces) s: materialId,
      };
      final updated = await aptRepo.updateRoom(
        persisted.roomId,
        surfaces: merged,
      );
      state = AsyncValue.data(
        PersistedRoom(clientRoomId: persisted.clientRoomId, room: updated),
      );
      // Let the smeta/delta refetch with the new surfaces.
      _ref.invalidate(roomDeltaProvider(persisted.roomId));
      _ref.invalidate(estimatePreviewProvider(persisted.roomId));
    } catch (_) {
      // Best-effort: keep the current state on failure.
    }
  }

  /// Maps the captured wall condition to the backend construction stage.
  RoomStateValue? _conditionToState(SurfaceCondition? condition) {
    return switch (condition) {
      SurfaceCondition.raw => RoomStateValue.xom,
      SurfaceCondition.plastered => RoomStateValue.suvoq,
      SurfaceCondition.puttied => RoomStateValue.shpaklovka,
      null => null,
    };
  }
}

final roomPersistenceProvider = StateNotifierProvider<RoomPersistenceNotifier,
    AsyncValue<PersistedRoom?>>((ref) => RoomPersistenceNotifier(ref));
