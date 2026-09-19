// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'electrical.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ElectricalDeviceOut {

 String get id;@JsonKey(name: 'room_id') String get roomId;@JsonKey(unknownEnumValue: ElectricalDeviceType.unknown) ElectricalDeviceType get type; String? get variant;@JsonKey(name: 'wall_index') int get wallIndex; double get x; double get y; int get count;
/// Create a copy of ElectricalDeviceOut
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ElectricalDeviceOutCopyWith<ElectricalDeviceOut> get copyWith => _$ElectricalDeviceOutCopyWithImpl<ElectricalDeviceOut>(this as ElectricalDeviceOut, _$identity);

  /// Serializes this ElectricalDeviceOut to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ElectricalDeviceOut;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ElectricalDeviceOut&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.roomId, _this.roomId) || other.roomId == _this.roomId)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.variant, _this.variant) || other.variant == _this.variant)&&(identical(other.wallIndex, _this.wallIndex) || other.wallIndex == _this.wallIndex)&&(identical(other.x, _this.x) || other.x == _this.x)&&(identical(other.y, _this.y) || other.y == _this.y)&&(identical(other.count, _this.count) || other.count == _this.count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ElectricalDeviceOut;
  return Object.hash(runtimeType,_this.id,_this.roomId,_this.type,_this.variant,_this.wallIndex,_this.x,_this.y,_this.count);
}

@override
String toString() {
  final _this = this as ElectricalDeviceOut;
  return 'ElectricalDeviceOut(id: ${_this.id}, roomId: ${_this.roomId}, type: ${_this.type}, variant: ${_this.variant}, wallIndex: ${_this.wallIndex}, x: ${_this.x}, y: ${_this.y}, count: ${_this.count})';
}


}

/// @nodoc
abstract mixin class $ElectricalDeviceOutCopyWith<$Res>  {
  factory $ElectricalDeviceOutCopyWith(ElectricalDeviceOut value, $Res Function(ElectricalDeviceOut) _then) = _$ElectricalDeviceOutCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'room_id') String roomId,@JsonKey(unknownEnumValue: ElectricalDeviceType.unknown) ElectricalDeviceType type, String? variant,@JsonKey(name: 'wall_index') int wallIndex, double x, double y, int count
});




}
/// @nodoc
class _$ElectricalDeviceOutCopyWithImpl<$Res>
    implements $ElectricalDeviceOutCopyWith<$Res> {
  _$ElectricalDeviceOutCopyWithImpl(this._self, this._then);

  final ElectricalDeviceOut _self;
  final $Res Function(ElectricalDeviceOut) _then;

/// Create a copy of ElectricalDeviceOut
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? roomId = null,Object? type = null,Object? variant = freezed,Object? wallIndex = null,Object? x = null,Object? y = null,Object? count = null,}) {
  return _then(ElectricalDeviceOut(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ElectricalDeviceType,variant: freezed == variant ? _self.variant : variant // ignore: cast_nullable_to_non_nullable
as String?,wallIndex: null == wallIndex ? _self.wallIndex : wallIndex // ignore: cast_nullable_to_non_nullable
as int,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ElectricalDeviceOut].
extension ElectricalDeviceOutPatterns on ElectricalDeviceOut {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ElectricalDeviceOut value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ElectricalDeviceOut() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ElectricalDeviceOut value)  $default,){
final _that = this;
switch (_that) {
case _ElectricalDeviceOut():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ElectricalDeviceOut value)?  $default,){
final _that = this;
switch (_that) {
case _ElectricalDeviceOut() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'room_id')  String roomId, @JsonKey(unknownEnumValue: ElectricalDeviceType.unknown)  ElectricalDeviceType type,  String? variant, @JsonKey(name: 'wall_index')  int wallIndex,  double x,  double y,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ElectricalDeviceOut() when $default != null:
return $default(_that.id,_that.roomId,_that.type,_that.variant,_that.wallIndex,_that.x,_that.y,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'room_id')  String roomId, @JsonKey(unknownEnumValue: ElectricalDeviceType.unknown)  ElectricalDeviceType type,  String? variant, @JsonKey(name: 'wall_index')  int wallIndex,  double x,  double y,  int count)  $default,) {final _that = this;
switch (_that) {
case _ElectricalDeviceOut():
return $default(_that.id,_that.roomId,_that.type,_that.variant,_that.wallIndex,_that.x,_that.y,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'room_id')  String roomId, @JsonKey(unknownEnumValue: ElectricalDeviceType.unknown)  ElectricalDeviceType type,  String? variant, @JsonKey(name: 'wall_index')  int wallIndex,  double x,  double y,  int count)?  $default,) {final _that = this;
switch (_that) {
case _ElectricalDeviceOut() when $default != null:
return $default(_that.id,_that.roomId,_that.type,_that.variant,_that.wallIndex,_that.x,_that.y,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ElectricalDeviceOut implements ElectricalDeviceOut {
  const _ElectricalDeviceOut({required this.id, @JsonKey(name: 'room_id') required this.roomId, @JsonKey(unknownEnumValue: ElectricalDeviceType.unknown) required this.type, this.variant, @JsonKey(name: 'wall_index') required this.wallIndex, required this.x, required this.y, this.count = 1});
  factory _ElectricalDeviceOut.fromJson(Map<String, dynamic> json) => _$ElectricalDeviceOutFromJson(json);

@override final  String id;
@override@JsonKey(name: 'room_id') final  String roomId;
@override@JsonKey(unknownEnumValue: ElectricalDeviceType.unknown) final  ElectricalDeviceType type;
@override final  String? variant;
@override@JsonKey(name: 'wall_index') final  int wallIndex;
@override final  double x;
@override final  double y;
@override@JsonKey() final  int count;

/// Create a copy of ElectricalDeviceOut
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ElectricalDeviceOutCopyWith<_ElectricalDeviceOut> get copyWith => __$ElectricalDeviceOutCopyWithImpl<_ElectricalDeviceOut>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ElectricalDeviceOutToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ElectricalDeviceOut&&(identical(other.id, id) || other.id == id)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.type, type) || other.type == type)&&(identical(other.variant, variant) || other.variant == variant)&&(identical(other.wallIndex, wallIndex) || other.wallIndex == wallIndex)&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,roomId,type,variant,wallIndex,x,y,count);
}

@override
String toString() {
    return 'ElectricalDeviceOut(id: $id, roomId: $roomId, type: $type, variant: $variant, wallIndex: $wallIndex, x: $x, y: $y, count: $count)';
}


}

/// @nodoc
abstract mixin class _$ElectricalDeviceOutCopyWith<$Res> implements $ElectricalDeviceOutCopyWith<$Res> {
  factory _$ElectricalDeviceOutCopyWith(_ElectricalDeviceOut value, $Res Function(_ElectricalDeviceOut) _then) = __$ElectricalDeviceOutCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'room_id') String roomId,@JsonKey(unknownEnumValue: ElectricalDeviceType.unknown) ElectricalDeviceType type, String? variant,@JsonKey(name: 'wall_index') int wallIndex, double x, double y, int count
});




}
/// @nodoc
class __$ElectricalDeviceOutCopyWithImpl<$Res>
    implements _$ElectricalDeviceOutCopyWith<$Res> {
  __$ElectricalDeviceOutCopyWithImpl(this._self, this._then);

  final _ElectricalDeviceOut _self;
  final $Res Function(_ElectricalDeviceOut) _then;

/// Create a copy of ElectricalDeviceOut
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? roomId = null,Object? type = null,Object? variant = freezed,Object? wallIndex = null,Object? x = null,Object? y = null,Object? count = null,}) {
  return _then(_ElectricalDeviceOut(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ElectricalDeviceType,variant: freezed == variant ? _self.variant : variant // ignore: cast_nullable_to_non_nullable
as String?,wallIndex: null == wallIndex ? _self.wallIndex : wallIndex // ignore: cast_nullable_to_non_nullable
as int,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ElectricalDeviceCreate {

@JsonKey(unknownEnumValue: ElectricalDeviceType.unknown) ElectricalDeviceType get type; String? get variant;@JsonKey(name: 'wall_index') int get wallIndex; double get x; double get y; int get count;
/// Create a copy of ElectricalDeviceCreate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ElectricalDeviceCreateCopyWith<ElectricalDeviceCreate> get copyWith => _$ElectricalDeviceCreateCopyWithImpl<ElectricalDeviceCreate>(this as ElectricalDeviceCreate, _$identity);

  /// Serializes this ElectricalDeviceCreate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ElectricalDeviceCreate;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ElectricalDeviceCreate&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.variant, _this.variant) || other.variant == _this.variant)&&(identical(other.wallIndex, _this.wallIndex) || other.wallIndex == _this.wallIndex)&&(identical(other.x, _this.x) || other.x == _this.x)&&(identical(other.y, _this.y) || other.y == _this.y)&&(identical(other.count, _this.count) || other.count == _this.count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ElectricalDeviceCreate;
  return Object.hash(runtimeType,_this.type,_this.variant,_this.wallIndex,_this.x,_this.y,_this.count);
}

@override
String toString() {
  final _this = this as ElectricalDeviceCreate;
  return 'ElectricalDeviceCreate(type: ${_this.type}, variant: ${_this.variant}, wallIndex: ${_this.wallIndex}, x: ${_this.x}, y: ${_this.y}, count: ${_this.count})';
}


}

/// @nodoc
abstract mixin class $ElectricalDeviceCreateCopyWith<$Res>  {
  factory $ElectricalDeviceCreateCopyWith(ElectricalDeviceCreate value, $Res Function(ElectricalDeviceCreate) _then) = _$ElectricalDeviceCreateCopyWithImpl;
@useResult
$Res call({
@JsonKey(unknownEnumValue: ElectricalDeviceType.unknown) ElectricalDeviceType type, String? variant,@JsonKey(name: 'wall_index') int wallIndex, double x, double y, int count
});




}
/// @nodoc
class _$ElectricalDeviceCreateCopyWithImpl<$Res>
    implements $ElectricalDeviceCreateCopyWith<$Res> {
  _$ElectricalDeviceCreateCopyWithImpl(this._self, this._then);

  final ElectricalDeviceCreate _self;
  final $Res Function(ElectricalDeviceCreate) _then;

/// Create a copy of ElectricalDeviceCreate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? variant = freezed,Object? wallIndex = null,Object? x = null,Object? y = null,Object? count = null,}) {
  return _then(ElectricalDeviceCreate(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ElectricalDeviceType,variant: freezed == variant ? _self.variant : variant // ignore: cast_nullable_to_non_nullable
as String?,wallIndex: null == wallIndex ? _self.wallIndex : wallIndex // ignore: cast_nullable_to_non_nullable
as int,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ElectricalDeviceCreate].
extension ElectricalDeviceCreatePatterns on ElectricalDeviceCreate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ElectricalDeviceCreate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ElectricalDeviceCreate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ElectricalDeviceCreate value)  $default,){
final _that = this;
switch (_that) {
case _ElectricalDeviceCreate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ElectricalDeviceCreate value)?  $default,){
final _that = this;
switch (_that) {
case _ElectricalDeviceCreate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: ElectricalDeviceType.unknown)  ElectricalDeviceType type,  String? variant, @JsonKey(name: 'wall_index')  int wallIndex,  double x,  double y,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ElectricalDeviceCreate() when $default != null:
return $default(_that.type,_that.variant,_that.wallIndex,_that.x,_that.y,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: ElectricalDeviceType.unknown)  ElectricalDeviceType type,  String? variant, @JsonKey(name: 'wall_index')  int wallIndex,  double x,  double y,  int count)  $default,) {final _that = this;
switch (_that) {
case _ElectricalDeviceCreate():
return $default(_that.type,_that.variant,_that.wallIndex,_that.x,_that.y,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(unknownEnumValue: ElectricalDeviceType.unknown)  ElectricalDeviceType type,  String? variant, @JsonKey(name: 'wall_index')  int wallIndex,  double x,  double y,  int count)?  $default,) {final _that = this;
switch (_that) {
case _ElectricalDeviceCreate() when $default != null:
return $default(_that.type,_that.variant,_that.wallIndex,_that.x,_that.y,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ElectricalDeviceCreate implements ElectricalDeviceCreate {
  const _ElectricalDeviceCreate({@JsonKey(unknownEnumValue: ElectricalDeviceType.unknown) required this.type, this.variant, @JsonKey(name: 'wall_index') required this.wallIndex, required this.x, required this.y, this.count = 1});
  factory _ElectricalDeviceCreate.fromJson(Map<String, dynamic> json) => _$ElectricalDeviceCreateFromJson(json);

@override@JsonKey(unknownEnumValue: ElectricalDeviceType.unknown) final  ElectricalDeviceType type;
@override final  String? variant;
@override@JsonKey(name: 'wall_index') final  int wallIndex;
@override final  double x;
@override final  double y;
@override@JsonKey() final  int count;

/// Create a copy of ElectricalDeviceCreate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ElectricalDeviceCreateCopyWith<_ElectricalDeviceCreate> get copyWith => __$ElectricalDeviceCreateCopyWithImpl<_ElectricalDeviceCreate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ElectricalDeviceCreateToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ElectricalDeviceCreate&&(identical(other.type, type) || other.type == type)&&(identical(other.variant, variant) || other.variant == variant)&&(identical(other.wallIndex, wallIndex) || other.wallIndex == wallIndex)&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,type,variant,wallIndex,x,y,count);
}

@override
String toString() {
    return 'ElectricalDeviceCreate(type: $type, variant: $variant, wallIndex: $wallIndex, x: $x, y: $y, count: $count)';
}


}

/// @nodoc
abstract mixin class _$ElectricalDeviceCreateCopyWith<$Res> implements $ElectricalDeviceCreateCopyWith<$Res> {
  factory _$ElectricalDeviceCreateCopyWith(_ElectricalDeviceCreate value, $Res Function(_ElectricalDeviceCreate) _then) = __$ElectricalDeviceCreateCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(unknownEnumValue: ElectricalDeviceType.unknown) ElectricalDeviceType type, String? variant,@JsonKey(name: 'wall_index') int wallIndex, double x, double y, int count
});




}
/// @nodoc
class __$ElectricalDeviceCreateCopyWithImpl<$Res>
    implements _$ElectricalDeviceCreateCopyWith<$Res> {
  __$ElectricalDeviceCreateCopyWithImpl(this._self, this._then);

  final _ElectricalDeviceCreate _self;
  final $Res Function(_ElectricalDeviceCreate) _then;

/// Create a copy of ElectricalDeviceCreate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? variant = freezed,Object? wallIndex = null,Object? x = null,Object? y = null,Object? count = null,}) {
  return _then(_ElectricalDeviceCreate(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ElectricalDeviceType,variant: freezed == variant ? _self.variant : variant // ignore: cast_nullable_to_non_nullable
as String?,wallIndex: null == wallIndex ? _self.wallIndex : wallIndex // ignore: cast_nullable_to_non_nullable
as int,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ElectricalPlan {

@JsonKey(name: 'room_id') String get roomId; List<ElectricalDeviceOut> get devices;@JsonKey(name: 'wiring_meters') double? get wiringMeters;@JsonKey(name: 'updated_at') DateTime get updatedAt;
/// Create a copy of ElectricalPlan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ElectricalPlanCopyWith<ElectricalPlan> get copyWith => _$ElectricalPlanCopyWithImpl<ElectricalPlan>(this as ElectricalPlan, _$identity);

  /// Serializes this ElectricalPlan to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ElectricalPlan;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ElectricalPlan&&(identical(other.roomId, _this.roomId) || other.roomId == _this.roomId)&&const DeepCollectionEquality().equals(other.devices, _this.devices)&&(identical(other.wiringMeters, _this.wiringMeters) || other.wiringMeters == _this.wiringMeters)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ElectricalPlan;
  return Object.hash(runtimeType,_this.roomId,const DeepCollectionEquality().hash(_this.devices),_this.wiringMeters,_this.updatedAt);
}

@override
String toString() {
  final _this = this as ElectricalPlan;
  return 'ElectricalPlan(roomId: ${_this.roomId}, devices: ${_this.devices}, wiringMeters: ${_this.wiringMeters}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $ElectricalPlanCopyWith<$Res>  {
  factory $ElectricalPlanCopyWith(ElectricalPlan value, $Res Function(ElectricalPlan) _then) = _$ElectricalPlanCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'room_id') String roomId, List<ElectricalDeviceOut> devices,@JsonKey(name: 'wiring_meters') double? wiringMeters,@JsonKey(name: 'updated_at') DateTime updatedAt
});




}
/// @nodoc
class _$ElectricalPlanCopyWithImpl<$Res>
    implements $ElectricalPlanCopyWith<$Res> {
  _$ElectricalPlanCopyWithImpl(this._self, this._then);

  final ElectricalPlan _self;
  final $Res Function(ElectricalPlan) _then;

/// Create a copy of ElectricalPlan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? roomId = null,Object? devices = null,Object? wiringMeters = freezed,Object? updatedAt = null,}) {
  return _then(ElectricalPlan(
roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,devices: null == devices ? _self.devices : devices // ignore: cast_nullable_to_non_nullable
as List<ElectricalDeviceOut>,wiringMeters: freezed == wiringMeters ? _self.wiringMeters : wiringMeters // ignore: cast_nullable_to_non_nullable
as double?,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ElectricalPlan].
extension ElectricalPlanPatterns on ElectricalPlan {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ElectricalPlan value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ElectricalPlan() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ElectricalPlan value)  $default,){
final _that = this;
switch (_that) {
case _ElectricalPlan():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ElectricalPlan value)?  $default,){
final _that = this;
switch (_that) {
case _ElectricalPlan() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'room_id')  String roomId,  List<ElectricalDeviceOut> devices, @JsonKey(name: 'wiring_meters')  double? wiringMeters, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ElectricalPlan() when $default != null:
return $default(_that.roomId,_that.devices,_that.wiringMeters,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'room_id')  String roomId,  List<ElectricalDeviceOut> devices, @JsonKey(name: 'wiring_meters')  double? wiringMeters, @JsonKey(name: 'updated_at')  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _ElectricalPlan():
return $default(_that.roomId,_that.devices,_that.wiringMeters,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'room_id')  String roomId,  List<ElectricalDeviceOut> devices, @JsonKey(name: 'wiring_meters')  double? wiringMeters, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ElectricalPlan() when $default != null:
return $default(_that.roomId,_that.devices,_that.wiringMeters,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ElectricalPlan implements ElectricalPlan {
  const _ElectricalPlan({@JsonKey(name: 'room_id') required this.roomId,  List<ElectricalDeviceOut> devices = const <ElectricalDeviceOut>[], @JsonKey(name: 'wiring_meters') this.wiringMeters, @JsonKey(name: 'updated_at') required this.updatedAt}): _devices = devices;
  factory _ElectricalPlan.fromJson(Map<String, dynamic> json) => _$ElectricalPlanFromJson(json);

@override@JsonKey(name: 'room_id') final  String roomId;
 final  List<ElectricalDeviceOut> _devices;
@override@JsonKey() List<ElectricalDeviceOut> get devices {
  if (_devices is EqualUnmodifiableListView) return _devices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_devices);
}

@override@JsonKey(name: 'wiring_meters') final  double? wiringMeters;
@override@JsonKey(name: 'updated_at') final  DateTime updatedAt;

/// Create a copy of ElectricalPlan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ElectricalPlanCopyWith<_ElectricalPlan> get copyWith => __$ElectricalPlanCopyWithImpl<_ElectricalPlan>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ElectricalPlanToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ElectricalPlan&&(identical(other.roomId, roomId) || other.roomId == roomId)&&const DeepCollectionEquality().equals(other.devices, _devices)&&(identical(other.wiringMeters, wiringMeters) || other.wiringMeters == wiringMeters)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,roomId,const DeepCollectionEquality().hash(_devices),wiringMeters,updatedAt);
}

@override
String toString() {
    return 'ElectricalPlan(roomId: $roomId, devices: $devices, wiringMeters: $wiringMeters, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ElectricalPlanCopyWith<$Res> implements $ElectricalPlanCopyWith<$Res> {
  factory _$ElectricalPlanCopyWith(_ElectricalPlan value, $Res Function(_ElectricalPlan) _then) = __$ElectricalPlanCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'room_id') String roomId, List<ElectricalDeviceOut> devices,@JsonKey(name: 'wiring_meters') double? wiringMeters,@JsonKey(name: 'updated_at') DateTime updatedAt
});




}
/// @nodoc
class __$ElectricalPlanCopyWithImpl<$Res>
    implements _$ElectricalPlanCopyWith<$Res> {
  __$ElectricalPlanCopyWithImpl(this._self, this._then);

  final _ElectricalPlan _self;
  final $Res Function(_ElectricalPlan) _then;

/// Create a copy of ElectricalPlan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? roomId = null,Object? devices = null,Object? wiringMeters = freezed,Object? updatedAt = null,}) {
  return _then(_ElectricalPlan(
roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,devices: null == devices ? _self._devices : devices // ignore: cast_nullable_to_non_nullable
as List<ElectricalDeviceOut>,wiringMeters: freezed == wiringMeters ? _self.wiringMeters : wiringMeters // ignore: cast_nullable_to_non_nullable
as double?,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
