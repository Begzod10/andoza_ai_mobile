// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RoomDimensions _$RoomDimensionsFromJson(Map<String, dynamic> json) {
  return _RoomDimensions.fromJson(json);
}

/// @nodoc
mixin _$RoomDimensions {
  double get width => throw _privateConstructorUsedError;
  double get height => throw _privateConstructorUsedError;
  double get length => throw _privateConstructorUsedError;

  /// Serializes this RoomDimensions to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RoomDimensions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoomDimensionsCopyWith<RoomDimensions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomDimensionsCopyWith<$Res> {
  factory $RoomDimensionsCopyWith(
    RoomDimensions value,
    $Res Function(RoomDimensions) then,
  ) = _$RoomDimensionsCopyWithImpl<$Res, RoomDimensions>;
  @useResult
  $Res call({double width, double height, double length});
}

/// @nodoc
class _$RoomDimensionsCopyWithImpl<$Res, $Val extends RoomDimensions>
    implements $RoomDimensionsCopyWith<$Res> {
  _$RoomDimensionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RoomDimensions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? width = null,
    Object? height = null,
    Object? length = null,
  }) {
    return _then(
      _value.copyWith(
            width: null == width
                ? _value.width
                : width // ignore: cast_nullable_to_non_nullable
                      as double,
            height: null == height
                ? _value.height
                : height // ignore: cast_nullable_to_non_nullable
                      as double,
            length: null == length
                ? _value.length
                : length // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RoomDimensionsImplCopyWith<$Res>
    implements $RoomDimensionsCopyWith<$Res> {
  factory _$$RoomDimensionsImplCopyWith(
    _$RoomDimensionsImpl value,
    $Res Function(_$RoomDimensionsImpl) then,
  ) = __$$RoomDimensionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double width, double height, double length});
}

/// @nodoc
class __$$RoomDimensionsImplCopyWithImpl<$Res>
    extends _$RoomDimensionsCopyWithImpl<$Res, _$RoomDimensionsImpl>
    implements _$$RoomDimensionsImplCopyWith<$Res> {
  __$$RoomDimensionsImplCopyWithImpl(
    _$RoomDimensionsImpl _value,
    $Res Function(_$RoomDimensionsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RoomDimensions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? width = null,
    Object? height = null,
    Object? length = null,
  }) {
    return _then(
      _$RoomDimensionsImpl(
        width: null == width
            ? _value.width
            : width // ignore: cast_nullable_to_non_nullable
                  as double,
        height: null == height
            ? _value.height
            : height // ignore: cast_nullable_to_non_nullable
                  as double,
        length: null == length
            ? _value.length
            : length // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RoomDimensionsImpl implements _RoomDimensions {
  const _$RoomDimensionsImpl({
    required this.width,
    required this.height,
    required this.length,
  });

  factory _$RoomDimensionsImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoomDimensionsImplFromJson(json);

  @override
  final double width;
  @override
  final double height;
  @override
  final double length;

  @override
  String toString() {
    return 'RoomDimensions(width: $width, height: $height, length: $length)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomDimensionsImpl &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.length, length) || other.length == length));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, width, height, length);

  /// Create a copy of RoomDimensions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomDimensionsImplCopyWith<_$RoomDimensionsImpl> get copyWith =>
      __$$RoomDimensionsImplCopyWithImpl<_$RoomDimensionsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RoomDimensionsImplToJson(this);
  }
}

abstract class _RoomDimensions implements RoomDimensions {
  const factory _RoomDimensions({
    required final double width,
    required final double height,
    required final double length,
  }) = _$RoomDimensionsImpl;

  factory _RoomDimensions.fromJson(Map<String, dynamic> json) =
      _$RoomDimensionsImpl.fromJson;

  @override
  double get width;
  @override
  double get height;
  @override
  double get length;

  /// Create a copy of RoomDimensions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoomDimensionsImplCopyWith<_$RoomDimensionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WallMeasurements _$WallMeasurementsFromJson(Map<String, dynamic> json) {
  return _WallMeasurements.fromJson(json);
}

/// @nodoc
mixin _$WallMeasurements {
  double get height => throw _privateConstructorUsedError;
  double get length => throw _privateConstructorUsedError;

  /// Serializes this WallMeasurements to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WallMeasurements
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WallMeasurementsCopyWith<WallMeasurements> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WallMeasurementsCopyWith<$Res> {
  factory $WallMeasurementsCopyWith(
    WallMeasurements value,
    $Res Function(WallMeasurements) then,
  ) = _$WallMeasurementsCopyWithImpl<$Res, WallMeasurements>;
  @useResult
  $Res call({double height, double length});
}

/// @nodoc
class _$WallMeasurementsCopyWithImpl<$Res, $Val extends WallMeasurements>
    implements $WallMeasurementsCopyWith<$Res> {
  _$WallMeasurementsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WallMeasurements
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? height = null, Object? length = null}) {
    return _then(
      _value.copyWith(
            height: null == height
                ? _value.height
                : height // ignore: cast_nullable_to_non_nullable
                      as double,
            length: null == length
                ? _value.length
                : length // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WallMeasurementsImplCopyWith<$Res>
    implements $WallMeasurementsCopyWith<$Res> {
  factory _$$WallMeasurementsImplCopyWith(
    _$WallMeasurementsImpl value,
    $Res Function(_$WallMeasurementsImpl) then,
  ) = __$$WallMeasurementsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double height, double length});
}

/// @nodoc
class __$$WallMeasurementsImplCopyWithImpl<$Res>
    extends _$WallMeasurementsCopyWithImpl<$Res, _$WallMeasurementsImpl>
    implements _$$WallMeasurementsImplCopyWith<$Res> {
  __$$WallMeasurementsImplCopyWithImpl(
    _$WallMeasurementsImpl _value,
    $Res Function(_$WallMeasurementsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WallMeasurements
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? height = null, Object? length = null}) {
    return _then(
      _$WallMeasurementsImpl(
        height: null == height
            ? _value.height
            : height // ignore: cast_nullable_to_non_nullable
                  as double,
        length: null == length
            ? _value.length
            : length // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WallMeasurementsImpl implements _WallMeasurements {
  const _$WallMeasurementsImpl({required this.height, required this.length});

  factory _$WallMeasurementsImpl.fromJson(Map<String, dynamic> json) =>
      _$$WallMeasurementsImplFromJson(json);

  @override
  final double height;
  @override
  final double length;

  @override
  String toString() {
    return 'WallMeasurements(height: $height, length: $length)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WallMeasurementsImpl &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.length, length) || other.length == length));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, height, length);

  /// Create a copy of WallMeasurements
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WallMeasurementsImplCopyWith<_$WallMeasurementsImpl> get copyWith =>
      __$$WallMeasurementsImplCopyWithImpl<_$WallMeasurementsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$WallMeasurementsImplToJson(this);
  }
}

abstract class _WallMeasurements implements WallMeasurements {
  const factory _WallMeasurements({
    required final double height,
    required final double length,
  }) = _$WallMeasurementsImpl;

  factory _WallMeasurements.fromJson(Map<String, dynamic> json) =
      _$WallMeasurementsImpl.fromJson;

  @override
  double get height;
  @override
  double get length;

  /// Create a copy of WallMeasurements
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WallMeasurementsImplCopyWith<_$WallMeasurementsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Wall _$WallFromJson(Map<String, dynamic> json) {
  return _Wall.fromJson(json);
}

/// @nodoc
mixin _$Wall {
  String get id => throw _privateConstructorUsedError;
  WallType get type => throw _privateConstructorUsedError;
  WallMeasurements get measurements => throw _privateConstructorUsedError;
  String? get texture => throw _privateConstructorUsedError;

  /// Serializes this Wall to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Wall
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WallCopyWith<Wall> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WallCopyWith<$Res> {
  factory $WallCopyWith(Wall value, $Res Function(Wall) then) =
      _$WallCopyWithImpl<$Res, Wall>;
  @useResult
  $Res call({
    String id,
    WallType type,
    WallMeasurements measurements,
    String? texture,
  });

  $WallMeasurementsCopyWith<$Res> get measurements;
}

/// @nodoc
class _$WallCopyWithImpl<$Res, $Val extends Wall>
    implements $WallCopyWith<$Res> {
  _$WallCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Wall
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? measurements = null,
    Object? texture = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as WallType,
            measurements: null == measurements
                ? _value.measurements
                : measurements // ignore: cast_nullable_to_non_nullable
                      as WallMeasurements,
            texture: freezed == texture
                ? _value.texture
                : texture // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of Wall
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WallMeasurementsCopyWith<$Res> get measurements {
    return $WallMeasurementsCopyWith<$Res>(_value.measurements, (value) {
      return _then(_value.copyWith(measurements: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WallImplCopyWith<$Res> implements $WallCopyWith<$Res> {
  factory _$$WallImplCopyWith(
    _$WallImpl value,
    $Res Function(_$WallImpl) then,
  ) = __$$WallImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    WallType type,
    WallMeasurements measurements,
    String? texture,
  });

  @override
  $WallMeasurementsCopyWith<$Res> get measurements;
}

/// @nodoc
class __$$WallImplCopyWithImpl<$Res>
    extends _$WallCopyWithImpl<$Res, _$WallImpl>
    implements _$$WallImplCopyWith<$Res> {
  __$$WallImplCopyWithImpl(_$WallImpl _value, $Res Function(_$WallImpl) _then)
    : super(_value, _then);

  /// Create a copy of Wall
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? measurements = null,
    Object? texture = freezed,
  }) {
    return _then(
      _$WallImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as WallType,
        measurements: null == measurements
            ? _value.measurements
            : measurements // ignore: cast_nullable_to_non_nullable
                  as WallMeasurements,
        texture: freezed == texture
            ? _value.texture
            : texture // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WallImpl implements _Wall {
  const _$WallImpl({
    required this.id,
    required this.type,
    required this.measurements,
    this.texture,
  });

  factory _$WallImpl.fromJson(Map<String, dynamic> json) =>
      _$$WallImplFromJson(json);

  @override
  final String id;
  @override
  final WallType type;
  @override
  final WallMeasurements measurements;
  @override
  final String? texture;

  @override
  String toString() {
    return 'Wall(id: $id, type: $type, measurements: $measurements, texture: $texture)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WallImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.measurements, measurements) ||
                other.measurements == measurements) &&
            (identical(other.texture, texture) || other.texture == texture));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, type, measurements, texture);

  /// Create a copy of Wall
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WallImplCopyWith<_$WallImpl> get copyWith =>
      __$$WallImplCopyWithImpl<_$WallImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WallImplToJson(this);
  }
}

abstract class _Wall implements Wall {
  const factory _Wall({
    required final String id,
    required final WallType type,
    required final WallMeasurements measurements,
    final String? texture,
  }) = _$WallImpl;

  factory _Wall.fromJson(Map<String, dynamic> json) = _$WallImpl.fromJson;

  @override
  String get id;
  @override
  WallType get type;
  @override
  WallMeasurements get measurements;
  @override
  String? get texture;

  /// Create a copy of Wall
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WallImplCopyWith<_$WallImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Door _$DoorFromJson(Map<String, dynamic> json) {
  return _Door.fromJson(json);
}

/// @nodoc
mixin _$Door {
  String get id => throw _privateConstructorUsedError;
  String get wallId => throw _privateConstructorUsedError;
  double get position => throw _privateConstructorUsedError;
  double get width => throw _privateConstructorUsedError;
  double get height => throw _privateConstructorUsedError;
  OpeningType get type => throw _privateConstructorUsedError;

  /// Serializes this Door to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Door
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DoorCopyWith<Door> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DoorCopyWith<$Res> {
  factory $DoorCopyWith(Door value, $Res Function(Door) then) =
      _$DoorCopyWithImpl<$Res, Door>;
  @useResult
  $Res call({
    String id,
    String wallId,
    double position,
    double width,
    double height,
    OpeningType type,
  });
}

/// @nodoc
class _$DoorCopyWithImpl<$Res, $Val extends Door>
    implements $DoorCopyWith<$Res> {
  _$DoorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Door
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? wallId = null,
    Object? position = null,
    Object? width = null,
    Object? height = null,
    Object? type = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            wallId: null == wallId
                ? _value.wallId
                : wallId // ignore: cast_nullable_to_non_nullable
                      as String,
            position: null == position
                ? _value.position
                : position // ignore: cast_nullable_to_non_nullable
                      as double,
            width: null == width
                ? _value.width
                : width // ignore: cast_nullable_to_non_nullable
                      as double,
            height: null == height
                ? _value.height
                : height // ignore: cast_nullable_to_non_nullable
                      as double,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as OpeningType,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DoorImplCopyWith<$Res> implements $DoorCopyWith<$Res> {
  factory _$$DoorImplCopyWith(
    _$DoorImpl value,
    $Res Function(_$DoorImpl) then,
  ) = __$$DoorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String wallId,
    double position,
    double width,
    double height,
    OpeningType type,
  });
}

/// @nodoc
class __$$DoorImplCopyWithImpl<$Res>
    extends _$DoorCopyWithImpl<$Res, _$DoorImpl>
    implements _$$DoorImplCopyWith<$Res> {
  __$$DoorImplCopyWithImpl(_$DoorImpl _value, $Res Function(_$DoorImpl) _then)
    : super(_value, _then);

  /// Create a copy of Door
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? wallId = null,
    Object? position = null,
    Object? width = null,
    Object? height = null,
    Object? type = null,
  }) {
    return _then(
      _$DoorImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        wallId: null == wallId
            ? _value.wallId
            : wallId // ignore: cast_nullable_to_non_nullable
                  as String,
        position: null == position
            ? _value.position
            : position // ignore: cast_nullable_to_non_nullable
                  as double,
        width: null == width
            ? _value.width
            : width // ignore: cast_nullable_to_non_nullable
                  as double,
        height: null == height
            ? _value.height
            : height // ignore: cast_nullable_to_non_nullable
                  as double,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as OpeningType,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DoorImpl implements _Door {
  const _$DoorImpl({
    required this.id,
    required this.wallId,
    required this.position,
    required this.width,
    required this.height,
    required this.type,
  });

  factory _$DoorImpl.fromJson(Map<String, dynamic> json) =>
      _$$DoorImplFromJson(json);

  @override
  final String id;
  @override
  final String wallId;
  @override
  final double position;
  @override
  final double width;
  @override
  final double height;
  @override
  final OpeningType type;

  @override
  String toString() {
    return 'Door(id: $id, wallId: $wallId, position: $position, width: $width, height: $height, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DoorImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.wallId, wallId) || other.wallId == wallId) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, wallId, position, width, height, type);

  /// Create a copy of Door
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DoorImplCopyWith<_$DoorImpl> get copyWith =>
      __$$DoorImplCopyWithImpl<_$DoorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DoorImplToJson(this);
  }
}

abstract class _Door implements Door {
  const factory _Door({
    required final String id,
    required final String wallId,
    required final double position,
    required final double width,
    required final double height,
    required final OpeningType type,
  }) = _$DoorImpl;

  factory _Door.fromJson(Map<String, dynamic> json) = _$DoorImpl.fromJson;

  @override
  String get id;
  @override
  String get wallId;
  @override
  double get position;
  @override
  double get width;
  @override
  double get height;
  @override
  OpeningType get type;

  /// Create a copy of Door
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DoorImplCopyWith<_$DoorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Window _$WindowFromJson(Map<String, dynamic> json) {
  return _Window.fromJson(json);
}

/// @nodoc
mixin _$Window {
  String get id => throw _privateConstructorUsedError;
  String get wallId => throw _privateConstructorUsedError;
  double get position => throw _privateConstructorUsedError;
  double get width => throw _privateConstructorUsedError;
  double get height => throw _privateConstructorUsedError;
  OpeningType get type => throw _privateConstructorUsedError;

  /// Serializes this Window to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Window
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WindowCopyWith<Window> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WindowCopyWith<$Res> {
  factory $WindowCopyWith(Window value, $Res Function(Window) then) =
      _$WindowCopyWithImpl<$Res, Window>;
  @useResult
  $Res call({
    String id,
    String wallId,
    double position,
    double width,
    double height,
    OpeningType type,
  });
}

/// @nodoc
class _$WindowCopyWithImpl<$Res, $Val extends Window>
    implements $WindowCopyWith<$Res> {
  _$WindowCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Window
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? wallId = null,
    Object? position = null,
    Object? width = null,
    Object? height = null,
    Object? type = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            wallId: null == wallId
                ? _value.wallId
                : wallId // ignore: cast_nullable_to_non_nullable
                      as String,
            position: null == position
                ? _value.position
                : position // ignore: cast_nullable_to_non_nullable
                      as double,
            width: null == width
                ? _value.width
                : width // ignore: cast_nullable_to_non_nullable
                      as double,
            height: null == height
                ? _value.height
                : height // ignore: cast_nullable_to_non_nullable
                      as double,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as OpeningType,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WindowImplCopyWith<$Res> implements $WindowCopyWith<$Res> {
  factory _$$WindowImplCopyWith(
    _$WindowImpl value,
    $Res Function(_$WindowImpl) then,
  ) = __$$WindowImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String wallId,
    double position,
    double width,
    double height,
    OpeningType type,
  });
}

/// @nodoc
class __$$WindowImplCopyWithImpl<$Res>
    extends _$WindowCopyWithImpl<$Res, _$WindowImpl>
    implements _$$WindowImplCopyWith<$Res> {
  __$$WindowImplCopyWithImpl(
    _$WindowImpl _value,
    $Res Function(_$WindowImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Window
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? wallId = null,
    Object? position = null,
    Object? width = null,
    Object? height = null,
    Object? type = null,
  }) {
    return _then(
      _$WindowImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        wallId: null == wallId
            ? _value.wallId
            : wallId // ignore: cast_nullable_to_non_nullable
                  as String,
        position: null == position
            ? _value.position
            : position // ignore: cast_nullable_to_non_nullable
                  as double,
        width: null == width
            ? _value.width
            : width // ignore: cast_nullable_to_non_nullable
                  as double,
        height: null == height
            ? _value.height
            : height // ignore: cast_nullable_to_non_nullable
                  as double,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as OpeningType,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WindowImpl implements _Window {
  const _$WindowImpl({
    required this.id,
    required this.wallId,
    required this.position,
    required this.width,
    required this.height,
    required this.type,
  });

  factory _$WindowImpl.fromJson(Map<String, dynamic> json) =>
      _$$WindowImplFromJson(json);

  @override
  final String id;
  @override
  final String wallId;
  @override
  final double position;
  @override
  final double width;
  @override
  final double height;
  @override
  final OpeningType type;

  @override
  String toString() {
    return 'Window(id: $id, wallId: $wallId, position: $position, width: $width, height: $height, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WindowImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.wallId, wallId) || other.wallId == wallId) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, wallId, position, width, height, type);

  /// Create a copy of Window
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WindowImplCopyWith<_$WindowImpl> get copyWith =>
      __$$WindowImplCopyWithImpl<_$WindowImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WindowImplToJson(this);
  }
}

abstract class _Window implements Window {
  const factory _Window({
    required final String id,
    required final String wallId,
    required final double position,
    required final double width,
    required final double height,
    required final OpeningType type,
  }) = _$WindowImpl;

  factory _Window.fromJson(Map<String, dynamic> json) = _$WindowImpl.fromJson;

  @override
  String get id;
  @override
  String get wallId;
  @override
  double get position;
  @override
  double get width;
  @override
  double get height;
  @override
  OpeningType get type;

  /// Create a copy of Window
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WindowImplCopyWith<_$WindowImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Room _$RoomFromJson(Map<String, dynamic> json) {
  return _Room.fromJson(json);
}

/// @nodoc
mixin _$Room {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  RoomDimensions get dimensions => throw _privateConstructorUsedError;
  List<Wall> get walls => throw _privateConstructorUsedError;
  List<Door> get doors => throw _privateConstructorUsedError;
  List<Window> get windows => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Room to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoomCopyWith<Room> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomCopyWith<$Res> {
  factory $RoomCopyWith(Room value, $Res Function(Room) then) =
      _$RoomCopyWithImpl<$Res, Room>;
  @useResult
  $Res call({
    String id,
    String name,
    RoomDimensions dimensions,
    List<Wall> walls,
    List<Door> doors,
    List<Window> windows,
    DateTime createdAt,
  });

  $RoomDimensionsCopyWith<$Res> get dimensions;
}

/// @nodoc
class _$RoomCopyWithImpl<$Res, $Val extends Room>
    implements $RoomCopyWith<$Res> {
  _$RoomCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? dimensions = null,
    Object? walls = null,
    Object? doors = null,
    Object? windows = null,
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
            dimensions: null == dimensions
                ? _value.dimensions
                : dimensions // ignore: cast_nullable_to_non_nullable
                      as RoomDimensions,
            walls: null == walls
                ? _value.walls
                : walls // ignore: cast_nullable_to_non_nullable
                      as List<Wall>,
            doors: null == doors
                ? _value.doors
                : doors // ignore: cast_nullable_to_non_nullable
                      as List<Door>,
            windows: null == windows
                ? _value.windows
                : windows // ignore: cast_nullable_to_non_nullable
                      as List<Window>,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RoomDimensionsCopyWith<$Res> get dimensions {
    return $RoomDimensionsCopyWith<$Res>(_value.dimensions, (value) {
      return _then(_value.copyWith(dimensions: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RoomImplCopyWith<$Res> implements $RoomCopyWith<$Res> {
  factory _$$RoomImplCopyWith(
    _$RoomImpl value,
    $Res Function(_$RoomImpl) then,
  ) = __$$RoomImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    RoomDimensions dimensions,
    List<Wall> walls,
    List<Door> doors,
    List<Window> windows,
    DateTime createdAt,
  });

  @override
  $RoomDimensionsCopyWith<$Res> get dimensions;
}

/// @nodoc
class __$$RoomImplCopyWithImpl<$Res>
    extends _$RoomCopyWithImpl<$Res, _$RoomImpl>
    implements _$$RoomImplCopyWith<$Res> {
  __$$RoomImplCopyWithImpl(_$RoomImpl _value, $Res Function(_$RoomImpl) _then)
    : super(_value, _then);

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? dimensions = null,
    Object? walls = null,
    Object? doors = null,
    Object? windows = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$RoomImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        dimensions: null == dimensions
            ? _value.dimensions
            : dimensions // ignore: cast_nullable_to_non_nullable
                  as RoomDimensions,
        walls: null == walls
            ? _value._walls
            : walls // ignore: cast_nullable_to_non_nullable
                  as List<Wall>,
        doors: null == doors
            ? _value._doors
            : doors // ignore: cast_nullable_to_non_nullable
                  as List<Door>,
        windows: null == windows
            ? _value._windows
            : windows // ignore: cast_nullable_to_non_nullable
                  as List<Window>,
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
class _$RoomImpl implements _Room {
  const _$RoomImpl({
    required this.id,
    required this.name,
    required this.dimensions,
    final List<Wall> walls = const <Wall>[],
    final List<Door> doors = const <Door>[],
    final List<Window> windows = const <Window>[],
    required this.createdAt,
  }) : _walls = walls,
       _doors = doors,
       _windows = windows;

  factory _$RoomImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoomImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final RoomDimensions dimensions;
  final List<Wall> _walls;
  @override
  @JsonKey()
  List<Wall> get walls {
    if (_walls is EqualUnmodifiableListView) return _walls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_walls);
  }

  final List<Door> _doors;
  @override
  @JsonKey()
  List<Door> get doors {
    if (_doors is EqualUnmodifiableListView) return _doors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_doors);
  }

  final List<Window> _windows;
  @override
  @JsonKey()
  List<Window> get windows {
    if (_windows is EqualUnmodifiableListView) return _windows;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_windows);
  }

  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'Room(id: $id, name: $name, dimensions: $dimensions, walls: $walls, doors: $doors, windows: $windows, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.dimensions, dimensions) ||
                other.dimensions == dimensions) &&
            const DeepCollectionEquality().equals(other._walls, _walls) &&
            const DeepCollectionEquality().equals(other._doors, _doors) &&
            const DeepCollectionEquality().equals(other._windows, _windows) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    dimensions,
    const DeepCollectionEquality().hash(_walls),
    const DeepCollectionEquality().hash(_doors),
    const DeepCollectionEquality().hash(_windows),
    createdAt,
  );

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomImplCopyWith<_$RoomImpl> get copyWith =>
      __$$RoomImplCopyWithImpl<_$RoomImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoomImplToJson(this);
  }
}

abstract class _Room implements Room {
  const factory _Room({
    required final String id,
    required final String name,
    required final RoomDimensions dimensions,
    final List<Wall> walls,
    final List<Door> doors,
    final List<Window> windows,
    required final DateTime createdAt,
  }) = _$RoomImpl;

  factory _Room.fromJson(Map<String, dynamic> json) = _$RoomImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  RoomDimensions get dimensions;
  @override
  List<Wall> get walls;
  @override
  List<Door> get doors;
  @override
  List<Window> get windows;
  @override
  DateTime get createdAt;

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoomImplCopyWith<_$RoomImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
