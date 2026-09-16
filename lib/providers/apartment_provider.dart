import 'package:riverpod/riverpod.dart';

import '../models/api/api.dart';
import '../models/design_selection_model.dart';
import '../repositories/apartment_repository.dart';
import '../repositories/room_state_repository.dart';
import 'auth_provider.dart';

/// Apartments + rooms repository (backend-aligned).
final apartmentRepositoryProvider = Provider<ApartmentRepository>((ref) {
  return ApartmentRepository(ref.watch(apiClientProvider));
});

/// Room construction-state + delta repository.
final roomStateRepositoryProvider = Provider<RoomStateRepository>((ref) {
  return RoomStateRepository(ref.watch(apiClientProvider));
});

/// The current user's apartments (each with its rooms).
final apartmentsProvider = FutureProvider.autoDispose<List<Apartment>>((ref) {
  return ref.watch(apartmentRepositoryProvider).listApartments();
});

/// Apartment mutations that persist to the backend and then refresh
/// [apartmentsProvider]. Keeps repository writes + the 0-based enum → 1-based
/// backend index mapping out of the widgets, which should only dispatch intent.
final apartmentActionsProvider = Provider<ApartmentActions>((ref) {
  return ApartmentActions(ref);
});

class ApartmentActions {
  ApartmentActions(this._ref);

  final Ref _ref;

  /// Persists [stage] as [apartmentId]'s renovation stage, then invalidates
  /// [apartmentsProvider] so Home/E4/E5 refetch. The backend stores a 1-based
  /// stage index (1..8), so the enum's 0-based index is offset by one.
  Future<void> setRenovationStage(
    String apartmentId,
    RenovationStage stage,
  ) async {
    await _ref
        .read(apartmentRepositoryProvider)
        .updateApartment(apartmentId, renovationStage: stage.index + 1);
    _ref.invalidate(apartmentsProvider);
  }
}

/// A single room's construction-progress state, by room id.
final roomStateProvider =
    FutureProvider.autoDispose.family<RoomState, String>((ref, roomId) {
  return ref.watch(roomStateRepositoryProvider).getState(roomId);
});

/// The authoritative delta (material/cost difference vs a finished room), by
/// room id. Drives the real "tejaldingiz" (you saved) figure.
final roomDeltaProvider =
    FutureProvider.autoDispose.family<DeltaResponse, String>((ref, roomId) {
  return ref.watch(roomStateRepositoryProvider).getDelta(roomId);
});
