// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RoomState _$RoomStateFromJson(Map<String, dynamic> json) {
  return _RoomState.fromJson(json);
}

/// @nodoc
mixin _$RoomState {
  @JsonKey(name: 'room_id')
  String get roomId => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_state')
  RoomStateValue get currentState => throw _privateConstructorUsedError;
  @JsonKey(name: 'floor_state')
  RoomStateValue? get floorState => throw _privateConstructorUsedError;
  @JsonKey(name: 'ceiling_state')
  RoomStateValue? get ceilingState => throw _privateConstructorUsedError;
  @JsonKey(name: 'walls_state')
  RoomStateValue? get wallsState => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this RoomState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RoomState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoomStateCopyWith<RoomState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomStateCopyWith<$Res> {
  factory $RoomStateCopyWith(RoomState value, $Res Function(RoomState) then) =
      _$RoomStateCopyWithImpl<$Res, RoomState>;
  @useResult
  $Res call({
    @JsonKey(name: 'room_id') String roomId,
    @JsonKey(name: 'current_state') RoomStateValue currentState,
    @JsonKey(name: 'floor_state') RoomStateValue? floorState,
    @JsonKey(name: 'ceiling_state') RoomStateValue? ceilingState,
    @JsonKey(name: 'walls_state') RoomStateValue? wallsState,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });
}

/// @nodoc
class _$RoomStateCopyWithImpl<$Res, $Val extends RoomState>
    implements $RoomStateCopyWith<$Res> {
  _$RoomStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RoomState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roomId = null,
    Object? currentState = null,
    Object? floorState = freezed,
    Object? ceilingState = freezed,
    Object? wallsState = freezed,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            roomId: null == roomId
                ? _value.roomId
                : roomId // ignore: cast_nullable_to_non_nullable
                      as String,
            currentState: null == currentState
                ? _value.currentState
                : currentState // ignore: cast_nullable_to_non_nullable
                      as RoomStateValue,
            floorState: freezed == floorState
                ? _value.floorState
                : floorState // ignore: cast_nullable_to_non_nullable
                      as RoomStateValue?,
            ceilingState: freezed == ceilingState
                ? _value.ceilingState
                : ceilingState // ignore: cast_nullable_to_non_nullable
                      as RoomStateValue?,
            wallsState: freezed == wallsState
                ? _value.wallsState
                : wallsState // ignore: cast_nullable_to_non_nullable
                      as RoomStateValue?,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RoomStateImplCopyWith<$Res>
    implements $RoomStateCopyWith<$Res> {
  factory _$$RoomStateImplCopyWith(
    _$RoomStateImpl value,
    $Res Function(_$RoomStateImpl) then,
  ) = __$$RoomStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'room_id') String roomId,
    @JsonKey(name: 'current_state') RoomStateValue currentState,
    @JsonKey(name: 'floor_state') RoomStateValue? floorState,
    @JsonKey(name: 'ceiling_state') RoomStateValue? ceilingState,
    @JsonKey(name: 'walls_state') RoomStateValue? wallsState,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });
}

/// @nodoc
class __$$RoomStateImplCopyWithImpl<$Res>
    extends _$RoomStateCopyWithImpl<$Res, _$RoomStateImpl>
    implements _$$RoomStateImplCopyWith<$Res> {
  __$$RoomStateImplCopyWithImpl(
    _$RoomStateImpl _value,
    $Res Function(_$RoomStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RoomState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roomId = null,
    Object? currentState = null,
    Object? floorState = freezed,
    Object? ceilingState = freezed,
    Object? wallsState = freezed,
    Object? updatedAt = null,
  }) {
    return _then(
      _$RoomStateImpl(
        roomId: null == roomId
            ? _value.roomId
            : roomId // ignore: cast_nullable_to_non_nullable
                  as String,
        currentState: null == currentState
            ? _value.currentState
            : currentState // ignore: cast_nullable_to_non_nullable
                  as RoomStateValue,
        floorState: freezed == floorState
            ? _value.floorState
            : floorState // ignore: cast_nullable_to_non_nullable
                  as RoomStateValue?,
        ceilingState: freezed == ceilingState
            ? _value.ceilingState
            : ceilingState // ignore: cast_nullable_to_non_nullable
                  as RoomStateValue?,
        wallsState: freezed == wallsState
            ? _value.wallsState
            : wallsState // ignore: cast_nullable_to_non_nullable
                  as RoomStateValue?,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RoomStateImpl implements _RoomState {
  const _$RoomStateImpl({
    @JsonKey(name: 'room_id') required this.roomId,
    @JsonKey(name: 'current_state') required this.currentState,
    @JsonKey(name: 'floor_state') this.floorState,
    @JsonKey(name: 'ceiling_state') this.ceilingState,
    @JsonKey(name: 'walls_state') this.wallsState,
    @JsonKey(name: 'updated_at') required this.updatedAt,
  });

  factory _$RoomStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoomStateImplFromJson(json);

  @override
  @JsonKey(name: 'room_id')
  final String roomId;
  @override
  @JsonKey(name: 'current_state')
  final RoomStateValue currentState;
  @override
  @JsonKey(name: 'floor_state')
  final RoomStateValue? floorState;
  @override
  @JsonKey(name: 'ceiling_state')
  final RoomStateValue? ceilingState;
  @override
  @JsonKey(name: 'walls_state')
  final RoomStateValue? wallsState;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @override
  String toString() {
    return 'RoomState(roomId: $roomId, currentState: $currentState, floorState: $floorState, ceilingState: $ceilingState, wallsState: $wallsState, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomStateImpl &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.currentState, currentState) ||
                other.currentState == currentState) &&
            (identical(other.floorState, floorState) ||
                other.floorState == floorState) &&
            (identical(other.ceilingState, ceilingState) ||
                other.ceilingState == ceilingState) &&
            (identical(other.wallsState, wallsState) ||
                other.wallsState == wallsState) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    roomId,
    currentState,
    floorState,
    ceilingState,
    wallsState,
    updatedAt,
  );

  /// Create a copy of RoomState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomStateImplCopyWith<_$RoomStateImpl> get copyWith =>
      __$$RoomStateImplCopyWithImpl<_$RoomStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoomStateImplToJson(this);
  }
}

abstract class _RoomState implements RoomState {
  const factory _RoomState({
    @JsonKey(name: 'room_id') required final String roomId,
    @JsonKey(name: 'current_state') required final RoomStateValue currentState,
    @JsonKey(name: 'floor_state') final RoomStateValue? floorState,
    @JsonKey(name: 'ceiling_state') final RoomStateValue? ceilingState,
    @JsonKey(name: 'walls_state') final RoomStateValue? wallsState,
    @JsonKey(name: 'updated_at') required final DateTime updatedAt,
  }) = _$RoomStateImpl;

  factory _RoomState.fromJson(Map<String, dynamic> json) =
      _$RoomStateImpl.fromJson;

  @override
  @JsonKey(name: 'room_id')
  String get roomId;
  @override
  @JsonKey(name: 'current_state')
  RoomStateValue get currentState;
  @override
  @JsonKey(name: 'floor_state')
  RoomStateValue? get floorState;
  @override
  @JsonKey(name: 'ceiling_state')
  RoomStateValue? get ceilingState;
  @override
  @JsonKey(name: 'walls_state')
  RoomStateValue? get wallsState;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;

  /// Create a copy of RoomState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoomStateImplCopyWith<_$RoomStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
