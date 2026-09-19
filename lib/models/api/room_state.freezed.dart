// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RoomState {

@JsonKey(name: 'room_id') String get roomId;@JsonKey(name: 'current_state', unknownEnumValue: RoomStateValue.unknown) RoomStateValue get currentState;@JsonKey(name: 'floor_state', unknownEnumValue: RoomStateValue.unknown) RoomStateValue? get floorState;@JsonKey(name: 'ceiling_state', unknownEnumValue: RoomStateValue.unknown) RoomStateValue? get ceilingState;@JsonKey(name: 'walls_state', unknownEnumValue: RoomStateValue.unknown) RoomStateValue? get wallsState;@JsonKey(name: 'updated_at') DateTime get updatedAt;
/// Create a copy of RoomState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoomStateCopyWith<RoomState> get copyWith => _$RoomStateCopyWithImpl<RoomState>(this as RoomState, _$identity);

  /// Serializes this RoomState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RoomState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoomState&&(identical(other.roomId, _this.roomId) || other.roomId == _this.roomId)&&(identical(other.currentState, _this.currentState) || other.currentState == _this.currentState)&&(identical(other.floorState, _this.floorState) || other.floorState == _this.floorState)&&(identical(other.ceilingState, _this.ceilingState) || other.ceilingState == _this.ceilingState)&&(identical(other.wallsState, _this.wallsState) || other.wallsState == _this.wallsState)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RoomState;
  return Object.hash(runtimeType,_this.roomId,_this.currentState,_this.floorState,_this.ceilingState,_this.wallsState,_this.updatedAt);
}

@override
String toString() {
  final _this = this as RoomState;
  return 'RoomState(roomId: ${_this.roomId}, currentState: ${_this.currentState}, floorState: ${_this.floorState}, ceilingState: ${_this.ceilingState}, wallsState: ${_this.wallsState}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $RoomStateCopyWith<$Res>  {
  factory $RoomStateCopyWith(RoomState value, $Res Function(RoomState) _then) = _$RoomStateCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'room_id') String roomId,@JsonKey(name: 'current_state', unknownEnumValue: RoomStateValue.unknown) RoomStateValue currentState,@JsonKey(name: 'floor_state', unknownEnumValue: RoomStateValue.unknown) RoomStateValue? floorState,@JsonKey(name: 'ceiling_state', unknownEnumValue: RoomStateValue.unknown) RoomStateValue? ceilingState,@JsonKey(name: 'walls_state', unknownEnumValue: RoomStateValue.unknown) RoomStateValue? wallsState,@JsonKey(name: 'updated_at') DateTime updatedAt
});




}
/// @nodoc
class _$RoomStateCopyWithImpl<$Res>
    implements $RoomStateCopyWith<$Res> {
  _$RoomStateCopyWithImpl(this._self, this._then);

  final RoomState _self;
  final $Res Function(RoomState) _then;

/// Create a copy of RoomState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? roomId = null,Object? currentState = null,Object? floorState = freezed,Object? ceilingState = freezed,Object? wallsState = freezed,Object? updatedAt = null,}) {
  return _then(RoomState(
roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,currentState: null == currentState ? _self.currentState : currentState // ignore: cast_nullable_to_non_nullable
as RoomStateValue,floorState: freezed == floorState ? _self.floorState : floorState // ignore: cast_nullable_to_non_nullable
as RoomStateValue?,ceilingState: freezed == ceilingState ? _self.ceilingState : ceilingState // ignore: cast_nullable_to_non_nullable
as RoomStateValue?,wallsState: freezed == wallsState ? _self.wallsState : wallsState // ignore: cast_nullable_to_non_nullable
as RoomStateValue?,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [RoomState].
extension RoomStatePatterns on RoomState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoomState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoomState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoomState value)  $default,){
final _that = this;
switch (_that) {
case _RoomState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoomState value)?  $default,){
final _that = this;
switch (_that) {
case _RoomState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'room_id')  String roomId, @JsonKey(name: 'current_state', unknownEnumValue: RoomStateValue.unknown)  RoomStateValue currentState, @JsonKey(name: 'floor_state', unknownEnumValue: RoomStateValue.unknown)  RoomStateValue? floorState, @JsonKey(name: 'ceiling_state', unknownEnumValue: RoomStateValue.unknown)  RoomStateValue? ceilingState, @JsonKey(name: 'walls_state', unknownEnumValue: RoomStateValue.unknown)  RoomStateValue? wallsState, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoomState() when $default != null:
return $default(_that.roomId,_that.currentState,_that.floorState,_that.ceilingState,_that.wallsState,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'room_id')  String roomId, @JsonKey(name: 'current_state', unknownEnumValue: RoomStateValue.unknown)  RoomStateValue currentState, @JsonKey(name: 'floor_state', unknownEnumValue: RoomStateValue.unknown)  RoomStateValue? floorState, @JsonKey(name: 'ceiling_state', unknownEnumValue: RoomStateValue.unknown)  RoomStateValue? ceilingState, @JsonKey(name: 'walls_state', unknownEnumValue: RoomStateValue.unknown)  RoomStateValue? wallsState, @JsonKey(name: 'updated_at')  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _RoomState():
return $default(_that.roomId,_that.currentState,_that.floorState,_that.ceilingState,_that.wallsState,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'room_id')  String roomId, @JsonKey(name: 'current_state', unknownEnumValue: RoomStateValue.unknown)  RoomStateValue currentState, @JsonKey(name: 'floor_state', unknownEnumValue: RoomStateValue.unknown)  RoomStateValue? floorState, @JsonKey(name: 'ceiling_state', unknownEnumValue: RoomStateValue.unknown)  RoomStateValue? ceilingState, @JsonKey(name: 'walls_state', unknownEnumValue: RoomStateValue.unknown)  RoomStateValue? wallsState, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _RoomState() when $default != null:
return $default(_that.roomId,_that.currentState,_that.floorState,_that.ceilingState,_that.wallsState,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RoomState implements RoomState {
  const _RoomState({@JsonKey(name: 'room_id') required this.roomId, @JsonKey(name: 'current_state', unknownEnumValue: RoomStateValue.unknown) required this.currentState, @JsonKey(name: 'floor_state', unknownEnumValue: RoomStateValue.unknown) this.floorState, @JsonKey(name: 'ceiling_state', unknownEnumValue: RoomStateValue.unknown) this.ceilingState, @JsonKey(name: 'walls_state', unknownEnumValue: RoomStateValue.unknown) this.wallsState, @JsonKey(name: 'updated_at') required this.updatedAt});
  factory _RoomState.fromJson(Map<String, dynamic> json) => _$RoomStateFromJson(json);

@override@JsonKey(name: 'room_id') final  String roomId;
@override@JsonKey(name: 'current_state', unknownEnumValue: RoomStateValue.unknown) final  RoomStateValue currentState;
@override@JsonKey(name: 'floor_state', unknownEnumValue: RoomStateValue.unknown) final  RoomStateValue? floorState;
@override@JsonKey(name: 'ceiling_state', unknownEnumValue: RoomStateValue.unknown) final  RoomStateValue? ceilingState;
@override@JsonKey(name: 'walls_state', unknownEnumValue: RoomStateValue.unknown) final  RoomStateValue? wallsState;
@override@JsonKey(name: 'updated_at') final  DateTime updatedAt;

/// Create a copy of RoomState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoomStateCopyWith<_RoomState> get copyWith => __$RoomStateCopyWithImpl<_RoomState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoomStateToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoomState&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.currentState, currentState) || other.currentState == currentState)&&(identical(other.floorState, floorState) || other.floorState == floorState)&&(identical(other.ceilingState, ceilingState) || other.ceilingState == ceilingState)&&(identical(other.wallsState, wallsState) || other.wallsState == wallsState)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,roomId,currentState,floorState,ceilingState,wallsState,updatedAt);
}

@override
String toString() {
    return 'RoomState(roomId: $roomId, currentState: $currentState, floorState: $floorState, ceilingState: $ceilingState, wallsState: $wallsState, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$RoomStateCopyWith<$Res> implements $RoomStateCopyWith<$Res> {
  factory _$RoomStateCopyWith(_RoomState value, $Res Function(_RoomState) _then) = __$RoomStateCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'room_id') String roomId,@JsonKey(name: 'current_state', unknownEnumValue: RoomStateValue.unknown) RoomStateValue currentState,@JsonKey(name: 'floor_state', unknownEnumValue: RoomStateValue.unknown) RoomStateValue? floorState,@JsonKey(name: 'ceiling_state', unknownEnumValue: RoomStateValue.unknown) RoomStateValue? ceilingState,@JsonKey(name: 'walls_state', unknownEnumValue: RoomStateValue.unknown) RoomStateValue? wallsState,@JsonKey(name: 'updated_at') DateTime updatedAt
});




}
/// @nodoc
class __$RoomStateCopyWithImpl<$Res>
    implements _$RoomStateCopyWith<$Res> {
  __$RoomStateCopyWithImpl(this._self, this._then);

  final _RoomState _self;
  final $Res Function(_RoomState) _then;

/// Create a copy of RoomState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? roomId = null,Object? currentState = null,Object? floorState = freezed,Object? ceilingState = freezed,Object? wallsState = freezed,Object? updatedAt = null,}) {
  return _then(_RoomState(
roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,currentState: null == currentState ? _self.currentState : currentState // ignore: cast_nullable_to_non_nullable
as RoomStateValue,floorState: freezed == floorState ? _self.floorState : floorState // ignore: cast_nullable_to_non_nullable
as RoomStateValue?,ceilingState: freezed == ceilingState ? _self.ceilingState : ceilingState // ignore: cast_nullable_to_non_nullable
as RoomStateValue?,wallsState: freezed == wallsState ? _self.wallsState : wallsState // ignore: cast_nullable_to_non_nullable
as RoomStateValue?,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
