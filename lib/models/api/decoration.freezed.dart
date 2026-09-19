// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'decoration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WallsDecoration {

@JsonKey(name: 'material_id') String? get materialId; String get finish; String? get color;
/// Create a copy of WallsDecoration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WallsDecorationCopyWith<WallsDecoration> get copyWith => _$WallsDecorationCopyWithImpl<WallsDecoration>(this as WallsDecoration, _$identity);

  /// Serializes this WallsDecoration to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as WallsDecoration;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WallsDecoration&&(identical(other.materialId, _this.materialId) || other.materialId == _this.materialId)&&(identical(other.finish, _this.finish) || other.finish == _this.finish)&&(identical(other.color, _this.color) || other.color == _this.color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as WallsDecoration;
  return Object.hash(runtimeType,_this.materialId,_this.finish,_this.color);
}

@override
String toString() {
  final _this = this as WallsDecoration;
  return 'WallsDecoration(materialId: ${_this.materialId}, finish: ${_this.finish}, color: ${_this.color})';
}


}

/// @nodoc
abstract mixin class $WallsDecorationCopyWith<$Res>  {
  factory $WallsDecorationCopyWith(WallsDecoration value, $Res Function(WallsDecoration) _then) = _$WallsDecorationCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'material_id') String? materialId, String finish, String? color
});




}
/// @nodoc
class _$WallsDecorationCopyWithImpl<$Res>
    implements $WallsDecorationCopyWith<$Res> {
  _$WallsDecorationCopyWithImpl(this._self, this._then);

  final WallsDecoration _self;
  final $Res Function(WallsDecoration) _then;

/// Create a copy of WallsDecoration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? materialId = freezed,Object? finish = null,Object? color = freezed,}) {
  return _then(WallsDecoration(
materialId: freezed == materialId ? _self.materialId : materialId // ignore: cast_nullable_to_non_nullable
as String?,finish: null == finish ? _self.finish : finish // ignore: cast_nullable_to_non_nullable
as String,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [WallsDecoration].
extension WallsDecorationPatterns on WallsDecoration {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WallsDecoration value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WallsDecoration() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WallsDecoration value)  $default,){
final _that = this;
switch (_that) {
case _WallsDecoration():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WallsDecoration value)?  $default,){
final _that = this;
switch (_that) {
case _WallsDecoration() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'material_id')  String? materialId,  String finish,  String? color)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WallsDecoration() when $default != null:
return $default(_that.materialId,_that.finish,_that.color);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'material_id')  String? materialId,  String finish,  String? color)  $default,) {final _that = this;
switch (_that) {
case _WallsDecoration():
return $default(_that.materialId,_that.finish,_that.color);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'material_id')  String? materialId,  String finish,  String? color)?  $default,) {final _that = this;
switch (_that) {
case _WallsDecoration() when $default != null:
return $default(_that.materialId,_that.finish,_that.color);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WallsDecoration implements WallsDecoration {
  const _WallsDecoration({@JsonKey(name: 'material_id') this.materialId, this.finish = 'paint', this.color});
  factory _WallsDecoration.fromJson(Map<String, dynamic> json) => _$WallsDecorationFromJson(json);

@override@JsonKey(name: 'material_id') final  String? materialId;
@override@JsonKey() final  String finish;
@override final  String? color;

/// Create a copy of WallsDecoration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WallsDecorationCopyWith<_WallsDecoration> get copyWith => __$WallsDecorationCopyWithImpl<_WallsDecoration>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WallsDecorationToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WallsDecoration&&(identical(other.materialId, materialId) || other.materialId == materialId)&&(identical(other.finish, finish) || other.finish == finish)&&(identical(other.color, color) || other.color == color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,materialId,finish,color);
}

@override
String toString() {
    return 'WallsDecoration(materialId: $materialId, finish: $finish, color: $color)';
}


}

/// @nodoc
abstract mixin class _$WallsDecorationCopyWith<$Res> implements $WallsDecorationCopyWith<$Res> {
  factory _$WallsDecorationCopyWith(_WallsDecoration value, $Res Function(_WallsDecoration) _then) = __$WallsDecorationCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'material_id') String? materialId, String finish, String? color
});




}
/// @nodoc
class __$WallsDecorationCopyWithImpl<$Res>
    implements _$WallsDecorationCopyWith<$Res> {
  __$WallsDecorationCopyWithImpl(this._self, this._then);

  final _WallsDecoration _self;
  final $Res Function(_WallsDecoration) _then;

/// Create a copy of WallsDecoration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? materialId = freezed,Object? finish = null,Object? color = freezed,}) {
  return _then(_WallsDecoration(
materialId: freezed == materialId ? _self.materialId : materialId // ignore: cast_nullable_to_non_nullable
as String?,finish: null == finish ? _self.finish : finish // ignore: cast_nullable_to_non_nullable
as String,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$FloorDecoration {

@JsonKey(name: 'material_id') String? get materialId;
/// Create a copy of FloorDecoration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FloorDecorationCopyWith<FloorDecoration> get copyWith => _$FloorDecorationCopyWithImpl<FloorDecoration>(this as FloorDecoration, _$identity);

  /// Serializes this FloorDecoration to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FloorDecoration;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FloorDecoration&&(identical(other.materialId, _this.materialId) || other.materialId == _this.materialId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FloorDecoration;
  return Object.hash(runtimeType,_this.materialId);
}

@override
String toString() {
  final _this = this as FloorDecoration;
  return 'FloorDecoration(materialId: ${_this.materialId})';
}


}

/// @nodoc
abstract mixin class $FloorDecorationCopyWith<$Res>  {
  factory $FloorDecorationCopyWith(FloorDecoration value, $Res Function(FloorDecoration) _then) = _$FloorDecorationCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'material_id') String? materialId
});




}
/// @nodoc
class _$FloorDecorationCopyWithImpl<$Res>
    implements $FloorDecorationCopyWith<$Res> {
  _$FloorDecorationCopyWithImpl(this._self, this._then);

  final FloorDecoration _self;
  final $Res Function(FloorDecoration) _then;

/// Create a copy of FloorDecoration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? materialId = freezed,}) {
  return _then(FloorDecoration(
materialId: freezed == materialId ? _self.materialId : materialId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FloorDecoration].
extension FloorDecorationPatterns on FloorDecoration {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FloorDecoration value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FloorDecoration() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FloorDecoration value)  $default,){
final _that = this;
switch (_that) {
case _FloorDecoration():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FloorDecoration value)?  $default,){
final _that = this;
switch (_that) {
case _FloorDecoration() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'material_id')  String? materialId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FloorDecoration() when $default != null:
return $default(_that.materialId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'material_id')  String? materialId)  $default,) {final _that = this;
switch (_that) {
case _FloorDecoration():
return $default(_that.materialId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'material_id')  String? materialId)?  $default,) {final _that = this;
switch (_that) {
case _FloorDecoration() when $default != null:
return $default(_that.materialId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FloorDecoration implements FloorDecoration {
  const _FloorDecoration({@JsonKey(name: 'material_id') this.materialId});
  factory _FloorDecoration.fromJson(Map<String, dynamic> json) => _$FloorDecorationFromJson(json);

@override@JsonKey(name: 'material_id') final  String? materialId;

/// Create a copy of FloorDecoration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FloorDecorationCopyWith<_FloorDecoration> get copyWith => __$FloorDecorationCopyWithImpl<_FloorDecoration>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FloorDecorationToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FloorDecoration&&(identical(other.materialId, materialId) || other.materialId == materialId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,materialId);
}

@override
String toString() {
    return 'FloorDecoration(materialId: $materialId)';
}


}

/// @nodoc
abstract mixin class _$FloorDecorationCopyWith<$Res> implements $FloorDecorationCopyWith<$Res> {
  factory _$FloorDecorationCopyWith(_FloorDecoration value, $Res Function(_FloorDecoration) _then) = __$FloorDecorationCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'material_id') String? materialId
});




}
/// @nodoc
class __$FloorDecorationCopyWithImpl<$Res>
    implements _$FloorDecorationCopyWith<$Res> {
  __$FloorDecorationCopyWithImpl(this._self, this._then);

  final _FloorDecoration _self;
  final $Res Function(_FloorDecoration) _then;

/// Create a copy of FloorDecoration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? materialId = freezed,}) {
  return _then(_FloorDecoration(
materialId: freezed == materialId ? _self.materialId : materialId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CeilingDecoration {

@JsonKey(name: 'material_id') String? get materialId;
/// Create a copy of CeilingDecoration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CeilingDecorationCopyWith<CeilingDecoration> get copyWith => _$CeilingDecorationCopyWithImpl<CeilingDecoration>(this as CeilingDecoration, _$identity);

  /// Serializes this CeilingDecoration to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CeilingDecoration;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CeilingDecoration&&(identical(other.materialId, _this.materialId) || other.materialId == _this.materialId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CeilingDecoration;
  return Object.hash(runtimeType,_this.materialId);
}

@override
String toString() {
  final _this = this as CeilingDecoration;
  return 'CeilingDecoration(materialId: ${_this.materialId})';
}


}

/// @nodoc
abstract mixin class $CeilingDecorationCopyWith<$Res>  {
  factory $CeilingDecorationCopyWith(CeilingDecoration value, $Res Function(CeilingDecoration) _then) = _$CeilingDecorationCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'material_id') String? materialId
});




}
/// @nodoc
class _$CeilingDecorationCopyWithImpl<$Res>
    implements $CeilingDecorationCopyWith<$Res> {
  _$CeilingDecorationCopyWithImpl(this._self, this._then);

  final CeilingDecoration _self;
  final $Res Function(CeilingDecoration) _then;

/// Create a copy of CeilingDecoration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? materialId = freezed,}) {
  return _then(CeilingDecoration(
materialId: freezed == materialId ? _self.materialId : materialId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CeilingDecoration].
extension CeilingDecorationPatterns on CeilingDecoration {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CeilingDecoration value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CeilingDecoration() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CeilingDecoration value)  $default,){
final _that = this;
switch (_that) {
case _CeilingDecoration():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CeilingDecoration value)?  $default,){
final _that = this;
switch (_that) {
case _CeilingDecoration() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'material_id')  String? materialId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CeilingDecoration() when $default != null:
return $default(_that.materialId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'material_id')  String? materialId)  $default,) {final _that = this;
switch (_that) {
case _CeilingDecoration():
return $default(_that.materialId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'material_id')  String? materialId)?  $default,) {final _that = this;
switch (_that) {
case _CeilingDecoration() when $default != null:
return $default(_that.materialId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CeilingDecoration implements CeilingDecoration {
  const _CeilingDecoration({@JsonKey(name: 'material_id') this.materialId});
  factory _CeilingDecoration.fromJson(Map<String, dynamic> json) => _$CeilingDecorationFromJson(json);

@override@JsonKey(name: 'material_id') final  String? materialId;

/// Create a copy of CeilingDecoration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CeilingDecorationCopyWith<_CeilingDecoration> get copyWith => __$CeilingDecorationCopyWithImpl<_CeilingDecoration>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CeilingDecorationToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CeilingDecoration&&(identical(other.materialId, materialId) || other.materialId == materialId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,materialId);
}

@override
String toString() {
    return 'CeilingDecoration(materialId: $materialId)';
}


}

/// @nodoc
abstract mixin class _$CeilingDecorationCopyWith<$Res> implements $CeilingDecorationCopyWith<$Res> {
  factory _$CeilingDecorationCopyWith(_CeilingDecoration value, $Res Function(_CeilingDecoration) _then) = __$CeilingDecorationCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'material_id') String? materialId
});




}
/// @nodoc
class __$CeilingDecorationCopyWithImpl<$Res>
    implements _$CeilingDecorationCopyWith<$Res> {
  __$CeilingDecorationCopyWithImpl(this._self, this._then);

  final _CeilingDecoration _self;
  final $Res Function(_CeilingDecoration) _then;

/// Create a copy of CeilingDecoration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? materialId = freezed,}) {
  return _then(_CeilingDecoration(
materialId: freezed == materialId ? _self.materialId : materialId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$DecorationFurniture {

@JsonKey(name: 'furniture_id') String get furnitureId; double get x; double get y; double get rotation;
/// Create a copy of DecorationFurniture
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DecorationFurnitureCopyWith<DecorationFurniture> get copyWith => _$DecorationFurnitureCopyWithImpl<DecorationFurniture>(this as DecorationFurniture, _$identity);

  /// Serializes this DecorationFurniture to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DecorationFurniture;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DecorationFurniture&&(identical(other.furnitureId, _this.furnitureId) || other.furnitureId == _this.furnitureId)&&(identical(other.x, _this.x) || other.x == _this.x)&&(identical(other.y, _this.y) || other.y == _this.y)&&(identical(other.rotation, _this.rotation) || other.rotation == _this.rotation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DecorationFurniture;
  return Object.hash(runtimeType,_this.furnitureId,_this.x,_this.y,_this.rotation);
}

@override
String toString() {
  final _this = this as DecorationFurniture;
  return 'DecorationFurniture(furnitureId: ${_this.furnitureId}, x: ${_this.x}, y: ${_this.y}, rotation: ${_this.rotation})';
}


}

/// @nodoc
abstract mixin class $DecorationFurnitureCopyWith<$Res>  {
  factory $DecorationFurnitureCopyWith(DecorationFurniture value, $Res Function(DecorationFurniture) _then) = _$DecorationFurnitureCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'furniture_id') String furnitureId, double x, double y, double rotation
});




}
/// @nodoc
class _$DecorationFurnitureCopyWithImpl<$Res>
    implements $DecorationFurnitureCopyWith<$Res> {
  _$DecorationFurnitureCopyWithImpl(this._self, this._then);

  final DecorationFurniture _self;
  final $Res Function(DecorationFurniture) _then;

/// Create a copy of DecorationFurniture
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? furnitureId = null,Object? x = null,Object? y = null,Object? rotation = null,}) {
  return _then(DecorationFurniture(
furnitureId: null == furnitureId ? _self.furnitureId : furnitureId // ignore: cast_nullable_to_non_nullable
as String,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,rotation: null == rotation ? _self.rotation : rotation // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [DecorationFurniture].
extension DecorationFurniturePatterns on DecorationFurniture {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DecorationFurniture value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DecorationFurniture() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DecorationFurniture value)  $default,){
final _that = this;
switch (_that) {
case _DecorationFurniture():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DecorationFurniture value)?  $default,){
final _that = this;
switch (_that) {
case _DecorationFurniture() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'furniture_id')  String furnitureId,  double x,  double y,  double rotation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DecorationFurniture() when $default != null:
return $default(_that.furnitureId,_that.x,_that.y,_that.rotation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'furniture_id')  String furnitureId,  double x,  double y,  double rotation)  $default,) {final _that = this;
switch (_that) {
case _DecorationFurniture():
return $default(_that.furnitureId,_that.x,_that.y,_that.rotation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'furniture_id')  String furnitureId,  double x,  double y,  double rotation)?  $default,) {final _that = this;
switch (_that) {
case _DecorationFurniture() when $default != null:
return $default(_that.furnitureId,_that.x,_that.y,_that.rotation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DecorationFurniture implements DecorationFurniture {
  const _DecorationFurniture({@JsonKey(name: 'furniture_id') required this.furnitureId, required this.x, required this.y, this.rotation = 0.0});
  factory _DecorationFurniture.fromJson(Map<String, dynamic> json) => _$DecorationFurnitureFromJson(json);

@override@JsonKey(name: 'furniture_id') final  String furnitureId;
@override final  double x;
@override final  double y;
@override@JsonKey() final  double rotation;

/// Create a copy of DecorationFurniture
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DecorationFurnitureCopyWith<_DecorationFurniture> get copyWith => __$DecorationFurnitureCopyWithImpl<_DecorationFurniture>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DecorationFurnitureToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DecorationFurniture&&(identical(other.furnitureId, furnitureId) || other.furnitureId == furnitureId)&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.rotation, rotation) || other.rotation == rotation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,furnitureId,x,y,rotation);
}

@override
String toString() {
    return 'DecorationFurniture(furnitureId: $furnitureId, x: $x, y: $y, rotation: $rotation)';
}


}

/// @nodoc
abstract mixin class _$DecorationFurnitureCopyWith<$Res> implements $DecorationFurnitureCopyWith<$Res> {
  factory _$DecorationFurnitureCopyWith(_DecorationFurniture value, $Res Function(_DecorationFurniture) _then) = __$DecorationFurnitureCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'furniture_id') String furnitureId, double x, double y, double rotation
});




}
/// @nodoc
class __$DecorationFurnitureCopyWithImpl<$Res>
    implements _$DecorationFurnitureCopyWith<$Res> {
  __$DecorationFurnitureCopyWithImpl(this._self, this._then);

  final _DecorationFurniture _self;
  final $Res Function(_DecorationFurniture) _then;

/// Create a copy of DecorationFurniture
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? furnitureId = null,Object? x = null,Object? y = null,Object? rotation = null,}) {
  return _then(_DecorationFurniture(
furnitureId: null == furnitureId ? _self.furnitureId : furnitureId // ignore: cast_nullable_to_non_nullable
as String,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,rotation: null == rotation ? _self.rotation : rotation // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$Decoration {

@JsonKey(name: 'room_id') String get roomId; WallsDecoration get walls; FloorDecoration get floor; CeilingDecoration get ceiling; List<DecorationFurniture> get furniture;@JsonKey(name: 'updated_at') DateTime get updatedAt;
/// Create a copy of Decoration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DecorationCopyWith<Decoration> get copyWith => _$DecorationCopyWithImpl<Decoration>(this as Decoration, _$identity);

  /// Serializes this Decoration to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Decoration;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Decoration&&(identical(other.roomId, _this.roomId) || other.roomId == _this.roomId)&&(identical(other.walls, _this.walls) || other.walls == _this.walls)&&(identical(other.floor, _this.floor) || other.floor == _this.floor)&&(identical(other.ceiling, _this.ceiling) || other.ceiling == _this.ceiling)&&const DeepCollectionEquality().equals(other.furniture, _this.furniture)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Decoration;
  return Object.hash(runtimeType,_this.roomId,_this.walls,_this.floor,_this.ceiling,const DeepCollectionEquality().hash(_this.furniture),_this.updatedAt);
}

@override
String toString() {
  final _this = this as Decoration;
  return 'Decoration(roomId: ${_this.roomId}, walls: ${_this.walls}, floor: ${_this.floor}, ceiling: ${_this.ceiling}, furniture: ${_this.furniture}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $DecorationCopyWith<$Res>  {
  factory $DecorationCopyWith(Decoration value, $Res Function(Decoration) _then) = _$DecorationCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'room_id') String roomId, WallsDecoration walls, FloorDecoration floor, CeilingDecoration ceiling, List<DecorationFurniture> furniture,@JsonKey(name: 'updated_at') DateTime updatedAt
});


$WallsDecorationCopyWith<$Res> get walls;$FloorDecorationCopyWith<$Res> get floor;$CeilingDecorationCopyWith<$Res> get ceiling;

}
/// @nodoc
class _$DecorationCopyWithImpl<$Res>
    implements $DecorationCopyWith<$Res> {
  _$DecorationCopyWithImpl(this._self, this._then);

  final Decoration _self;
  final $Res Function(Decoration) _then;

/// Create a copy of Decoration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? roomId = null,Object? walls = null,Object? floor = null,Object? ceiling = null,Object? furniture = null,Object? updatedAt = null,}) {
  return _then(Decoration(
roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,walls: null == walls ? _self.walls : walls // ignore: cast_nullable_to_non_nullable
as WallsDecoration,floor: null == floor ? _self.floor : floor // ignore: cast_nullable_to_non_nullable
as FloorDecoration,ceiling: null == ceiling ? _self.ceiling : ceiling // ignore: cast_nullable_to_non_nullable
as CeilingDecoration,furniture: null == furniture ? _self.furniture : furniture // ignore: cast_nullable_to_non_nullable
as List<DecorationFurniture>,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of Decoration
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WallsDecorationCopyWith<$Res> get walls {
  
  return $WallsDecorationCopyWith<$Res>(_self.walls, (value) {
    return _then(_self.copyWith(walls: value));
  });
}/// Create a copy of Decoration
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FloorDecorationCopyWith<$Res> get floor {
  
  return $FloorDecorationCopyWith<$Res>(_self.floor, (value) {
    return _then(_self.copyWith(floor: value));
  });
}/// Create a copy of Decoration
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CeilingDecorationCopyWith<$Res> get ceiling {
  
  return $CeilingDecorationCopyWith<$Res>(_self.ceiling, (value) {
    return _then(_self.copyWith(ceiling: value));
  });
}
}


/// Adds pattern-matching-related methods to [Decoration].
extension DecorationPatterns on Decoration {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Decoration value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Decoration() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Decoration value)  $default,){
final _that = this;
switch (_that) {
case _Decoration():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Decoration value)?  $default,){
final _that = this;
switch (_that) {
case _Decoration() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'room_id')  String roomId,  WallsDecoration walls,  FloorDecoration floor,  CeilingDecoration ceiling,  List<DecorationFurniture> furniture, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Decoration() when $default != null:
return $default(_that.roomId,_that.walls,_that.floor,_that.ceiling,_that.furniture,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'room_id')  String roomId,  WallsDecoration walls,  FloorDecoration floor,  CeilingDecoration ceiling,  List<DecorationFurniture> furniture, @JsonKey(name: 'updated_at')  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Decoration():
return $default(_that.roomId,_that.walls,_that.floor,_that.ceiling,_that.furniture,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'room_id')  String roomId,  WallsDecoration walls,  FloorDecoration floor,  CeilingDecoration ceiling,  List<DecorationFurniture> furniture, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Decoration() when $default != null:
return $default(_that.roomId,_that.walls,_that.floor,_that.ceiling,_that.furniture,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Decoration implements Decoration {
  const _Decoration({@JsonKey(name: 'room_id') required this.roomId, this.walls = const WallsDecoration(), this.floor = const FloorDecoration(), this.ceiling = const CeilingDecoration(),  List<DecorationFurniture> furniture = const <DecorationFurniture>[], @JsonKey(name: 'updated_at') required this.updatedAt}): _furniture = furniture;
  factory _Decoration.fromJson(Map<String, dynamic> json) => _$DecorationFromJson(json);

@override@JsonKey(name: 'room_id') final  String roomId;
@override@JsonKey() final  WallsDecoration walls;
@override@JsonKey() final  FloorDecoration floor;
@override@JsonKey() final  CeilingDecoration ceiling;
 final  List<DecorationFurniture> _furniture;
@override@JsonKey() List<DecorationFurniture> get furniture {
  if (_furniture is EqualUnmodifiableListView) return _furniture;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_furniture);
}

@override@JsonKey(name: 'updated_at') final  DateTime updatedAt;

/// Create a copy of Decoration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DecorationCopyWith<_Decoration> get copyWith => __$DecorationCopyWithImpl<_Decoration>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DecorationToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Decoration&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.walls, walls) || other.walls == walls)&&(identical(other.floor, floor) || other.floor == floor)&&(identical(other.ceiling, ceiling) || other.ceiling == ceiling)&&const DeepCollectionEquality().equals(other.furniture, _furniture)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,roomId,walls,floor,ceiling,const DeepCollectionEquality().hash(_furniture),updatedAt);
}

@override
String toString() {
    return 'Decoration(roomId: $roomId, walls: $walls, floor: $floor, ceiling: $ceiling, furniture: $furniture, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$DecorationCopyWith<$Res> implements $DecorationCopyWith<$Res> {
  factory _$DecorationCopyWith(_Decoration value, $Res Function(_Decoration) _then) = __$DecorationCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'room_id') String roomId, WallsDecoration walls, FloorDecoration floor, CeilingDecoration ceiling, List<DecorationFurniture> furniture,@JsonKey(name: 'updated_at') DateTime updatedAt
});


@override $WallsDecorationCopyWith<$Res> get walls;@override $FloorDecorationCopyWith<$Res> get floor;@override $CeilingDecorationCopyWith<$Res> get ceiling;

}
/// @nodoc
class __$DecorationCopyWithImpl<$Res>
    implements _$DecorationCopyWith<$Res> {
  __$DecorationCopyWithImpl(this._self, this._then);

  final _Decoration _self;
  final $Res Function(_Decoration) _then;

/// Create a copy of Decoration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? roomId = null,Object? walls = null,Object? floor = null,Object? ceiling = null,Object? furniture = null,Object? updatedAt = null,}) {
  return _then(_Decoration(
roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,walls: null == walls ? _self.walls : walls // ignore: cast_nullable_to_non_nullable
as WallsDecoration,floor: null == floor ? _self.floor : floor // ignore: cast_nullable_to_non_nullable
as FloorDecoration,ceiling: null == ceiling ? _self.ceiling : ceiling // ignore: cast_nullable_to_non_nullable
as CeilingDecoration,furniture: null == furniture ? _self._furniture : furniture // ignore: cast_nullable_to_non_nullable
as List<DecorationFurniture>,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of Decoration
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WallsDecorationCopyWith<$Res> get walls {
  
  return $WallsDecorationCopyWith<$Res>(_self.walls, (value) {
    return _then(_self.copyWith(walls: value));
  });
}/// Create a copy of Decoration
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FloorDecorationCopyWith<$Res> get floor {
  
  return $FloorDecorationCopyWith<$Res>(_self.floor, (value) {
    return _then(_self.copyWith(floor: value));
  });
}/// Create a copy of Decoration
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CeilingDecorationCopyWith<$Res> get ceiling {
  
  return $CeilingDecorationCopyWith<$Res>(_self.ceiling, (value) {
    return _then(_self.copyWith(ceiling: value));
  });
}
}

// dart format on
