import 'package:riverpod/riverpod.dart';
import '../models/room_model.dart';
import '../repositories/room_repository.dart';
import 'auth_provider.dart';

/// Provider for RoomRepository
final roomRepositoryProvider = Provider<RoomRepository>((ref) {
  return RoomRepositoryImpl(ref.watch(apiClientProvider));
});

/// Notifier for managing active room state
class ActiveRoomNotifier extends StateNotifier<Room?> {
  ActiveRoomNotifier(this._repository) : super(null);

  final RoomRepository _repository;

  /// Create a new room from measurement data
  Future<void> createFromMeasurement({
    required double width,
    required double length,
    required double height,
    required String name,
  }) async {
    try {
      final room = Room(
        id: '',
        name: name,
        dimensions: RoomDimensions(
          width: width,
          length: length,
          height: height,
        ),
        walls: [],
        doors: [],
        windows: [],
        createdAt: DateTime.now(),
      );

      final created = await _repository.create(room);
      state = created;
    } catch (e) {
      rethrow;
    }
  }

  /// Load an existing room by ID
  Future<void> loadById(String id) async {
    try {
      final room = await _repository.getById(id);
      state = room;
    } catch (e) {
      rethrow;
    }
  }

  /// Update the active room
  Future<void> update(Room room) async {
    try {
      final updated = await _repository.update(room);
      state = updated;
    } catch (e) {
      rethrow;
    }
  }

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
  return ActiveRoomNotifier(ref.watch(roomRepositoryProvider));
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
