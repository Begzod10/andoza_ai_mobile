// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallpaper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Wallpaper _$WallpaperFromJson(Map<String, dynamic> json) {
  return _Wallpaper.fromJson(json);
}

/// @nodoc
mixin _$Wallpaper {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  @JsonKey(name: 'content_type')
  String get contentType => throw _privateConstructorUsedError;
  @JsonKey(name: 'size_bytes')
  int get sizeBytes => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Wallpaper to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Wallpaper
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WallpaperCopyWith<Wallpaper> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WallpaperCopyWith<$Res> {
  factory $WallpaperCopyWith(Wallpaper value, $Res Function(Wallpaper) then) =
      _$WallpaperCopyWithImpl<$Res, Wallpaper>;
  @useResult
  $Res call({
    String id,
    String name,
    String url,
    @JsonKey(name: 'content_type') String contentType,
    @JsonKey(name: 'size_bytes') int sizeBytes,
    @JsonKey(name: 'created_at') DateTime createdAt,
  });
}

/// @nodoc
class _$WallpaperCopyWithImpl<$Res, $Val extends Wallpaper>
    implements $WallpaperCopyWith<$Res> {
  _$WallpaperCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Wallpaper
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? url = null,
    Object? contentType = null,
    Object? sizeBytes = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            url: null == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String,
            contentType: null == contentType
                ? _value.contentType
                : contentType // ignore: cast_nullable_to_non_nullable
                      as String,
            sizeBytes: null == sizeBytes
                ? _value.sizeBytes
                : sizeBytes // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WallpaperImplCopyWith<$Res>
    implements $WallpaperCopyWith<$Res> {
  factory _$$WallpaperImplCopyWith(
    _$WallpaperImpl value,
    $Res Function(_$WallpaperImpl) then,
  ) = __$$WallpaperImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String url,
    @JsonKey(name: 'content_type') String contentType,
    @JsonKey(name: 'size_bytes') int sizeBytes,
    @JsonKey(name: 'created_at') DateTime createdAt,
  });
}

/// @nodoc
class __$$WallpaperImplCopyWithImpl<$Res>
    extends _$WallpaperCopyWithImpl<$Res, _$WallpaperImpl>
    implements _$$WallpaperImplCopyWith<$Res> {
  __$$WallpaperImplCopyWithImpl(
    _$WallpaperImpl _value,
    $Res Function(_$WallpaperImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Wallpaper
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? url = null,
    Object? contentType = null,
    Object? sizeBytes = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$WallpaperImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        url: null == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String,
        contentType: null == contentType
            ? _value.contentType
            : contentType // ignore: cast_nullable_to_non_nullable
                  as String,
        sizeBytes: null == sizeBytes
            ? _value.sizeBytes
            : sizeBytes // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WallpaperImpl implements _Wallpaper {
  const _$WallpaperImpl({
    required this.id,
    required this.name,
    required this.url,
    @JsonKey(name: 'content_type') required this.contentType,
    @JsonKey(name: 'size_bytes') required this.sizeBytes,
    @JsonKey(name: 'created_at') required this.createdAt,
  });

  factory _$WallpaperImpl.fromJson(Map<String, dynamic> json) =>
      _$$WallpaperImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String url;
  @override
  @JsonKey(name: 'content_type')
  final String contentType;
  @override
  @JsonKey(name: 'size_bytes')
  final int sizeBytes;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString() {
    return 'Wallpaper(id: $id, name: $name, url: $url, contentType: $contentType, sizeBytes: $sizeBytes, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WallpaperImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.contentType, contentType) ||
                other.contentType == contentType) &&
            (identical(other.sizeBytes, sizeBytes) ||
                other.sizeBytes == sizeBytes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    url,
    contentType,
    sizeBytes,
    createdAt,
  );

  /// Create a copy of Wallpaper
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WallpaperImplCopyWith<_$WallpaperImpl> get copyWith =>
      __$$WallpaperImplCopyWithImpl<_$WallpaperImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WallpaperImplToJson(this);
  }
}

abstract class _Wallpaper implements Wallpaper {
  const factory _Wallpaper({
    required final String id,
    required final String name,
    required final String url,
    @JsonKey(name: 'content_type') required final String contentType,
    @JsonKey(name: 'size_bytes') required final int sizeBytes,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
  }) = _$WallpaperImpl;

  factory _Wallpaper.fromJson(Map<String, dynamic> json) =
      _$WallpaperImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get url;
  @override
  @JsonKey(name: 'content_type')
  String get contentType;
  @override
  @JsonKey(name: 'size_bytes')
  int get sizeBytes;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;

  /// Create a copy of Wallpaper
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WallpaperImplCopyWith<_$WallpaperImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
