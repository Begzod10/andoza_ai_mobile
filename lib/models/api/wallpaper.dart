import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallpaper.freezed.dart';
part 'wallpaper.g.dart';

/// An entry in the shared wallpaper library (`GET /api/v1/wallpapers`).
///
/// Mirrors `app/schemas/wallpaper.py::WallpaperOut`. [url] is always absolute
/// so it can be loaded straight into a texture regardless of API host.
@freezed
class Wallpaper with _$Wallpaper {
  const factory Wallpaper({
    required String id,
    required String name,
    required String url,
    @JsonKey(name: 'content_type') required String contentType,
    @JsonKey(name: 'size_bytes') required int sizeBytes,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _Wallpaper;

  factory Wallpaper.fromJson(Map<String, dynamic> json) =>
      _$WallpaperFromJson(json);
}
