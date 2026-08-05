import '../models/api/api.dart';
import '../services/api_client.dart';

/// Access to the shared wallpaper library (`/wallpapers`). The list is public;
/// uploading requires auth. Paths are relative to the `/api/v1` base.
class WallpaperRepository {
  WallpaperRepository(this._client);

  final ApiClient _client;

  /// Every uploaded wallpaper, newest first (shared across all users).
  Future<List<Wallpaper>> list() {
    return _client.get<List<Wallpaper>>(
      '/wallpapers',
      fromJson: (json) => (json as List<dynamic>)
          .map((e) => Wallpaper.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Uploads an image to the shared library. The backend dedupes by SHA-256, so
  /// re-uploading the same bytes returns the existing entry. [contentType] is
  /// the image MIME type (e.g. `image/jpeg`).
  Future<Wallpaper> upload({
    required List<int> bytes,
    required String filename,
    required String contentType,
  }) {
    return _client.uploadFile<Wallpaper>(
      '/wallpapers',
      bytes: bytes,
      filename: filename,
      contentType: contentType,
      fromJson: (json) => Wallpaper.fromJson(json as Map<String, dynamic>),
    );
  }
}
