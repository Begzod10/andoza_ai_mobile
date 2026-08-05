import 'package:riverpod/riverpod.dart';

import '../models/api/api.dart';
import '../repositories/catalog_repository.dart';
import 'auth_provider.dart';

/// Backend catalog repository (materials, furniture, stores, ustalar).
final catalogRepositoryProvider = Provider<CatalogRepository>((ref) {
  return CatalogRepository(ref.watch(apiClientProvider));
});

/// Active materials, optionally filtered by category (null = all).
///
/// Pulls up to 100 in one page — the seeded catalog is small and the material
/// rail wants the whole list at once.
final materialsProvider =
    FutureProvider.family<List<Material>, String?>((ref, category) async {
  final repo = ref.watch(catalogRepositoryProvider);
  final result = await repo.getMaterials(category: category, perPage: 100);
  return result.items;
});

/// Furniture / 3D-model catalog, optionally filtered by category (null = all).
final furnitureProvider =
    FutureProvider.family<List<Furniture>, String?>((ref, category) async {
  final repo = ref.watch(catalogRepositoryProvider);
  final result = await repo.getFurniture(category: category, perPage: 100);
  return result.items;
});

/// All active partner stores.
final storesProvider = FutureProvider<List<Store>>((ref) {
  return ref.watch(catalogRepositoryProvider).getStores();
});

/// Filter key for the ustalar directory. A record so the FutureProvider.family
/// gets structural equality for free (same category+district → same request).
typedef UstaFilter = ({String? category, String? district});

/// The craftsmen directory, optionally filtered by category/district.
final ustalarProvider =
    FutureProvider.family<List<Usta>, UstaFilter>((ref, filter) {
  return ref.watch(catalogRepositoryProvider).getUstalar(
        category: filter.category,
        district: filter.district,
      );
});
