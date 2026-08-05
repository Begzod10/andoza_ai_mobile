import 'package:riverpod/riverpod.dart';

import '../models/api/api.dart';
import '../repositories/wallpaper_repository.dart';
import 'auth_provider.dart';

/// Shared wallpaper-library repository.
final wallpaperRepositoryProvider = Provider<WallpaperRepository>((ref) {
  return WallpaperRepository(ref.watch(apiClientProvider));
});

/// The shared wallpaper library (newest first). Invalidate after an upload to
/// refresh the grid.
final wallpapersProvider = FutureProvider<List<Wallpaper>>((ref) {
  return ref.watch(wallpaperRepositoryProvider).list();
});
