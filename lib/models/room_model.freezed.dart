// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RoomDimensions {

 double get width; double get height; double get length;
/// Create a copy of RoomDimensions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoomDimensionsCopyWith<RoomDimensions> get copyWith => _$RoomDimensionsCopyWithImpl<RoomDimensions>(this as RoomDimensions, _$identity);

  /// Serializes this RoomDimensions to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RoomDimensions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoomDimensions&&(identical(other.width, _this.width) || other.width == _this.width)&&(identical(other.height, _this.height) || other.height == _this.height)&&(identical(other.length, _this.length) || other.length == _this.length));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RoomDimensions;
  return Object.hash(runtimeType,_this.width,_this.height,_this.length);
}

@override
String toString() {
  final _this = this as RoomDimensions;
  return 'RoomDimensions(width: ${_this.width}, height: ${_this.height}, length: ${_this.length})';
}


}

/// @nodoc
abstract mixin class $RoomDimensionsCopyWith<$Res>  {
  factory $RoomDimensionsCopyWith(RoomDimensions value, $Res Function(RoomDimensions) _then) = _$RoomDimensionsCopyWithImpl;
@useResult
$Res call({
 double width, double height, double length
});




}
/// @nodoc
class _$RoomDimensionsCopyWithImpl<$Res>
    implements $RoomDimensionsCopyWith<$Res> {
  _$RoomDimensionsCopyWithImpl(this._self, this._then);

  final RoomDimensions _self;
  final $Res Function(RoomDimensions) _then;

/// Create a copy of RoomDimensions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? width = null,Object? height = null,Object? length = null,}) {
  return _then(RoomDimensions(
width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,length: null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [RoomDimensions].
extension RoomDimensionsPatterns on RoomDimensions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoomDimensions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoomDimensions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoomDimensions value)  $default,){
final _that = this;
switch (_that) {
case _RoomDimensions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoomDimensions value)?  $default,){
final _that = this;
switch (_that) {
case _RoomDimensions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double width,  double height,  double length)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoomDimensions() when $default != null:
return $default(_that.width,_that.height,_that.length);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double width,  double height,  double length)  $default,) {final _that = this;
switch (_that) {
case _RoomDimensions():
return $default(_that.width,_that.height,_that.length);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double width,  double height,  double length)?  $default,) {final _that = this;
switch (_that) {
case _RoomDimensions() when $default != null:
return $default(_that.width,_that.height,_that.length);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RoomDimensions implements RoomDimensions {
  const _RoomDimensions({required this.width, required this.height, required this.length});
  factory _RoomDimensions.fromJson(Map<String, dynamic> json) => _$RoomDimensionsFromJson(json);

@override final  double width;
@override final  double height;
@override final  double length;

/// Create a copy of RoomDimensions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoomDimensionsCopyWith<_RoomDimensions> get copyWith => __$RoomDimensionsCopyWithImpl<_RoomDimensions>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoomDimensionsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoomDimensions&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.length, length) || other.length == length));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,width,height,length);
}

@override
String toString() {
    return 'RoomDimensions(width: $width, height: $height, length: $length)';
}


}

/// @nodoc
abstract mixin class _$RoomDimensionsCopyWith<$Res> implements $RoomDimensionsCopyWith<$Res> {
  factory _$RoomDimensionsCopyWith(_RoomDimensions value, $Res Function(_RoomDimensions) _then) = __$RoomDimensionsCopyWithImpl;
@override @useResult
$Res call({
 double width, double height, double length
});




}
/// @nodoc
class __$RoomDimensionsCopyWithImpl<$Res>
    implements _$RoomDimensionsCopyWith<$Res> {
  __$RoomDimensionsCopyWithImpl(this._self, this._then);

  final _RoomDimensions _self;
  final $Res Function(_RoomDimensions) _then;

/// Create a copy of RoomDimensions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? width = null,Object? height = null,Object? length = null,}) {
  return _then(_RoomDimensions(
width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,length: null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$WallMeasurements {

 double get height; double get length;
/// Create a copy of WallMeasurements
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WallMeasurementsCopyWith<WallMeasurements> get copyWith => _$WallMeasurementsCopyWithImpl<WallMeasurements>(this as WallMeasurements, _$identity);

  /// Serializes this WallMeasurements to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as WallMeasurements;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WallMeasurements&&(identical(other.height, _this.height) || other.height == _this.height)&&(identical(other.length, _this.length) || other.length == _this.length));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as WallMeasurements;
  return Object.hash(runtimeType,_this.height,_this.length);
}

@override
String toString() {
  final _this = this as WallMeasurements;
  return 'WallMeasurements(height: ${_this.height}, length: ${_this.length})';
}


}

/// @nodoc
abstract mixin class $WallMeasurementsCopyWith<$Res>  {
  factory $WallMeasurementsCopyWith(WallMeasurements value, $Res Function(WallMeasurements) _then) = _$WallMeasurementsCopyWithImpl;
@useResult
$Res call({
 double height, double length
});




}
/// @nodoc
class _$WallMeasurementsCopyWithImpl<$Res>
    implements $WallMeasurementsCopyWith<$Res> {
  _$WallMeasurementsCopyWithImpl(this._self, this._then);

  final WallMeasurements _self;
  final $Res Function(WallMeasurements) _then;

/// Create a copy of WallMeasurements
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? height = null,Object? length = null,}) {
  return _then(WallMeasurements(
height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,length: null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [WallMeasurements].
extension WallMeasurementsPatterns on WallMeasurements {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WallMeasurements value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WallMeasurements() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WallMeasurements value)  $default,){
final _that = this;
switch (_that) {
case _WallMeasurements():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WallMeasurements value)?  $default,){
final _that = this;
switch (_that) {
case _WallMeasurements() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double height,  double length)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WallMeasurements() when $default != null:
return $default(_that.height,_that.length);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double height,  double length)  $default,) {final _that = this;
switch (_that) {
case _WallMeasurements():
return $default(_that.height,_that.length);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double height,  double length)?  $default,) {final _that = this;
switch (_that) {
case _WallMeasurements() when $default != null:
return $default(_that.height,_that.length);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WallMeasurements implements WallMeasurements {
  const _WallMeasurements({required this.height, required this.length});
  factory _WallMeasurements.fromJson(Map<String, dynamic> json) => _$WallMeasurementsFromJson(json);

@override final  double height;
@override final  double length;

/// Create a copy of WallMeasurements
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WallMeasurementsCopyWith<_WallMeasurements> get copyWith => __$WallMeasurementsCopyWithImpl<_WallMeasurements>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WallMeasurementsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WallMeasurements&&(identical(other.height, height) || other.height == height)&&(identical(other.length, length) || other.length == length));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,height,length);
}

@override
String toString() {
    return 'WallMeasurements(height: $height, length: $length)';
}


}

/// @nodoc
abstract mixin class _$WallMeasurementsCopyWith<$Res> implements $WallMeasurementsCopyWith<$Res> {
  factory _$WallMeasurementsCopyWith(_WallMeasurements value, $Res Function(_WallMeasurements) _then) = __$WallMeasurementsCopyWithImpl;
@override @useResult
$Res call({
 double height, double length
});




}
/// @nodoc
class __$WallMeasurementsCopyWithImpl<$Res>
    implements _$WallMeasurementsCopyWith<$Res> {
  __$WallMeasurementsCopyWithImpl(this._self, this._then);

  final _WallMeasurements _self;
  final $Res Function(_WallMeasurements) _then;

/// Create a copy of WallMeasurements
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? height = null,Object? length = null,}) {
  return _then(_WallMeasurements(
height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,length: null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$Wall {

 String get id;@JsonKey(unknownEnumValue: WallType.unknown) WallType get type; WallMeasurements get measurements; String? get texture;
/// Create a copy of Wall
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WallCopyWith<Wall> get copyWith => _$WallCopyWithImpl<Wall>(this as Wall, _$identity);

  /// Serializes this Wall to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Wall;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Wall&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.measurements, _this.measurements) || other.measurements == _this.measurements)&&(identical(other.texture, _this.texture) || other.texture == _this.texture));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Wall;
  return Object.hash(runtimeType,_this.id,_this.type,_this.measurements,_this.texture);
}

@override
String toString() {
  final _this = this as Wall;
  return 'Wall(id: ${_this.id}, type: ${_this.type}, measurements: ${_this.measurements}, texture: ${_this.texture})';
}


}

/// @nodoc
abstract mixin class $WallCopyWith<$Res>  {
  factory $WallCopyWith(Wall value, $Res Function(Wall) _then) = _$WallCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(unknownEnumValue: WallType.unknown) WallType type, WallMeasurements measurements, String? texture
});


$WallMeasurementsCopyWith<$Res> get measurements;

}
/// @nodoc
class _$WallCopyWithImpl<$Res>
    implements $WallCopyWith<$Res> {
  _$WallCopyWithImpl(this._self, this._then);

  final Wall _self;
  final $Res Function(Wall) _then;

/// Create a copy of Wall
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? measurements = null,Object? texture = freezed,}) {
  return _then(Wall(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as WallType,measurements: null == measurements ? _self.measurements : measurements // ignore: cast_nullable_to_non_nullable
as WallMeasurements,texture: freezed == texture ? _self.texture : texture // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of Wall
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WallMeasurementsCopyWith<$Res> get measurements {
  
  return $WallMeasurementsCopyWith<$Res>(_self.measurements, (value) {
    return _then(_self.copyWith(measurements: value));
  });
}
}


/// Adds pattern-matching-related methods to [Wall].
extension WallPatterns on Wall {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Wall value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Wall() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Wall value)  $default,){
final _that = this;
switch (_that) {
case _Wall():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Wall value)?  $default,){
final _that = this;
switch (_that) {
case _Wall() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(unknownEnumValue: WallType.unknown)  WallType type,  WallMeasurements measurements,  String? texture)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Wall() when $default != null:
return $default(_that.id,_that.type,_that.measurements,_that.texture);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(unknownEnumValue: WallType.unknown)  WallType type,  WallMeasurements measurements,  String? texture)  $default,) {final _that = this;
switch (_that) {
case _Wall():
return $default(_that.id,_that.type,_that.measurements,_that.texture);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(unknownEnumValue: WallType.unknown)  WallType type,  WallMeasurements measurements,  String? texture)?  $default,) {final _that = this;
switch (_that) {
case _Wall() when $default != null:
return $default(_that.id,_that.type,_that.measurements,_that.texture);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Wall implements Wall {
  const _Wall({required this.id, @JsonKey(unknownEnumValue: WallType.unknown) required this.type, required this.measurements, this.texture});
  factory _Wall.fromJson(Map<String, dynamic> json) => _$WallFromJson(json);

@override final  String id;
@override@JsonKey(unknownEnumValue: WallType.unknown) final  WallType type;
@override final  WallMeasurements measurements;
@override final  String? texture;

/// Create a copy of Wall
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WallCopyWith<_Wall> get copyWith => __$WallCopyWithImpl<_Wall>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WallToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Wall&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.measurements, measurements) || other.measurements == measurements)&&(identical(other.texture, texture) || other.texture == texture));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,type,measurements,texture);
}

@override
String toString() {
    return 'Wall(id: $id, type: $type, measurements: $measurements, texture: $texture)';
}


}

/// @nodoc
abstract mixin class _$WallCopyWith<$Res> implements $WallCopyWith<$Res> {
  factory _$WallCopyWith(_Wall value, $Res Function(_Wall) _then) = __$WallCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(unknownEnumValue: WallType.unknown) WallType type, WallMeasurements measurements, String? texture
});


@override $WallMeasurementsCopyWith<$Res> get measurements;

}
/// @nodoc
class __$WallCopyWithImpl<$Res>
    implements _$WallCopyWith<$Res> {
  __$WallCopyWithImpl(this._self, this._then);

  final _Wall _self;
  final $Res Function(_Wall) _then;

/// Create a copy of Wall
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? measurements = null,Object? texture = freezed,}) {
  return _then(_Wall(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as WallType,measurements: null == measurements ? _self.measurements : measurements // ignore: cast_nullable_to_non_nullable
as WallMeasurements,texture: freezed == texture ? _self.texture : texture // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of Wall
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WallMeasurementsCopyWith<$Res> get measurements {
  
  return $WallMeasurementsCopyWith<$Res>(_self.measurements, (value) {
    return _then(_self.copyWith(measurements: value));
  });
}
}


/// @nodoc
mixin _$Door {

 String get id; String get wallId; double get position; double get width; double get height;@JsonKey(unknownEnumValue: OpeningType.unknown) OpeningType get type;
/// Create a copy of Door
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DoorCopyWith<Door> get copyWith => _$DoorCopyWithImpl<Door>(this as Door, _$identity);

  /// Serializes this Door to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Door;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Door&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.wallId, _this.wallId) || other.wallId == _this.wallId)&&(identical(other.position, _this.position) || other.position == _this.position)&&(identical(other.width, _this.width) || other.width == _this.width)&&(identical(other.height, _this.height) || other.height == _this.height)&&(identical(other.type, _this.type) || other.type == _this.type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Door;
  return Object.hash(runtimeType,_this.id,_this.wallId,_this.position,_this.width,_this.height,_this.type);
}

@override
String toString() {
  final _this = this as Door;
  return 'Door(id: ${_this.id}, wallId: ${_this.wallId}, position: ${_this.position}, width: ${_this.width}, height: ${_this.height}, type: ${_this.type})';
}


}

/// @nodoc
abstract mixin class $DoorCopyWith<$Res>  {
  factory $DoorCopyWith(Door value, $Res Function(Door) _then) = _$DoorCopyWithImpl;
@useResult
$Res call({
 String id, String wallId, double position, double width, double height,@JsonKey(unknownEnumValue: OpeningType.unknown) OpeningType type
});




}
/// @nodoc
class _$DoorCopyWithImpl<$Res>
    implements $DoorCopyWith<$Res> {
  _$DoorCopyWithImpl(this._self, this._then);

  final Door _self;
  final $Res Function(Door) _then;

/// Create a copy of Door
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? wallId = null,Object? position = null,Object? width = null,Object? height = null,Object? type = null,}) {
  return _then(Door(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,wallId: null == wallId ? _self.wallId : wallId // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as double,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as OpeningType,
  ));
}

}


/// Adds pattern-matching-related methods to [Door].
extension DoorPatterns on Door {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Door value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Door() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Door value)  $default,){
final _that = this;
switch (_that) {
case _Door():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Door value)?  $default,){
final _that = this;
switch (_that) {
case _Door() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String wallId,  double position,  double width,  double height, @JsonKey(unknownEnumValue: OpeningType.unknown)  OpeningType type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Door() when $default != null:
return $default(_that.id,_that.wallId,_that.position,_that.width,_that.height,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String wallId,  double position,  double width,  double height, @JsonKey(unknownEnumValue: OpeningType.unknown)  OpeningType type)  $default,) {final _that = this;
switch (_that) {
case _Door():
return $default(_that.id,_that.wallId,_that.position,_that.width,_that.height,_that.type);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String wallId,  double position,  double width,  double height, @JsonKey(unknownEnumValue: OpeningType.unknown)  OpeningType type)?  $default,) {final _that = this;
switch (_that) {
case _Door() when $default != null:
return $default(_that.id,_that.wallId,_that.position,_that.width,_that.height,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Door implements Door {
  const _Door({required this.id, required this.wallId, required this.position, required this.width, required this.height, @JsonKey(unknownEnumValue: OpeningType.unknown) required this.type});
  factory _Door.fromJson(Map<String, dynamic> json) => _$DoorFromJson(json);

@override final  String id;
@override final  String wallId;
@override final  double position;
@override final  double width;
@override final  double height;
@override@JsonKey(unknownEnumValue: OpeningType.unknown) final  OpeningType type;

/// Create a copy of Door
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DoorCopyWith<_Door> get copyWith => __$DoorCopyWithImpl<_Door>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DoorToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Door&&(identical(other.id, id) || other.id == id)&&(identical(other.wallId, wallId) || other.wallId == wallId)&&(identical(other.position, position) || other.position == position)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,wallId,position,width,height,type);
}

@override
String toString() {
    return 'Door(id: $id, wallId: $wallId, position: $position, width: $width, height: $height, type: $type)';
}


}

/// @nodoc
abstract mixin class _$DoorCopyWith<$Res> implements $DoorCopyWith<$Res> {
  factory _$DoorCopyWith(_Door value, $Res Function(_Door) _then) = __$DoorCopyWithImpl;
@override @useResult
$Res call({
 String id, String wallId, double position, double width, double height,@JsonKey(unknownEnumValue: OpeningType.unknown) OpeningType type
});




}
/// @nodoc
class __$DoorCopyWithImpl<$Res>
    implements _$DoorCopyWith<$Res> {
  __$DoorCopyWithImpl(this._self, this._then);

  final _Door _self;
  final $Res Function(_Door) _then;

/// Create a copy of Door
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? wallId = null,Object? position = null,Object? width = null,Object? height = null,Object? type = null,}) {
  return _then(_Door(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,wallId: null == wallId ? _self.wallId : wallId // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as double,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as OpeningType,
  ));
}


}


/// @nodoc
mixin _$Window {

 String get id; String get wallId; double get position; double get width; double get height;@JsonKey(unknownEnumValue: OpeningType.unknown) OpeningType get type;
/// Create a copy of Window
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WindowCopyWith<Window> get copyWith => _$WindowCopyWithImpl<Window>(this as Window, _$identity);

  /// Serializes this Window to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Window;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Window&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.wallId, _this.wallId) || other.wallId == _this.wallId)&&(identical(other.position, _this.position) || other.position == _this.position)&&(identical(other.width, _this.width) || other.width == _this.width)&&(identical(other.height, _this.height) || other.height == _this.height)&&(identical(other.type, _this.type) || other.type == _this.type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Window;
  return Object.hash(runtimeType,_this.id,_this.wallId,_this.position,_this.width,_this.height,_this.type);
}

@override
String toString() {
  final _this = this as Window;
  return 'Window(id: ${_this.id}, wallId: ${_this.wallId}, position: ${_this.position}, width: ${_this.width}, height: ${_this.height}, type: ${_this.type})';
}


}

/// @nodoc
abstract mixin class $WindowCopyWith<$Res>  {
  factory $WindowCopyWith(Window value, $Res Function(Window) _then) = _$WindowCopyWithImpl;
@useResult
$Res call({
 String id, String wallId, double position, double width, double height,@JsonKey(unknownEnumValue: OpeningType.unknown) OpeningType type
});




}
/// @nodoc
class _$WindowCopyWithImpl<$Res>
    implements $WindowCopyWith<$Res> {
  _$WindowCopyWithImpl(this._self, this._then);

  final Window _self;
  final $Res Function(Window) _then;

/// Create a copy of Window
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? wallId = null,Object? position = null,Object? width = null,Object? height = null,Object? type = null,}) {
  return _then(Window(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,wallId: null == wallId ? _self.wallId : wallId // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as double,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as OpeningType,
  ));
}

}


/// Adds pattern-matching-related methods to [Window].
extension WindowPatterns on Window {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Window value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Window() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Window value)  $default,){
final _that = this;
switch (_that) {
case _Window():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Window value)?  $default,){
final _that = this;
switch (_that) {
case _Window() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String wallId,  double position,  double width,  double height, @JsonKey(unknownEnumValue: OpeningType.unknown)  OpeningType type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Window() when $default != null:
return $default(_that.id,_that.wallId,_that.position,_that.width,_that.height,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String wallId,  double position,  double width,  double height, @JsonKey(unknownEnumValue: OpeningType.unknown)  OpeningType type)  $default,) {final _that = this;
switch (_that) {
case _Window():
return $default(_that.id,_that.wallId,_that.position,_that.width,_that.height,_that.type);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String wallId,  double position,  double width,  double height, @JsonKey(unknownEnumValue: OpeningType.unknown)  OpeningType type)?  $default,) {final _that = this;
switch (_that) {
case _Window() when $default != null:
return $default(_that.id,_that.wallId,_that.position,_that.width,_that.height,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Window implements Window {
  const _Window({required this.id, required this.wallId, required this.position, required this.width, required this.height, @JsonKey(unknownEnumValue: OpeningType.unknown) required this.type});
  factory _Window.fromJson(Map<String, dynamic> json) => _$WindowFromJson(json);

@override final  String id;
@override final  String wallId;
@override final  double position;
@override final  double width;
@override final  double height;
@override@JsonKey(unknownEnumValue: OpeningType.unknown) final  OpeningType type;

/// Create a copy of Window
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WindowCopyWith<_Window> get copyWith => __$WindowCopyWithImpl<_Window>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WindowToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Window&&(identical(other.id, id) || other.id == id)&&(identical(other.wallId, wallId) || other.wallId == wallId)&&(identical(other.position, position) || other.position == position)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,wallId,position,width,height,type);
}

@override
String toString() {
    return 'Window(id: $id, wallId: $wallId, position: $position, width: $width, height: $height, type: $type)';
}


}

/// @nodoc
abstract mixin class _$WindowCopyWith<$Res> implements $WindowCopyWith<$Res> {
  factory _$WindowCopyWith(_Window value, $Res Function(_Window) _then) = __$WindowCopyWithImpl;
@override @useResult
$Res call({
 String id, String wallId, double position, double width, double height,@JsonKey(unknownEnumValue: OpeningType.unknown) OpeningType type
});




}
/// @nodoc
class __$WindowCopyWithImpl<$Res>
    implements _$WindowCopyWith<$Res> {
  __$WindowCopyWithImpl(this._self, this._then);

  final _Window _self;
  final $Res Function(_Window) _then;

/// Create a copy of Window
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? wallId = null,Object? position = null,Object? width = null,Object? height = null,Object? type = null,}) {
  return _then(_Window(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,wallId: null == wallId ? _self.wallId : wallId // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as double,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as OpeningType,
  ));
}


}


/// @nodoc
mixin _$Room {

 String get id; String get name; RoomDimensions get dimensions; List<Wall> get walls; List<Door> get doors; List<Window> get windows; DateTime get createdAt;
/// Create a copy of Room
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoomCopyWith<Room> get copyWith => _$RoomCopyWithImpl<Room>(this as Room, _$identity);

  /// Serializes this Room to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Room;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Room&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.dimensions, _this.dimensions) || other.dimensions == _this.dimensions)&&const DeepCollectionEquality().equals(other.walls, _this.walls)&&const DeepCollectionEquality().equals(other.doors, _this.doors)&&const DeepCollectionEquality().equals(other.windows, _this.windows)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Room;
  return Object.hash(runtimeType,_this.id,_this.name,_this.dimensions,const DeepCollectionEquality().hash(_this.walls),const DeepCollectionEquality().hash(_this.doors),const DeepCollectionEquality().hash(_this.windows),_this.createdAt);
}

@override
String toString() {
  final _this = this as Room;
  return 'Room(id: ${_this.id}, name: ${_this.name}, dimensions: ${_this.dimensions}, walls: ${_this.walls}, doors: ${_this.doors}, windows: ${_this.windows}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $RoomCopyWith<$Res>  {
  factory $RoomCopyWith(Room value, $Res Function(Room) _then) = _$RoomCopyWithImpl;
@useResult
$Res call({
 String id, String name, RoomDimensions dimensions, List<Wall> walls, List<Door> doors, List<Window> windows, DateTime createdAt
});


$RoomDimensionsCopyWith<$Res> get dimensions;

}
/// @nodoc
class _$RoomCopyWithImpl<$Res>
    implements $RoomCopyWith<$Res> {
  _$RoomCopyWithImpl(this._self, this._then);

  final Room _self;
  final $Res Function(Room) _then;

/// Create a copy of Room
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? dimensions = null,Object? walls = null,Object? doors = null,Object? windows = null,Object? createdAt = null,}) {
  return _then(Room(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,dimensions: null == dimensions ? _self.dimensions : dimensions // ignore: cast_nullable_to_non_nullable
as RoomDimensions,walls: null == walls ? _self.walls : walls // ignore: cast_nullable_to_non_nullable
as List<Wall>,doors: null == doors ? _self.doors : doors // ignore: cast_nullable_to_non_nullable
as List<Door>,windows: null == windows ? _self.windows : windows // ignore: cast_nullable_to_non_nullable
as List<Window>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of Room
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoomDimensionsCopyWith<$Res> get dimensions {
  
  return $RoomDimensionsCopyWith<$Res>(_self.dimensions, (value) {
    return _then(_self.copyWith(dimensions: value));
  });
}
}


/// Adds pattern-matching-related methods to [Room].
extension RoomPatterns on Room {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Room value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Room() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Room value)  $default,){
final _that = this;
switch (_that) {
case _Room():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Room value)?  $default,){
final _that = this;
switch (_that) {
case _Room() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  RoomDimensions dimensions,  List<Wall> walls,  List<Door> doors,  List<Window> windows,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Room() when $default != null:
return $default(_that.id,_that.name,_that.dimensions,_that.walls,_that.doors,_that.windows,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  RoomDimensions dimensions,  List<Wall> walls,  List<Door> doors,  List<Window> windows,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _Room():
return $default(_that.id,_that.name,_that.dimensions,_that.walls,_that.doors,_that.windows,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  RoomDimensions dimensions,  List<Wall> walls,  List<Door> doors,  List<Window> windows,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Room() when $default != null:
return $default(_that.id,_that.name,_that.dimensions,_that.walls,_that.doors,_that.windows,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Room implements Room {
  const _Room({required this.id, required this.name, required this.dimensions,  List<Wall> walls = const <Wall>[],  List<Door> doors = const <Door>[],  List<Window> windows = const <Window>[], required this.createdAt}): _walls = walls,_doors = doors,_windows = windows;
  factory _Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);

@override final  String id;
@override final  String name;
@override final  RoomDimensions dimensions;
 final  List<Wall> _walls;
@override@JsonKey() List<Wall> get walls {
  if (_walls is EqualUnmodifiableListView) return _walls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_walls);
}

 final  List<Door> _doors;
@override@JsonKey() List<Door> get doors {
  if (_doors is EqualUnmodifiableListView) return _doors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_doors);
}

 final  List<Window> _windows;
@override@JsonKey() List<Window> get windows {
  if (_windows is EqualUnmodifiableListView) return _windows;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_windows);
}

@override final  DateTime createdAt;

/// Create a copy of Room
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoomCopyWith<_Room> get copyWith => __$RoomCopyWithImpl<_Room>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoomToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Room&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.dimensions, dimensions) || other.dimensions == dimensions)&&const DeepCollectionEquality().equals(other.walls, _walls)&&const DeepCollectionEquality().equals(other.doors, _doors)&&const DeepCollectionEquality().equals(other.windows, _windows)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,dimensions,const DeepCollectionEquality().hash(_walls),const DeepCollectionEquality().hash(_doors),const DeepCollectionEquality().hash(_windows),createdAt);
}

@override
String toString() {
    return 'Room(id: $id, name: $name, dimensions: $dimensions, walls: $walls, doors: $doors, windows: $windows, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$RoomCopyWith<$Res> implements $RoomCopyWith<$Res> {
  factory _$RoomCopyWith(_Room value, $Res Function(_Room) _then) = __$RoomCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, RoomDimensions dimensions, List<Wall> walls, List<Door> doors, List<Window> windows, DateTime createdAt
});


@override $RoomDimensionsCopyWith<$Res> get dimensions;

}
/// @nodoc
class __$RoomCopyWithImpl<$Res>
    implements _$RoomCopyWith<$Res> {
  __$RoomCopyWithImpl(this._self, this._then);

  final _Room _self;
  final $Res Function(_Room) _then;

/// Create a copy of Room
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? dimensions = null,Object? walls = null,Object? doors = null,Object? windows = null,Object? createdAt = null,}) {
  return _then(_Room(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,dimensions: null == dimensions ? _self.dimensions : dimensions // ignore: cast_nullable_to_non_nullable
as RoomDimensions,walls: null == walls ? _self._walls : walls // ignore: cast_nullable_to_non_nullable
as List<Wall>,doors: null == doors ? _self._doors : doors // ignore: cast_nullable_to_non_nullable
as List<Door>,windows: null == windows ? _self._windows : windows // ignore: cast_nullable_to_non_nullable
as List<Window>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of Room
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoomDimensionsCopyWith<$Res> get dimensions {
  
  return $RoomDimensionsCopyWith<$Res>(_self.dimensions, (value) {
    return _then(_self.copyWith(dimensions: value));
  });
}
}

// dart format on
