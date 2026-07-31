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

  /// Local-only variant of [setRoomCondition] — no backend round-trip. Used
  /// from B1, since the active design was itself created via [setLocal]
  /// (no server id to PUT against yet).
  void setRoomConditionLocal(RoomCondition condition) {
    if (state == null) return;
    state = state!.copyWith(roomCondition: condition);
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
        furniture: state!.furniture.where((f) => f.id != furnitureId).toList(),
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

  /// Advance to the next canonical renovation stage (Suvoq → ... → Santexnika).
  /// This is the precise 8-stage tracker consumed by every delta-aware
  /// stage-line/progress-bar widget — separate from the coarser [DesignStage]
  /// workflow field above, which only tracks floor/paint/furniture/completed.
  /// Local-only — see [setRoomConditionLocal]'s doc for why: the backend
  /// has no `/api/v1/designs` endpoint to persist this against yet, and
  /// this method is called constantly throughout Batches B/C/D, so it must
  /// not depend on that integration existing.
  void advanceRenovationStage() {
    if (state == null) return;

    final current = state!.renovationStage;
    final next = current.index < RenovationStage.values.length - 1
        ? RenovationStage.values[current.index + 1]
        : current;
    if (next == current) return;

    state = state!.copyWith(renovationStage: next);
  }

  /// Jumps directly to [stage], skipping intermediate stages — used when a
  /// prior stage was never actionable (e.g. Batch B lands the user
  /// directly on Bo'yoq/Oboi because Suvoq/Shpaklovka were either already
  /// excluded by the room's condition or aren't separately worked in the
  /// UI at all).
  void setRenovationStageLocal(RenovationStage stage) {
    if (state == null) return;
    state = state!.copyWith(renovationStage: stage);
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

  /// Sets the active design directly from local data, bypassing the
  /// backend (no `/api/v1/designs` round-trip — that endpoint doesn't
  /// exist on the backend yet). Used for the A9→B1 handoff; see
  /// [ActiveRoomNotifier.setLocal] in room_provider.dart for the same
  /// rationale.
  void setLocal(DesignSelection design) {
    state = design;
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

/// Computed provider: the delta-mechanic display state of every one of the
/// 8 canonical [RenovationStage]s for the active design, in stage order.
/// Returns `null` when there's no active design or its baseline
/// [RoomCondition] hasn't been set yet (Batch B not completed) — consumers
/// must handle that case rather than assume a default condition.
final renovationStageStatesProvider = Provider<List<StageDisplayState>?>((ref) {
  final design = ref.watch(activeDesignProvider);
  final condition = design?.roomCondition;
  if (design == null || condition == null) return null;

  return deriveStageStates(
    condition: condition,
    currentStage: design.renovationStage,
  );
});
