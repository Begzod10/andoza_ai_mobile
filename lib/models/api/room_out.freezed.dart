// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room_out.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RoomOut {

 String get id;@JsonKey(name: 'apartment_id') String get apartmentId; String get name;@JsonKey(name: 'ceiling_h') double? get ceilingH; Map<String, dynamic>? get geometry; Map<String, dynamic>? get surfaces;@JsonKey(name: 'furniture_layout') List<dynamic>? get furnitureLayout; Map<String, dynamic>? get state;@JsonKey(name: 'floor_area') double? get floorArea;@JsonKey(name: 'net_wall_area') double? get netWallArea; double? get perimeter;@JsonKey(name: 'openings_count') int get openingsCount;@JsonKey(name: 'updated_at') DateTime get updatedAt;
/// Create a copy of RoomOut
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoomOutCopyWith<RoomOut> get copyWith => _$RoomOutCopyWithImpl<RoomOut>(this as RoomOut, _$identity);

  /// Serializes this RoomOut to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RoomOut;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoomOut&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.apartmentId, _this.apartmentId) || other.apartmentId == _this.apartmentId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.ceilingH, _this.ceilingH) || other.ceilingH == _this.ceilingH)&&const DeepCollectionEquality().equals(other.geometry, _this.geometry)&&const DeepCollectionEquality().equals(other.surfaces, _this.surfaces)&&const DeepCollectionEquality().equals(other.furnitureLayout, _this.furnitureLayout)&&const DeepCollectionEquality().equals(other.state, _this.state)&&(identical(other.floorArea, _this.floorArea) || other.floorArea == _this.floorArea)&&(identical(other.netWallArea, _this.netWallArea) || other.netWallArea == _this.netWallArea)&&(identical(other.perimeter, _this.perimeter) || other.perimeter == _this.perimeter)&&(identical(other.openingsCount, _this.openingsCount) || other.openingsCount == _this.openingsCount)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RoomOut;
  return Object.hash(runtimeType,_this.id,_this.apartmentId,_this.name,_this.ceilingH,const DeepCollectionEquality().hash(_this.geometry),const DeepCollectionEquality().hash(_this.surfaces),const DeepCollectionEquality().hash(_this.furnitureLayout),const DeepCollectionEquality().hash(_this.state),_this.floorArea,_this.netWallArea,_this.perimeter,_this.openingsCount,_this.updatedAt);
}

@override
String toString() {
  final _this = this as RoomOut;
  return 'RoomOut(id: ${_this.id}, apartmentId: ${_this.apartmentId}, name: ${_this.name}, ceilingH: ${_this.ceilingH}, geometry: ${_this.geometry}, surfaces: ${_this.surfaces}, furnitureLayout: ${_this.furnitureLayout}, state: ${_this.state}, floorArea: ${_this.floorArea}, netWallArea: ${_this.netWallArea}, perimeter: ${_this.perimeter}, openingsCount: ${_this.openingsCount}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $RoomOutCopyWith<$Res>  {
  factory $RoomOutCopyWith(RoomOut value, $Res Function(RoomOut) _then) = _$RoomOutCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'apartment_id') String apartmentId, String name,@JsonKey(name: 'ceiling_h') double? ceilingH, Map<String, dynamic>? geometry, Map<String, dynamic>? surfaces,@JsonKey(name: 'furniture_layout') List<dynamic>? furnitureLayout, Map<String, dynamic>? state,@JsonKey(name: 'floor_area') double? floorArea,@JsonKey(name: 'net_wall_area') double? netWallArea, double? perimeter,@JsonKey(name: 'openings_count') int openingsCount,@JsonKey(name: 'updated_at') DateTime updatedAt
});




}
/// @nodoc
class _$RoomOutCopyWithImpl<$Res>
    implements $RoomOutCopyWith<$Res> {
  _$RoomOutCopyWithImpl(this._self, this._then);

  final RoomOut _self;
  final $Res Function(RoomOut) _then;

/// Create a copy of RoomOut
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? apartmentId = null,Object? name = null,Object? ceilingH = freezed,Object? geometry = freezed,Object? surfaces = freezed,Object? furnitureLayout = freezed,Object? state = freezed,Object? floorArea = freezed,Object? netWallArea = freezed,Object? perimeter = freezed,Object? openingsCount = null,Object? updatedAt = null,}) {
  return _then(RoomOut(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,apartmentId: null == apartmentId ? _self.apartmentId : apartmentId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,ceilingH: freezed == ceilingH ? _self.ceilingH : ceilingH // ignore: cast_nullable_to_non_nullable
as double?,geometry: freezed == geometry ? _self.geometry : geometry // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,surfaces: freezed == surfaces ? _self.surfaces : surfaces // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,furnitureLayout: freezed == furnitureLayout ? _self.furnitureLayout : furnitureLayout // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,floorArea: freezed == floorArea ? _self.floorArea : floorArea // ignore: cast_nullable_to_non_nullable
as double?,netWallArea: freezed == netWallArea ? _self.netWallArea : netWallArea // ignore: cast_nullable_to_non_nullable
as double?,perimeter: freezed == perimeter ? _self.perimeter : perimeter // ignore: cast_nullable_to_non_nullable
as double?,openingsCount: null == openingsCount ? _self.openingsCount : openingsCount // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [RoomOut].
extension RoomOutPatterns on RoomOut {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoomOut value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoomOut() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoomOut value)  $default,){
final _that = this;
switch (_that) {
case _RoomOut():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoomOut value)?  $default,){
final _that = this;
switch (_that) {
case _RoomOut() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'apartment_id')  String apartmentId,  String name, @JsonKey(name: 'ceiling_h')  double? ceilingH,  Map<String, dynamic>? geometry,  Map<String, dynamic>? surfaces, @JsonKey(name: 'furniture_layout')  List<dynamic>? furnitureLayout,  Map<String, dynamic>? state, @JsonKey(name: 'floor_area')  double? floorArea, @JsonKey(name: 'net_wall_area')  double? netWallArea,  double? perimeter, @JsonKey(name: 'openings_count')  int openingsCount, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoomOut() when $default != null:
return $default(_that.id,_that.apartmentId,_that.name,_that.ceilingH,_that.geometry,_that.surfaces,_that.furnitureLayout,_that.state,_that.floorArea,_that.netWallArea,_that.perimeter,_that.openingsCount,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'apartment_id')  String apartmentId,  String name, @JsonKey(name: 'ceiling_h')  double? ceilingH,  Map<String, dynamic>? geometry,  Map<String, dynamic>? surfaces, @JsonKey(name: 'furniture_layout')  List<dynamic>? furnitureLayout,  Map<String, dynamic>? state, @JsonKey(name: 'floor_area')  double? floorArea, @JsonKey(name: 'net_wall_area')  double? netWallArea,  double? perimeter, @JsonKey(name: 'openings_count')  int openingsCount, @JsonKey(name: 'updated_at')  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _RoomOut():
return $default(_that.id,_that.apartmentId,_that.name,_that.ceilingH,_that.geometry,_that.surfaces,_that.furnitureLayout,_that.state,_that.floorArea,_that.netWallArea,_that.perimeter,_that.openingsCount,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'apartment_id')  String apartmentId,  String name, @JsonKey(name: 'ceiling_h')  double? ceilingH,  Map<String, dynamic>? geometry,  Map<String, dynamic>? surfaces, @JsonKey(name: 'furniture_layout')  List<dynamic>? furnitureLayout,  Map<String, dynamic>? state, @JsonKey(name: 'floor_area')  double? floorArea, @JsonKey(name: 'net_wall_area')  double? netWallArea,  double? perimeter, @JsonKey(name: 'openings_count')  int openingsCount, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _RoomOut() when $default != null:
return $default(_that.id,_that.apartmentId,_that.name,_that.ceilingH,_that.geometry,_that.surfaces,_that.furnitureLayout,_that.state,_that.floorArea,_that.netWallArea,_that.perimeter,_that.openingsCount,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RoomOut implements RoomOut {
  const _RoomOut({required this.id, @JsonKey(name: 'apartment_id') required this.apartmentId, required this.name, @JsonKey(name: 'ceiling_h') this.ceilingH,  Map<String, dynamic>? geometry,  Map<String, dynamic>? surfaces, @JsonKey(name: 'furniture_layout')  List<dynamic>? furnitureLayout,  Map<String, dynamic>? state, @JsonKey(name: 'floor_area') this.floorArea, @JsonKey(name: 'net_wall_area') this.netWallArea, this.perimeter, @JsonKey(name: 'openings_count') this.openingsCount = 0, @JsonKey(name: 'updated_at') required this.updatedAt}): _geometry = geometry,_surfaces = surfaces,_furnitureLayout = furnitureLayout,_state = state;
  factory _RoomOut.fromJson(Map<String, dynamic> json) => _$RoomOutFromJson(json);

@override final  String id;
@override@JsonKey(name: 'apartment_id') final  String apartmentId;
@override final  String name;
@override@JsonKey(name: 'ceiling_h') final  double? ceilingH;
 final  Map<String, dynamic>? _geometry;
@override Map<String, dynamic>? get geometry {
  final value = _geometry;
  if (value == null) return null;
  if (_geometry is EqualUnmodifiableMapView) return _geometry;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, dynamic>? _surfaces;
@override Map<String, dynamic>? get surfaces {
  final value = _surfaces;
  if (value == null) return null;
  if (_surfaces is EqualUnmodifiableMapView) return _surfaces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  List<dynamic>? _furnitureLayout;
@override@JsonKey(name: 'furniture_layout') List<dynamic>? get furnitureLayout {
  final value = _furnitureLayout;
  if (value == null) return null;
  if (_furnitureLayout is EqualUnmodifiableListView) return _furnitureLayout;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  Map<String, dynamic>? _state;
@override Map<String, dynamic>? get state {
  final value = _state;
  if (value == null) return null;
  if (_state is EqualUnmodifiableMapView) return _state;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override@JsonKey(name: 'floor_area') final  double? floorArea;
@override@JsonKey(name: 'net_wall_area') final  double? netWallArea;
@override final  double? perimeter;
@override@JsonKey(name: 'openings_count') final  int openingsCount;
@override@JsonKey(name: 'updated_at') final  DateTime updatedAt;

/// Create a copy of RoomOut
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoomOutCopyWith<_RoomOut> get copyWith => __$RoomOutCopyWithImpl<_RoomOut>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoomOutToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoomOut&&(identical(other.id, id) || other.id == id)&&(identical(other.apartmentId, apartmentId) || other.apartmentId == apartmentId)&&(identical(other.name, name) || other.name == name)&&(identical(other.ceilingH, ceilingH) || other.ceilingH == ceilingH)&&const DeepCollectionEquality().equals(other.geometry, _geometry)&&const DeepCollectionEquality().equals(other.surfaces, _surfaces)&&const DeepCollectionEquality().equals(other.furnitureLayout, _furnitureLayout)&&const DeepCollectionEquality().equals(other.state, _state)&&(identical(other.floorArea, floorArea) || other.floorArea == floorArea)&&(identical(other.netWallArea, netWallArea) || other.netWallArea == netWallArea)&&(identical(other.perimeter, perimeter) || other.perimeter == perimeter)&&(identical(other.openingsCount, openingsCount) || other.openingsCount == openingsCount)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,apartmentId,name,ceilingH,const DeepCollectionEquality().hash(_geometry),const DeepCollectionEquality().hash(_surfaces),const DeepCollectionEquality().hash(_furnitureLayout),const DeepCollectionEquality().hash(_state),floorArea,netWallArea,perimeter,openingsCount,updatedAt);
}

@override
String toString() {
    return 'RoomOut(id: $id, apartmentId: $apartmentId, name: $name, ceilingH: $ceilingH, geometry: $geometry, surfaces: $surfaces, furnitureLayout: $furnitureLayout, state: $state, floorArea: $floorArea, netWallArea: $netWallArea, perimeter: $perimeter, openingsCount: $openingsCount, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$RoomOutCopyWith<$Res> implements $RoomOutCopyWith<$Res> {
  factory _$RoomOutCopyWith(_RoomOut value, $Res Function(_RoomOut) _then) = __$RoomOutCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'apartment_id') String apartmentId, String name,@JsonKey(name: 'ceiling_h') double? ceilingH, Map<String, dynamic>? geometry, Map<String, dynamic>? surfaces,@JsonKey(name: 'furniture_layout') List<dynamic>? furnitureLayout, Map<String, dynamic>? state,@JsonKey(name: 'floor_area') double? floorArea,@JsonKey(name: 'net_wall_area') double? netWallArea, double? perimeter,@JsonKey(name: 'openings_count') int openingsCount,@JsonKey(name: 'updated_at') DateTime updatedAt
});




}
/// @nodoc
class __$RoomOutCopyWithImpl<$Res>
    implements _$RoomOutCopyWith<$Res> {
  __$RoomOutCopyWithImpl(this._self, this._then);

  final _RoomOut _self;
  final $Res Function(_RoomOut) _then;

/// Create a copy of RoomOut
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? apartmentId = null,Object? name = null,Object? ceilingH = freezed,Object? geometry = freezed,Object? surfaces = freezed,Object? furnitureLayout = freezed,Object? state = freezed,Object? floorArea = freezed,Object? netWallArea = freezed,Object? perimeter = freezed,Object? openingsCount = null,Object? updatedAt = null,}) {
  return _then(_RoomOut(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,apartmentId: null == apartmentId ? _self.apartmentId : apartmentId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,ceilingH: freezed == ceilingH ? _self.ceilingH : ceilingH // ignore: cast_nullable_to_non_nullable
as double?,geometry: freezed == geometry ? _self._geometry : geometry // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,surfaces: freezed == surfaces ? _self._surfaces : surfaces // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,furnitureLayout: freezed == furnitureLayout ? _self._furnitureLayout : furnitureLayout // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,state: freezed == state ? _self._state : state // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,floorArea: freezed == floorArea ? _self.floorArea : floorArea // ignore: cast_nullable_to_non_nullable
as double?,netWallArea: freezed == netWallArea ? _self.netWallArea : netWallArea // ignore: cast_nullable_to_non_nullable
as double?,perimeter: freezed == perimeter ? _self.perimeter : perimeter // ignore: cast_nullable_to_non_nullable
as double?,openingsCount: null == openingsCount ? _self.openingsCount : openingsCount // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
