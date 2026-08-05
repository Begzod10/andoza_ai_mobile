import 'package:riverpod/riverpod.dart';

import '../models/api/api.dart';
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
final apartmentsProvider = FutureProvider<List<Apartment>>((ref) {
  return ref.watch(apartmentRepositoryProvider).listApartments();
});

/// A single room's construction-progress state, by room id.
final roomStateProvider =
    FutureProvider.family<RoomState, String>((ref, roomId) {
  return ref.watch(roomStateRepositoryProvider).getState(roomId);
});

/// The authoritative delta (material/cost difference vs a finished room), by
/// room id. Drives the real "tejaldingiz" (you saved) figure.
final roomDeltaProvider =
    FutureProvider.family<DeltaResponse, String>((ref, roomId) {
  return ref.watch(roomStateRepositoryProvider).getDelta(roomId);
});
