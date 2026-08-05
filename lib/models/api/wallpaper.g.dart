// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallpaper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WallpaperImpl _$$WallpaperImplFromJson(Map<String, dynamic> json) =>
    _$WallpaperImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      url: json['url'] as String,
      contentType: json['content_type'] as String,
      sizeBytes: (json['size_bytes'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$WallpaperImplToJson(_$WallpaperImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'content_type': instance.contentType,
      'size_bytes': instance.sizeBytes,
      'created_at': instance.createdAt.toIso8601String(),
    };
