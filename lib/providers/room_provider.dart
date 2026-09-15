import 'package:riverpod/riverpod.dart';
import '../models/room_model.dart';
import '../models/room_plan.dart';

/// Notifier for managing active room state.
///
/// The active room is always seeded on-device from A9's measurement data via
/// [setLocal] (see [ActiveRoomPlanNotifier.setPlan] and the A9→B1 handoff) —
/// the backend has no room-creation flow wired up for that handoff yet, so
/// there is intentionally no repository-backed CRUD here.
class ActiveRoomNotifier extends StateNotifier<Room?> {
  ActiveRoomNotifier() : super(null);

  /// Sets the active room directly from locally-captured measurement data,
  /// bypassing the backend (no `/api/v1/rooms` round-trip). The backend has
  /// no room-creation flow wired up for the A9→B1 handoff yet — this keeps
  /// the Batch B/C/D UI/UX exercisable without blocking on that
  /// integration, consistent with Batches U/S also using local/mock data
  /// for this rebuild pass.
  void setLocal(Room room) {
    state = room;
  }

  /// Clear the active room
  void clear() {
    state = null;
  }
}

/// Provider for the active room (created at A9→B1 transition)
final activeRoomProvider = StateNotifierProvider<ActiveRoomNotifier, Room?>((
  ref,
) {
  return ActiveRoomNotifier();
});

/// Notifier for the active [RoomPlan] — the N-corner polygon that is the
/// in-app source of truth for geometry/estimates. Whenever a plan is set it
/// also pushes a derived legacy [Room] (its axis-aligned bounding box) into
/// [activeRoomProvider], so every existing consumer of the legacy room keeps
/// working unchanged while polygon-aware consumers read the true plan.
class ActiveRoomPlanNotifier extends StateNotifier<RoomPlan?> {
  ActiveRoomPlanNotifier(this._ref) : super(null);

  final Ref _ref;

  /// Set the active plan and mirror its bounding box into [activeRoomProvider].
  ///
  /// [legacyRoomId] pins the derived [Room]'s id (so a caller can keep the
  /// design/home-project ids in sync with it); [legacyName] overrides the
  /// mirrored room's display name without changing the plan itself (used to
  /// preserve the historical drawn-room name so backend persistence is
  /// unchanged).
  void setPlan(RoomPlan plan, {String? legacyRoomId, String? legacyName}) {
    state = plan;
    var room = plan.toLegacyRoom(id: legacyRoomId);
    if (legacyName != null) room = room.copyWith(name: legacyName);
    _ref.read(activeRoomProvider.notifier).setLocal(room);
  }

  /// Clear the active plan. Leaves [activeRoomProvider] untouched so legacy
  /// paths that set the room directly aren't disturbed.
  void clear() {
    state = null;
  }
}

/// Provider for the active [RoomPlan] (the polygon source of truth).
final activeRoomPlanProvider =
    StateNotifierProvider<ActiveRoomPlanNotifier, RoomPlan?>((ref) {
  return ActiveRoomPlanNotifier(ref);
});

/// Computed provider: is a room currently active?
final hasActiveRoomProvider = Provider<bool>((ref) {
  return ref.watch(activeRoomProvider) != null;
});

/// Computed provider: active room dimensions
final activeRoomDimensionsProvider = Provider<RoomDimensions?>((ref) {
  final room = ref.watch(activeRoomProvider);
  return room?.dimensions;
});
