import 'package:riverpod/riverpod.dart';
import '../models/design_selection_model.dart';
import '../repositories/design_repository.dart';
import 'auth_provider.dart';

/// Provider for DesignRepository
final designRepositoryProvider = Provider<DesignRepository>((ref) {
  return DesignRepositoryImpl(ref.watch(apiClientProvider));
});

/// Notifier for managing active design selection state
class ActiveDesignNotifier extends StateNotifier<DesignSelection?> {
  ActiveDesignNotifier(this._repository) : super(null);

  final DesignRepository _repository;

  /// Create a new design selection from a room
  Future<void> createForRoom({
    required String roomId,
    required String roomName,
  }) async {
    try {
      final design = DesignSelection(
        id: '',
        roomId: roomId,
        stage: DesignStage.floor,
        selections: {},
        furniture: [],
      );

      final created = await _repository.create(design);
      state = created;
    } catch (e) {
      rethrow;
    }
  }

  /// Load an existing design by ID
  Future<void> loadById(String id) async {
    try {
      final design = await _repository.getById(id);
      state = design;
    } catch (e) {
      rethrow;
    }
  }

  /// Load design for a specific room
  Future<void> loadByRoomId(String roomId) async {
    try {
      final design = await _repository.getByRoomId(roomId);
      state = design;
    } catch (e) {
      rethrow;
    }
  }

  /// Add or update a material selection for a surface
  Future<void> selectMaterial({
    required String surfaceId,
    required MaterialSelection material,
  }) async {
    if (state == null) return;

    try {
      final updated = state!.copyWith(
        selections: {...state!.selections, surfaceId: material},
      );
      state = updated;
      await _repository.update(updated);
    } catch (e) {
      rethrow;
    }
  }

  /// Set the baseline room condition (for delta calculation)
  Future<void> setRoomCondition(RoomCondition condition) async {
    if (state == null) return;

    try {
      final updated = state!.copyWith(roomCondition: condition);
      state = updated;
      await _repository.update(updated);
    } catch (e) {
      rethrow;
    }
  }

  /// Add a furniture placement
  Future<void> addFurniture(FurniturePlacement furniture) async {
    if (state == null) return;

    try {
      final updated = state!.copyWith(
        furniture: [...state!.furniture, furniture],
      );
      state = updated;
      await _repository.update(updated);
    } catch (e) {
      rethrow;
    }
  }

  /// Update an existing furniture placement
  Future<void> updateFurniture(FurniturePlacement furniture) async {
    if (state == null) return;

    try {
      final index = state!.furniture.indexWhere((f) => f.id == furniture.id);
      if (index == -1) return;

      final updated = state!.copyWith(
        furniture: [
          ...state!.furniture.sublist(0, index),
          furniture,
          ...state!.furniture.sublist(index + 1),
        ],
      );
      state = updated;
      await _repository.update(updated);
    } catch (e) {
      rethrow;
    }
  }

  /// Remove a furniture placement
  Future<void> removeFurniture(String furnitureId) async {
    if (state == null) return;

    try {
      final updated = state!.copyWith(
        furniture: state!.furniture
            .where((f) => f.id != furnitureId)
            .toList(),
      );
      state = updated;
      await _repository.update(updated);
    } catch (e) {
      rethrow;
    }
  }

  /// Progress to the next workflow stage
  Future<void> advanceStage() async {
    if (state == null) return;

    try {
      final nextStage = _getNextStage(state!.stage);
      final updated = state!.copyWith(stage: nextStage);
      state = updated;
      await _repository.update(updated);
    } catch (e) {
      rethrow;
    }
  }

  /// Go back to the previous workflow stage
  Future<void> regressStage() async {
    if (state == null) return;

    try {
      final prevStage = _getPreviousStage(state!.stage);
      if (prevStage != null) {
        final updated = state!.copyWith(stage: prevStage);
        state = updated;
        await _repository.update(updated);
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Mark design selection as completed
  Future<void> complete() async {
    if (state == null) return;

    try {
      final updated = state!.copyWith(stage: DesignStage.completed);
      state = updated;
      await _repository.update(updated);
    } catch (e) {
      rethrow;
    }
  }

  /// Clear the active design
  void clear() {
    state = null;
  }

  DesignStage _getNextStage(DesignStage current) {
    switch (current) {
      case DesignStage.floor:
        return DesignStage.paint;
      case DesignStage.paint:
        return DesignStage.furniture;
      case DesignStage.furniture:
        return DesignStage.completed;
      case DesignStage.completed:
        return DesignStage.completed;
    }
  }

  DesignStage? _getPreviousStage(DesignStage current) {
    switch (current) {
      case DesignStage.floor:
        return null;
      case DesignStage.paint:
        return DesignStage.floor;
      case DesignStage.furniture:
        return DesignStage.paint;
      case DesignStage.completed:
        return DesignStage.furniture;
    }
  }
}

/// Provider for the active design selection
final activeDesignProvider =
    StateNotifierProvider<ActiveDesignNotifier, DesignSelection?>((ref) {
  return ActiveDesignNotifier(ref.watch(designRepositoryProvider));
});

/// Computed provider: is a design currently active?
final hasActiveDesignProvider = Provider<bool>((ref) {
  return ref.watch(activeDesignProvider) != null;
});

/// Computed provider: current design workflow stage
final designStageProvider = Provider<DesignStage?>((ref) {
  final design = ref.watch(activeDesignProvider);
  return design?.stage;
});

/// Computed provider: total material selections count
final materialSelectionsCountProvider = Provider<int>((ref) {
  final design = ref.watch(activeDesignProvider);
  return design?.selections.length ?? 0;
});

/// Computed provider: furniture placements count
final furnitureCountProvider = Provider<int>((ref) {
  final design = ref.watch(activeDesignProvider);
  return design?.furniture.length ?? 0;
});
