import 'package:riverpod/riverpod.dart';

import '../models/api/api.dart';
import '../repositories/estimate_repository.dart';
import 'auth_provider.dart';

/// Backend smeta (estimate) repository.
final estimateRepositoryProvider = Provider<EstimateRepository>((ref) {
  return EstimateRepository(ref.watch(apiClientProvider));
});

/// A live server-computed smeta preview for a persisted room, by room id.
///
/// This is the authoritative estimate. Screens fall back to the client-side
/// `estimateProvider` when no room is persisted yet or the backend is
/// unreachable.
final estimatePreviewProvider =
    FutureProvider.family<Estimate, String>((ref, roomId) {
  return ref.watch(estimateRepositoryProvider).preview(roomId);
});

/// Paginated smeta history for a persisted room.
final estimateHistoryProvider =
    FutureProvider.family<PaginatedEstimates, String>((ref, roomId) {
  return ref.watch(estimateRepositoryProvider).history(roomId);
});
