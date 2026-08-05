import 'package:riverpod/riverpod.dart';

import '../models/api/api.dart';
import '../repositories/decoration_repository.dart';
import '../repositories/electrical_repository.dart';
import 'auth_provider.dart';

/// Decoration (walls/floor/ceiling/furniture) repository.
final decorationRepositoryProvider = Provider<DecorationRepository>((ref) {
  return DecorationRepository(ref.watch(apiClientProvider));
});

/// Electrical-plan repository.
final electricalRepositoryProvider = Provider<ElectricalRepository>((ref) {
  return ElectricalRepository(ref.watch(apiClientProvider));
});

/// A persisted room's decoration selections, by room id.
final decorationProvider =
    FutureProvider.family<Decoration, String>((ref, roomId) {
  return ref.watch(decorationRepositoryProvider).getDecoration(roomId);
});

/// A persisted room's electrical plan, by room id.
final electricalPlanProvider =
    FutureProvider.family<ElectricalPlan, String>((ref, roomId) {
  return ref.watch(electricalRepositoryProvider).getPlan(roomId);
});
