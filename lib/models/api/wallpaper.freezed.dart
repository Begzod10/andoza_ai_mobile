// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallpaper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Wallpaper {

 String get id; String get name; String get url;@JsonKey(name: 'content_type') String get contentType;@JsonKey(name: 'size_bytes') int get sizeBytes;@JsonKey(name: 'created_at') DateTime get createdAt;
/// Create a copy of Wallpaper
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WallpaperCopyWith<Wallpaper> get copyWith => _$WallpaperCopyWithImpl<Wallpaper>(this as Wallpaper, _$identity);

  /// Serializes this Wallpaper to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Wallpaper;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Wallpaper&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.url, _this.url) || other.url == _this.url)&&(identical(other.contentType, _this.contentType) || other.contentType == _this.contentType)&&(identical(other.sizeBytes, _this.sizeBytes) || other.sizeBytes == _this.sizeBytes)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Wallpaper;
  return Object.hash(runtimeType,_this.id,_this.name,_this.url,_this.contentType,_this.sizeBytes,_this.createdAt);
}

@override
String toString() {
  final _this = this as Wallpaper;
  return 'Wallpaper(id: ${_this.id}, name: ${_this.name}, url: ${_this.url}, contentType: ${_this.contentType}, sizeBytes: ${_this.sizeBytes}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $WallpaperCopyWith<$Res>  {
  factory $WallpaperCopyWith(Wallpaper value, $Res Function(Wallpaper) _then) = _$WallpaperCopyWithImpl;
@useResult
$Res call({
 String id, String name, String url,@JsonKey(name: 'content_type') String contentType,@JsonKey(name: 'size_bytes') int sizeBytes,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class _$WallpaperCopyWithImpl<$Res>
    implements $WallpaperCopyWith<$Res> {
  _$WallpaperCopyWithImpl(this._self, this._then);

  final Wallpaper _self;
  final $Res Function(Wallpaper) _then;

/// Create a copy of Wallpaper
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? url = null,Object? contentType = null,Object? sizeBytes = null,Object? createdAt = null,}) {
  return _then(Wallpaper(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,contentType: null == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as String,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Wallpaper].
extension WallpaperPatterns on Wallpaper {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Wallpaper value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Wallpaper() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Wallpaper value)  $default,){
final _that = this;
switch (_that) {
case _Wallpaper():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Wallpaper value)?  $default,){
final _that = this;
switch (_that) {
case _Wallpaper() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String url, @JsonKey(name: 'content_type')  String contentType, @JsonKey(name: 'size_bytes')  int sizeBytes, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Wallpaper() when $default != null:
return $default(_that.id,_that.name,_that.url,_that.contentType,_that.sizeBytes,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String url, @JsonKey(name: 'content_type')  String contentType, @JsonKey(name: 'size_bytes')  int sizeBytes, @JsonKey(name: 'created_at')  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _Wallpaper():
return $default(_that.id,_that.name,_that.url,_that.contentType,_that.sizeBytes,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String url, @JsonKey(name: 'content_type')  String contentType, @JsonKey(name: 'size_bytes')  int sizeBytes, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Wallpaper() when $default != null:
return $default(_that.id,_that.name,_that.url,_that.contentType,_that.sizeBytes,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Wallpaper implements Wallpaper {
  const _Wallpaper({required this.id, required this.name, required this.url, @JsonKey(name: 'content_type') required this.contentType, @JsonKey(name: 'size_bytes') required this.sizeBytes, @JsonKey(name: 'created_at') required this.createdAt});
  factory _Wallpaper.fromJson(Map<String, dynamic> json) => _$WallpaperFromJson(json);

@override final  String id;
@override final  String name;
@override final  String url;
@override@JsonKey(name: 'content_type') final  String contentType;
@override@JsonKey(name: 'size_bytes') final  int sizeBytes;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;

/// Create a copy of Wallpaper
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WallpaperCopyWith<_Wallpaper> get copyWith => __$WallpaperCopyWithImpl<_Wallpaper>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WallpaperToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Wallpaper&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.url, url) || other.url == url)&&(identical(other.contentType, contentType) || other.contentType == contentType)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,url,contentType,sizeBytes,createdAt);
}

@override
String toString() {
    return 'Wallpaper(id: $id, name: $name, url: $url, contentType: $contentType, sizeBytes: $sizeBytes, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$WallpaperCopyWith<$Res> implements $WallpaperCopyWith<$Res> {
  factory _$WallpaperCopyWith(_Wallpaper value, $Res Function(_Wallpaper) _then) = __$WallpaperCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String url,@JsonKey(name: 'content_type') String contentType,@JsonKey(name: 'size_bytes') int sizeBytes,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class __$WallpaperCopyWithImpl<$Res>
    implements _$WallpaperCopyWith<$Res> {
  __$WallpaperCopyWithImpl(this._self, this._then);

  final _Wallpaper _self;
  final $Res Function(_Wallpaper) _then;

/// Create a copy of Wallpaper
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? url = null,Object? contentType = null,Object? sizeBytes = null,Object? createdAt = null,}) {
  return _then(_Wallpaper(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,contentType: null == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as String,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
