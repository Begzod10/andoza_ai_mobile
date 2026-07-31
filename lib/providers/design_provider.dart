import 'package:riverpod/riverpod.dart';
import '../models/design_selection_model.dart';
import '../repositories/design_repository.dart';
import 'auth_provider.dart';

/// Provider for DesignRepository
final designRepositoryProvider = Provider<DesignRepository>((ref) {
  return DesignRepositoryImpl(ref.watch(apiClientProvider));
});

/// Notifier for managing active design selection state.
///
/// Note: the backend has no `/api/v1/designs` endpoint yet (only
/// `/rooms`, `/room-state`, `/decoration`, `/finishes`, `/furniture`) —
/// every mutation below is local-only. `createForRoom`/`loadById`/
/// `loadByRoomId` are kept as the real repository-backed interface for
/// when that endpoint exists, but nothing in this rebuild calls them; the
/// active design is always seeded via [setLocal] from A9's on-device
/// measurement data instead.
class ActiveDesignNotifier extends StateNotifier<DesignSelection?> {
  ActiveDesignNotifier(this._repository) : super(null);

  final DesignRepository _repository;

  /// Create a new design selection from a room (backend-backed — unused
  /// until a `/designs` endpoint exists).
  Future<void> createForRoom({
    required String roomId,
    required String roomName,
  }) async {
    final design = DesignSelection(
      id: '',
      roomId: roomId,
      stage: DesignStage.floor,
      selections: {},
      furniture: [],
    );
    state = await _repository.create(design);
  }

  /// Load an existing design by ID (backend-backed — unused until a
  /// `/designs` endpoint exists).
  Future<void> loadById(String id) async {
    state = await _repository.getById(id);
  }

  /// Load design for a specific room (backend-backed — unused until a
  /// `/designs` endpoint exists).
  Future<void> loadByRoomId(String roomId) async {
    state = await _repository.getByRoomId(roomId);
  }

  /// Sets the active design directly from local data, bypassing the
  /// backend. Used for the A9→B1 handoff.
  void setLocal(DesignSelection design) {
    state = design;
  }

  /// Add or update a material selection for a surface.
  void selectMaterial({
    required String surfaceId,
    required MaterialSelection material,
  }) {
    if (state == null) return;
    state = state!.copyWith(
      selections: {...state!.selections, surfaceId: material},
    );
  }

  /// Set the baseline room condition (for delta calculation).
  void setRoomCondition(RoomCondition condition) {
    if (state == null) return;
    state = state!.copyWith(roomCondition: condition);
  }

  /// Add a furniture placement.
  void addFurniture(FurniturePlacement furniture) {
    if (state == null) return;
    state = state!.copyWith(furniture: [...state!.furniture, furniture]);
  }

  /// Update an existing furniture placement.
  void updateFurniture(FurniturePlacement furniture) {
    if (state == null) return;
    final index = state!.furniture.indexWhere((f) => f.id == furniture.id);
    if (index == -1) return;

    state = state!.copyWith(
      furniture: [
        ...state!.furniture.sublist(0, index),
        furniture,
        ...state!.furniture.sublist(index + 1),
      ],
    );
  }

  /// Remove a furniture placement.
  void removeFurniture(String furnitureId) {
    if (state == null) return;
    state = state!.copyWith(
      furniture: state!.furniture.where((f) => f.id != furnitureId).toList(),
    );
  }

  /// Progress to the next coarse workflow stage.
  void advanceStage() {
    if (state == null) return;
    state = state!.copyWith(stage: _getNextStage(state!.stage));
  }

  /// Go back to the previous coarse workflow stage.
  void regressStage() {
    if (state == null) return;
    final prevStage = _getPreviousStage(state!.stage);
    if (prevStage != null) {
      state = state!.copyWith(stage: prevStage);
    }
  }

  /// Advance to the next canonical renovation stage (Suvoq → ... →
  /// Santexnika). This is the precise 8-stage tracker consumed by every
  /// delta-aware stage-line/progress-bar widget — separate from the
  /// coarser [DesignStage] workflow field above, which only tracks
  /// floor/paint/furniture/completed.
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

  /// Mark design selection as completed.
  void complete() {
    if (state == null) return;
    state = state!.copyWith(stage: DesignStage.completed);
  }

  /// Clear the active design.
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
