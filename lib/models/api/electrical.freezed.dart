// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'electrical.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ElectricalDeviceOut _$ElectricalDeviceOutFromJson(Map<String, dynamic> json) {
  return _ElectricalDeviceOut.fromJson(json);
}

/// @nodoc
mixin _$ElectricalDeviceOut {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'room_id')
  String get roomId => throw _privateConstructorUsedError;
  ElectricalDeviceType get type => throw _privateConstructorUsedError;
  String? get variant => throw _privateConstructorUsedError;
  @JsonKey(name: 'wall_index')
  int get wallIndex => throw _privateConstructorUsedError;
  double get x => throw _privateConstructorUsedError;
  double get y => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;

  /// Serializes this ElectricalDeviceOut to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ElectricalDeviceOut
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ElectricalDeviceOutCopyWith<ElectricalDeviceOut> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ElectricalDeviceOutCopyWith<$Res> {
  factory $ElectricalDeviceOutCopyWith(
    ElectricalDeviceOut value,
    $Res Function(ElectricalDeviceOut) then,
  ) = _$ElectricalDeviceOutCopyWithImpl<$Res, ElectricalDeviceOut>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'room_id') String roomId,
    ElectricalDeviceType type,
    String? variant,
    @JsonKey(name: 'wall_index') int wallIndex,
    double x,
    double y,
    int count,
  });
}

/// @nodoc
class _$ElectricalDeviceOutCopyWithImpl<$Res, $Val extends ElectricalDeviceOut>
    implements $ElectricalDeviceOutCopyWith<$Res> {
  _$ElectricalDeviceOutCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ElectricalDeviceOut
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roomId = null,
    Object? type = null,
    Object? variant = freezed,
    Object? wallIndex = null,
    Object? x = null,
    Object? y = null,
    Object? count = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            roomId: null == roomId
                ? _value.roomId
                : roomId // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as ElectricalDeviceType,
            variant: freezed == variant
                ? _value.variant
                : variant // ignore: cast_nullable_to_non_nullable
                      as String?,
            wallIndex: null == wallIndex
                ? _value.wallIndex
                : wallIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            x: null == x
                ? _value.x
                : x // ignore: cast_nullable_to_non_nullable
                      as double,
            y: null == y
                ? _value.y
                : y // ignore: cast_nullable_to_non_nullable
                      as double,
            count: null == count
                ? _value.count
                : count // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ElectricalDeviceOutImplCopyWith<$Res>
    implements $ElectricalDeviceOutCopyWith<$Res> {
  factory _$$ElectricalDeviceOutImplCopyWith(
    _$ElectricalDeviceOutImpl value,
    $Res Function(_$ElectricalDeviceOutImpl) then,
  ) = __$$ElectricalDeviceOutImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'room_id') String roomId,
    ElectricalDeviceType type,
    String? variant,
    @JsonKey(name: 'wall_index') int wallIndex,
    double x,
    double y,
    int count,
  });
}

/// @nodoc
class __$$ElectricalDeviceOutImplCopyWithImpl<$Res>
    extends _$ElectricalDeviceOutCopyWithImpl<$Res, _$ElectricalDeviceOutImpl>
    implements _$$ElectricalDeviceOutImplCopyWith<$Res> {
  __$$ElectricalDeviceOutImplCopyWithImpl(
    _$ElectricalDeviceOutImpl _value,
    $Res Function(_$ElectricalDeviceOutImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ElectricalDeviceOut
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roomId = null,
    Object? type = null,
    Object? variant = freezed,
    Object? wallIndex = null,
    Object? x = null,
    Object? y = null,
    Object? count = null,
  }) {
    return _then(
      _$ElectricalDeviceOutImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        roomId: null == roomId
            ? _value.roomId
            : roomId // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as ElectricalDeviceType,
        variant: freezed == variant
            ? _value.variant
            : variant // ignore: cast_nullable_to_non_nullable
                  as String?,
        wallIndex: null == wallIndex
            ? _value.wallIndex
            : wallIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        x: null == x
            ? _value.x
            : x // ignore: cast_nullable_to_non_nullable
                  as double,
        y: null == y
            ? _value.y
            : y // ignore: cast_nullable_to_non_nullable
                  as double,
        count: null == count
            ? _value.count
            : count // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ElectricalDeviceOutImpl implements _ElectricalDeviceOut {
  const _$ElectricalDeviceOutImpl({
    required this.id,
    @JsonKey(name: 'room_id') required this.roomId,
    required this.type,
    this.variant,
    @JsonKey(name: 'wall_index') required this.wallIndex,
    required this.x,
    required this.y,
    this.count = 1,
  });

  factory _$ElectricalDeviceOutImpl.fromJson(Map<String, dynamic> json) =>
      _$$ElectricalDeviceOutImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'room_id')
  final String roomId;
  @override
  final ElectricalDeviceType type;
  @override
  final String? variant;
  @override
  @JsonKey(name: 'wall_index')
  final int wallIndex;
  @override
  final double x;
  @override
  final double y;
  @override
  @JsonKey()
  final int count;

  @override
  String toString() {
    return 'ElectricalDeviceOut(id: $id, roomId: $roomId, type: $type, variant: $variant, wallIndex: $wallIndex, x: $x, y: $y, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ElectricalDeviceOutImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.variant, variant) || other.variant == variant) &&
            (identical(other.wallIndex, wallIndex) ||
                other.wallIndex == wallIndex) &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    roomId,
    type,
    variant,
    wallIndex,
    x,
    y,
    count,
  );

  /// Create a copy of ElectricalDeviceOut
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ElectricalDeviceOutImplCopyWith<_$ElectricalDeviceOutImpl> get copyWith =>
      __$$ElectricalDeviceOutImplCopyWithImpl<_$ElectricalDeviceOutImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ElectricalDeviceOutImplToJson(this);
  }
}

abstract class _ElectricalDeviceOut implements ElectricalDeviceOut {
  const factory _ElectricalDeviceOut({
    required final String id,
    @JsonKey(name: 'room_id') required final String roomId,
    required final ElectricalDeviceType type,
    final String? variant,
    @JsonKey(name: 'wall_index') required final int wallIndex,
    required final double x,
    required final double y,
    final int count,
  }) = _$ElectricalDeviceOutImpl;

  factory _ElectricalDeviceOut.fromJson(Map<String, dynamic> json) =
      _$ElectricalDeviceOutImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'room_id')
  String get roomId;
  @override
  ElectricalDeviceType get type;
  @override
  String? get variant;
  @override
  @JsonKey(name: 'wall_index')
  int get wallIndex;
  @override
  double get x;
  @override
  double get y;
  @override
  int get count;

  /// Create a copy of ElectricalDeviceOut
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ElectricalDeviceOutImplCopyWith<_$ElectricalDeviceOutImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ElectricalDeviceCreate _$ElectricalDeviceCreateFromJson(
  Map<String, dynamic> json,
) {
  return _ElectricalDeviceCreate.fromJson(json);
}

/// @nodoc
mixin _$ElectricalDeviceCreate {
  ElectricalDeviceType get type => throw _privateConstructorUsedError;
  String? get variant => throw _privateConstructorUsedError;
  @JsonKey(name: 'wall_index')
  int get wallIndex => throw _privateConstructorUsedError;
  double get x => throw _privateConstructorUsedError;
  double get y => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;

  /// Serializes this ElectricalDeviceCreate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ElectricalDeviceCreate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ElectricalDeviceCreateCopyWith<ElectricalDeviceCreate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ElectricalDeviceCreateCopyWith<$Res> {
  factory $ElectricalDeviceCreateCopyWith(
    ElectricalDeviceCreate value,
    $Res Function(ElectricalDeviceCreate) then,
  ) = _$ElectricalDeviceCreateCopyWithImpl<$Res, ElectricalDeviceCreate>;
  @useResult
  $Res call({
    ElectricalDeviceType type,
    String? variant,
    @JsonKey(name: 'wall_index') int wallIndex,
    double x,
    double y,
    int count,
  });
}

/// @nodoc
class _$ElectricalDeviceCreateCopyWithImpl<
  $Res,
  $Val extends ElectricalDeviceCreate
>
    implements $ElectricalDeviceCreateCopyWith<$Res> {
  _$ElectricalDeviceCreateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ElectricalDeviceCreate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? variant = freezed,
    Object? wallIndex = null,
    Object? x = null,
    Object? y = null,
    Object? count = null,
  }) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as ElectricalDeviceType,
            variant: freezed == variant
                ? _value.variant
                : variant // ignore: cast_nullable_to_non_nullable
                      as String?,
            wallIndex: null == wallIndex
                ? _value.wallIndex
                : wallIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            x: null == x
                ? _value.x
                : x // ignore: cast_nullable_to_non_nullable
                      as double,
            y: null == y
                ? _value.y
                : y // ignore: cast_nullable_to_non_nullable
                      as double,
            count: null == count
                ? _value.count
                : count // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ElectricalDeviceCreateImplCopyWith<$Res>
    implements $ElectricalDeviceCreateCopyWith<$Res> {
  factory _$$ElectricalDeviceCreateImplCopyWith(
    _$ElectricalDeviceCreateImpl value,
    $Res Function(_$ElectricalDeviceCreateImpl) then,
  ) = __$$ElectricalDeviceCreateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    ElectricalDeviceType type,
    String? variant,
    @JsonKey(name: 'wall_index') int wallIndex,
    double x,
    double y,
    int count,
  });
}

/// @nodoc
class __$$ElectricalDeviceCreateImplCopyWithImpl<$Res>
    extends
        _$ElectricalDeviceCreateCopyWithImpl<$Res, _$ElectricalDeviceCreateImpl>
    implements _$$ElectricalDeviceCreateImplCopyWith<$Res> {
  __$$ElectricalDeviceCreateImplCopyWithImpl(
    _$ElectricalDeviceCreateImpl _value,
    $Res Function(_$ElectricalDeviceCreateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ElectricalDeviceCreate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? variant = freezed,
    Object? wallIndex = null,
    Object? x = null,
    Object? y = null,
    Object? count = null,
  }) {
    return _then(
      _$ElectricalDeviceCreateImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as ElectricalDeviceType,
        variant: freezed == variant
            ? _value.variant
            : variant // ignore: cast_nullable_to_non_nullable
                  as String?,
        wallIndex: null == wallIndex
            ? _value.wallIndex
            : wallIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        x: null == x
            ? _value.x
            : x // ignore: cast_nullable_to_non_nullable
                  as double,
        y: null == y
            ? _value.y
            : y // ignore: cast_nullable_to_non_nullable
                  as double,
        count: null == count
            ? _value.count
            : count // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ElectricalDeviceCreateImpl implements _ElectricalDeviceCreate {
  const _$ElectricalDeviceCreateImpl({
    required this.type,
    this.variant,
    @JsonKey(name: 'wall_index') required this.wallIndex,
    required this.x,
    required this.y,
    this.count = 1,
  });

  factory _$ElectricalDeviceCreateImpl.fromJson(Map<String, dynamic> json) =>
      _$$ElectricalDeviceCreateImplFromJson(json);

  @override
  final ElectricalDeviceType type;
  @override
  final String? variant;
  @override
  @JsonKey(name: 'wall_index')
  final int wallIndex;
  @override
  final double x;
  @override
  final double y;
  @override
  @JsonKey()
  final int count;

  @override
  String toString() {
    return 'ElectricalDeviceCreate(type: $type, variant: $variant, wallIndex: $wallIndex, x: $x, y: $y, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ElectricalDeviceCreateImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.variant, variant) || other.variant == variant) &&
            (identical(other.wallIndex, wallIndex) ||
                other.wallIndex == wallIndex) &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, type, variant, wallIndex, x, y, count);

  /// Create a copy of ElectricalDeviceCreate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ElectricalDeviceCreateImplCopyWith<_$ElectricalDeviceCreateImpl>
  get copyWith =>
      __$$ElectricalDeviceCreateImplCopyWithImpl<_$ElectricalDeviceCreateImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ElectricalDeviceCreateImplToJson(this);
  }
}

abstract class _ElectricalDeviceCreate implements ElectricalDeviceCreate {
  const factory _ElectricalDeviceCreate({
    required final ElectricalDeviceType type,
    final String? variant,
    @JsonKey(name: 'wall_index') required final int wallIndex,
    required final double x,
    required final double y,
    final int count,
  }) = _$ElectricalDeviceCreateImpl;

  factory _ElectricalDeviceCreate.fromJson(Map<String, dynamic> json) =
      _$ElectricalDeviceCreateImpl.fromJson;

  @override
  ElectricalDeviceType get type;
  @override
  String? get variant;
  @override
  @JsonKey(name: 'wall_index')
  int get wallIndex;
  @override
  double get x;
  @override
  double get y;
  @override
  int get count;

  /// Create a copy of ElectricalDeviceCreate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ElectricalDeviceCreateImplCopyWith<_$ElectricalDeviceCreateImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ElectricalPlan _$ElectricalPlanFromJson(Map<String, dynamic> json) {
  return _ElectricalPlan.fromJson(json);
}

/// @nodoc
mixin _$ElectricalPlan {
  @JsonKey(name: 'room_id')
  String get roomId => throw _privateConstructorUsedError;
  List<ElectricalDeviceOut> get devices => throw _privateConstructorUsedError;
  @JsonKey(name: 'wiring_meters')
  double? get wiringMeters => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this ElectricalPlan to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ElectricalPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ElectricalPlanCopyWith<ElectricalPlan> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ElectricalPlanCopyWith<$Res> {
  factory $ElectricalPlanCopyWith(
    ElectricalPlan value,
    $Res Function(ElectricalPlan) then,
  ) = _$ElectricalPlanCopyWithImpl<$Res, ElectricalPlan>;
  @useResult
  $Res call({
    @JsonKey(name: 'room_id') String roomId,
    List<ElectricalDeviceOut> devices,
    @JsonKey(name: 'wiring_meters') double? wiringMeters,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });
}

/// @nodoc
class _$ElectricalPlanCopyWithImpl<$Res, $Val extends ElectricalPlan>
    implements $ElectricalPlanCopyWith<$Res> {
  _$ElectricalPlanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ElectricalPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roomId = null,
    Object? devices = null,
    Object? wiringMeters = freezed,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            roomId: null == roomId
                ? _value.roomId
                : roomId // ignore: cast_nullable_to_non_nullable
                      as String,
            devices: null == devices
                ? _value.devices
                : devices // ignore: cast_nullable_to_non_nullable
                      as List<ElectricalDeviceOut>,
            wiringMeters: freezed == wiringMeters
                ? _value.wiringMeters
                : wiringMeters // ignore: cast_nullable_to_non_nullable
                      as double?,
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
abstract class _$$ElectricalPlanImplCopyWith<$Res>
    implements $ElectricalPlanCopyWith<$Res> {
  factory _$$ElectricalPlanImplCopyWith(
    _$ElectricalPlanImpl value,
    $Res Function(_$ElectricalPlanImpl) then,
  ) = __$$ElectricalPlanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'room_id') String roomId,
    List<ElectricalDeviceOut> devices,
    @JsonKey(name: 'wiring_meters') double? wiringMeters,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });
}

/// @nodoc
class __$$ElectricalPlanImplCopyWithImpl<$Res>
    extends _$ElectricalPlanCopyWithImpl<$Res, _$ElectricalPlanImpl>
    implements _$$ElectricalPlanImplCopyWith<$Res> {
  __$$ElectricalPlanImplCopyWithImpl(
    _$ElectricalPlanImpl _value,
    $Res Function(_$ElectricalPlanImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ElectricalPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roomId = null,
    Object? devices = null,
    Object? wiringMeters = freezed,
    Object? updatedAt = null,
  }) {
    return _then(
      _$ElectricalPlanImpl(
        roomId: null == roomId
            ? _value.roomId
            : roomId // ignore: cast_nullable_to_non_nullable
                  as String,
        devices: null == devices
            ? _value._devices
            : devices // ignore: cast_nullable_to_non_nullable
                  as List<ElectricalDeviceOut>,
        wiringMeters: freezed == wiringMeters
            ? _value.wiringMeters
            : wiringMeters // ignore: cast_nullable_to_non_nullable
                  as double?,
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
class _$ElectricalPlanImpl implements _ElectricalPlan {
  const _$ElectricalPlanImpl({
    @JsonKey(name: 'room_id') required this.roomId,
    final List<ElectricalDeviceOut> devices = const <ElectricalDeviceOut>[],
    @JsonKey(name: 'wiring_meters') this.wiringMeters,
    @JsonKey(name: 'updated_at') required this.updatedAt,
  }) : _devices = devices;

  factory _$ElectricalPlanImpl.fromJson(Map<String, dynamic> json) =>
      _$$ElectricalPlanImplFromJson(json);

  @override
  @JsonKey(name: 'room_id')
  final String roomId;
  final List<ElectricalDeviceOut> _devices;
  @override
  @JsonKey()
  List<ElectricalDeviceOut> get devices {
    if (_devices is EqualUnmodifiableListView) return _devices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_devices);
  }

  @override
  @JsonKey(name: 'wiring_meters')
  final double? wiringMeters;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @override
  String toString() {
    return 'ElectricalPlan(roomId: $roomId, devices: $devices, wiringMeters: $wiringMeters, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ElectricalPlanImpl &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            const DeepCollectionEquality().equals(other._devices, _devices) &&
            (identical(other.wiringMeters, wiringMeters) ||
                other.wiringMeters == wiringMeters) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    roomId,
    const DeepCollectionEquality().hash(_devices),
    wiringMeters,
    updatedAt,
  );

  /// Create a copy of ElectricalPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ElectricalPlanImplCopyWith<_$ElectricalPlanImpl> get copyWith =>
      __$$ElectricalPlanImplCopyWithImpl<_$ElectricalPlanImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ElectricalPlanImplToJson(this);
  }
}

abstract class _ElectricalPlan implements ElectricalPlan {
  const factory _ElectricalPlan({
    @JsonKey(name: 'room_id') required final String roomId,
    final List<ElectricalDeviceOut> devices,
    @JsonKey(name: 'wiring_meters') final double? wiringMeters,
    @JsonKey(name: 'updated_at') required final DateTime updatedAt,
  }) = _$ElectricalPlanImpl;

  factory _ElectricalPlan.fromJson(Map<String, dynamic> json) =
      _$ElectricalPlanImpl.fromJson;

  @override
  @JsonKey(name: 'room_id')
  String get roomId;
  @override
  List<ElectricalDeviceOut> get devices;
  @override
  @JsonKey(name: 'wiring_meters')
  double? get wiringMeters;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;

  /// Create a copy of ElectricalPlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ElectricalPlanImplCopyWith<_$ElectricalPlanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
