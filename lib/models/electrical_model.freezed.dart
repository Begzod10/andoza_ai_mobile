// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'electrical_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ElectricalDevice _$ElectricalDeviceFromJson(Map<String, dynamic> json) {
  return _ElectricalDevice.fromJson(json);
}

/// @nodoc
mixin _$ElectricalDevice {
  String get id => throw _privateConstructorUsedError;
  DeviceType get type => throw _privateConstructorUsedError;
  @OffsetConverter()
  Offset get position => throw _privateConstructorUsedError;
  String get wallId => throw _privateConstructorUsedError;
  double? get amps => throw _privateConstructorUsedError;
  double get heightCm => throw _privateConstructorUsedError;
  int get gangCount => throw _privateConstructorUsedError;
  String? get colorOption => throw _privateConstructorUsedError;
  ColorTemp? get colorTemp => throw _privateConstructorUsedError;

  /// Serializes this ElectricalDevice to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ElectricalDevice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ElectricalDeviceCopyWith<ElectricalDevice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ElectricalDeviceCopyWith<$Res> {
  factory $ElectricalDeviceCopyWith(
    ElectricalDevice value,
    $Res Function(ElectricalDevice) then,
  ) = _$ElectricalDeviceCopyWithImpl<$Res, ElectricalDevice>;
  @useResult
  $Res call({
    String id,
    DeviceType type,
    @OffsetConverter() Offset position,
    String wallId,
    double? amps,
    double heightCm,
    int gangCount,
    String? colorOption,
    ColorTemp? colorTemp,
  });
}

/// @nodoc
class _$ElectricalDeviceCopyWithImpl<$Res, $Val extends ElectricalDevice>
    implements $ElectricalDeviceCopyWith<$Res> {
  _$ElectricalDeviceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ElectricalDevice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? position = null,
    Object? wallId = null,
    Object? amps = freezed,
    Object? heightCm = null,
    Object? gangCount = null,
    Object? colorOption = freezed,
    Object? colorTemp = freezed,
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
                      as DeviceType,
            position: null == position
                ? _value.position
                : position // ignore: cast_nullable_to_non_nullable
                      as Offset,
            wallId: null == wallId
                ? _value.wallId
                : wallId // ignore: cast_nullable_to_non_nullable
                      as String,
            amps: freezed == amps
                ? _value.amps
                : amps // ignore: cast_nullable_to_non_nullable
                      as double?,
            heightCm: null == heightCm
                ? _value.heightCm
                : heightCm // ignore: cast_nullable_to_non_nullable
                      as double,
            gangCount: null == gangCount
                ? _value.gangCount
                : gangCount // ignore: cast_nullable_to_non_nullable
                      as int,
            colorOption: freezed == colorOption
                ? _value.colorOption
                : colorOption // ignore: cast_nullable_to_non_nullable
                      as String?,
            colorTemp: freezed == colorTemp
                ? _value.colorTemp
                : colorTemp // ignore: cast_nullable_to_non_nullable
                      as ColorTemp?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ElectricalDeviceImplCopyWith<$Res>
    implements $ElectricalDeviceCopyWith<$Res> {
  factory _$$ElectricalDeviceImplCopyWith(
    _$ElectricalDeviceImpl value,
    $Res Function(_$ElectricalDeviceImpl) then,
  ) = __$$ElectricalDeviceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    DeviceType type,
    @OffsetConverter() Offset position,
    String wallId,
    double? amps,
    double heightCm,
    int gangCount,
    String? colorOption,
    ColorTemp? colorTemp,
  });
}

/// @nodoc
class __$$ElectricalDeviceImplCopyWithImpl<$Res>
    extends _$ElectricalDeviceCopyWithImpl<$Res, _$ElectricalDeviceImpl>
    implements _$$ElectricalDeviceImplCopyWith<$Res> {
  __$$ElectricalDeviceImplCopyWithImpl(
    _$ElectricalDeviceImpl _value,
    $Res Function(_$ElectricalDeviceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ElectricalDevice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? position = null,
    Object? wallId = null,
    Object? amps = freezed,
    Object? heightCm = null,
    Object? gangCount = null,
    Object? colorOption = freezed,
    Object? colorTemp = freezed,
  }) {
    return _then(
      _$ElectricalDeviceImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as DeviceType,
        position: null == position
            ? _value.position
            : position // ignore: cast_nullable_to_non_nullable
                  as Offset,
        wallId: null == wallId
            ? _value.wallId
            : wallId // ignore: cast_nullable_to_non_nullable
                  as String,
        amps: freezed == amps
            ? _value.amps
            : amps // ignore: cast_nullable_to_non_nullable
                  as double?,
        heightCm: null == heightCm
            ? _value.heightCm
            : heightCm // ignore: cast_nullable_to_non_nullable
                  as double,
        gangCount: null == gangCount
            ? _value.gangCount
            : gangCount // ignore: cast_nullable_to_non_nullable
                  as int,
        colorOption: freezed == colorOption
            ? _value.colorOption
            : colorOption // ignore: cast_nullable_to_non_nullable
                  as String?,
        colorTemp: freezed == colorTemp
            ? _value.colorTemp
            : colorTemp // ignore: cast_nullable_to_non_nullable
                  as ColorTemp?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ElectricalDeviceImpl implements _ElectricalDevice {
  const _$ElectricalDeviceImpl({
    required this.id,
    required this.type,
    @OffsetConverter() required this.position,
    required this.wallId,
    this.amps,
    this.heightCm = 100,
    this.gangCount = 1,
    this.colorOption,
    this.colorTemp,
  });

  factory _$ElectricalDeviceImpl.fromJson(Map<String, dynamic> json) =>
      _$$ElectricalDeviceImplFromJson(json);

  @override
  final String id;
  @override
  final DeviceType type;
  @override
  @OffsetConverter()
  final Offset position;
  @override
  final String wallId;
  @override
  final double? amps;
  @override
  @JsonKey()
  final double heightCm;
  @override
  @JsonKey()
  final int gangCount;
  @override
  final String? colorOption;
  @override
  final ColorTemp? colorTemp;

  @override
  String toString() {
    return 'ElectricalDevice(id: $id, type: $type, position: $position, wallId: $wallId, amps: $amps, heightCm: $heightCm, gangCount: $gangCount, colorOption: $colorOption, colorTemp: $colorTemp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ElectricalDeviceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.wallId, wallId) || other.wallId == wallId) &&
            (identical(other.amps, amps) || other.amps == amps) &&
            (identical(other.heightCm, heightCm) ||
                other.heightCm == heightCm) &&
            (identical(other.gangCount, gangCount) ||
                other.gangCount == gangCount) &&
            (identical(other.colorOption, colorOption) ||
                other.colorOption == colorOption) &&
            (identical(other.colorTemp, colorTemp) ||
                other.colorTemp == colorTemp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    position,
    wallId,
    amps,
    heightCm,
    gangCount,
    colorOption,
    colorTemp,
  );

  /// Create a copy of ElectricalDevice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ElectricalDeviceImplCopyWith<_$ElectricalDeviceImpl> get copyWith =>
      __$$ElectricalDeviceImplCopyWithImpl<_$ElectricalDeviceImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ElectricalDeviceImplToJson(this);
  }
}

abstract class _ElectricalDevice implements ElectricalDevice {
  const factory _ElectricalDevice({
    required final String id,
    required final DeviceType type,
    @OffsetConverter() required final Offset position,
    required final String wallId,
    final double? amps,
    final double heightCm,
    final int gangCount,
    final String? colorOption,
    final ColorTemp? colorTemp,
  }) = _$ElectricalDeviceImpl;

  factory _ElectricalDevice.fromJson(Map<String, dynamic> json) =
      _$ElectricalDeviceImpl.fromJson;

  @override
  String get id;
  @override
  DeviceType get type;
  @override
  @OffsetConverter()
  Offset get position;
  @override
  String get wallId;
  @override
  double? get amps;
  @override
  double get heightCm;
  @override
  int get gangCount;
  @override
  String? get colorOption;
  @override
  ColorTemp? get colorTemp;

  /// Create a copy of ElectricalDevice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ElectricalDeviceImplCopyWith<_$ElectricalDeviceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WireSegment _$WireSegmentFromJson(Map<String, dynamic> json) {
  return _WireSegment.fromJson(json);
}

/// @nodoc
mixin _$WireSegment {
  String get id => throw _privateConstructorUsedError;
  @OffsetConverter()
  Offset get from => throw _privateConstructorUsedError;
  @OffsetConverter()
  Offset get to => throw _privateConstructorUsedError;
  int get gauge => throw _privateConstructorUsedError;

  /// Serializes this WireSegment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WireSegment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WireSegmentCopyWith<WireSegment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WireSegmentCopyWith<$Res> {
  factory $WireSegmentCopyWith(
    WireSegment value,
    $Res Function(WireSegment) then,
  ) = _$WireSegmentCopyWithImpl<$Res, WireSegment>;
  @useResult
  $Res call({
    String id,
    @OffsetConverter() Offset from,
    @OffsetConverter() Offset to,
    int gauge,
  });
}

/// @nodoc
class _$WireSegmentCopyWithImpl<$Res, $Val extends WireSegment>
    implements $WireSegmentCopyWith<$Res> {
  _$WireSegmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WireSegment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? from = null,
    Object? to = null,
    Object? gauge = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            from: null == from
                ? _value.from
                : from // ignore: cast_nullable_to_non_nullable
                      as Offset,
            to: null == to
                ? _value.to
                : to // ignore: cast_nullable_to_non_nullable
                      as Offset,
            gauge: null == gauge
                ? _value.gauge
                : gauge // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WireSegmentImplCopyWith<$Res>
    implements $WireSegmentCopyWith<$Res> {
  factory _$$WireSegmentImplCopyWith(
    _$WireSegmentImpl value,
    $Res Function(_$WireSegmentImpl) then,
  ) = __$$WireSegmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @OffsetConverter() Offset from,
    @OffsetConverter() Offset to,
    int gauge,
  });
}

/// @nodoc
class __$$WireSegmentImplCopyWithImpl<$Res>
    extends _$WireSegmentCopyWithImpl<$Res, _$WireSegmentImpl>
    implements _$$WireSegmentImplCopyWith<$Res> {
  __$$WireSegmentImplCopyWithImpl(
    _$WireSegmentImpl _value,
    $Res Function(_$WireSegmentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WireSegment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? from = null,
    Object? to = null,
    Object? gauge = null,
  }) {
    return _then(
      _$WireSegmentImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        from: null == from
            ? _value.from
            : from // ignore: cast_nullable_to_non_nullable
                  as Offset,
        to: null == to
            ? _value.to
            : to // ignore: cast_nullable_to_non_nullable
                  as Offset,
        gauge: null == gauge
            ? _value.gauge
            : gauge // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WireSegmentImpl implements _WireSegment {
  const _$WireSegmentImpl({
    required this.id,
    @OffsetConverter() required this.from,
    @OffsetConverter() required this.to,
    required this.gauge,
  });

  factory _$WireSegmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$WireSegmentImplFromJson(json);

  @override
  final String id;
  @override
  @OffsetConverter()
  final Offset from;
  @override
  @OffsetConverter()
  final Offset to;
  @override
  final int gauge;

  @override
  String toString() {
    return 'WireSegment(id: $id, from: $from, to: $to, gauge: $gauge)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WireSegmentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.gauge, gauge) || other.gauge == gauge));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, from, to, gauge);

  /// Create a copy of WireSegment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WireSegmentImplCopyWith<_$WireSegmentImpl> get copyWith =>
      __$$WireSegmentImplCopyWithImpl<_$WireSegmentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WireSegmentImplToJson(this);
  }
}

abstract class _WireSegment implements WireSegment {
  const factory _WireSegment({
    required final String id,
    @OffsetConverter() required final Offset from,
    @OffsetConverter() required final Offset to,
    required final int gauge,
  }) = _$WireSegmentImpl;

  factory _WireSegment.fromJson(Map<String, dynamic> json) =
      _$WireSegmentImpl.fromJson;

  @override
  String get id;
  @override
  @OffsetConverter()
  Offset get from;
  @override
  @OffsetConverter()
  Offset get to;
  @override
  int get gauge;

  /// Create a copy of WireSegment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WireSegmentImplCopyWith<_$WireSegmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PipeSegment _$PipeSegmentFromJson(Map<String, dynamic> json) {
  return _PipeSegment.fromJson(json);
}

/// @nodoc
mixin _$PipeSegment {
  String get id => throw _privateConstructorUsedError;
  @OffsetConverter()
  Offset get from => throw _privateConstructorUsedError;
  @OffsetConverter()
  Offset get to => throw _privateConstructorUsedError;
  PipeType get type => throw _privateConstructorUsedError;

  /// Serializes this PipeSegment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PipeSegment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PipeSegmentCopyWith<PipeSegment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PipeSegmentCopyWith<$Res> {
  factory $PipeSegmentCopyWith(
    PipeSegment value,
    $Res Function(PipeSegment) then,
  ) = _$PipeSegmentCopyWithImpl<$Res, PipeSegment>;
  @useResult
  $Res call({
    String id,
    @OffsetConverter() Offset from,
    @OffsetConverter() Offset to,
    PipeType type,
  });
}

/// @nodoc
class _$PipeSegmentCopyWithImpl<$Res, $Val extends PipeSegment>
    implements $PipeSegmentCopyWith<$Res> {
  _$PipeSegmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PipeSegment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? from = null,
    Object? to = null,
    Object? type = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            from: null == from
                ? _value.from
                : from // ignore: cast_nullable_to_non_nullable
                      as Offset,
            to: null == to
                ? _value.to
                : to // ignore: cast_nullable_to_non_nullable
                      as Offset,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as PipeType,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PipeSegmentImplCopyWith<$Res>
    implements $PipeSegmentCopyWith<$Res> {
  factory _$$PipeSegmentImplCopyWith(
    _$PipeSegmentImpl value,
    $Res Function(_$PipeSegmentImpl) then,
  ) = __$$PipeSegmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @OffsetConverter() Offset from,
    @OffsetConverter() Offset to,
    PipeType type,
  });
}

/// @nodoc
class __$$PipeSegmentImplCopyWithImpl<$Res>
    extends _$PipeSegmentCopyWithImpl<$Res, _$PipeSegmentImpl>
    implements _$$PipeSegmentImplCopyWith<$Res> {
  __$$PipeSegmentImplCopyWithImpl(
    _$PipeSegmentImpl _value,
    $Res Function(_$PipeSegmentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PipeSegment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? from = null,
    Object? to = null,
    Object? type = null,
  }) {
    return _then(
      _$PipeSegmentImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        from: null == from
            ? _value.from
            : from // ignore: cast_nullable_to_non_nullable
                  as Offset,
        to: null == to
            ? _value.to
            : to // ignore: cast_nullable_to_non_nullable
                  as Offset,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as PipeType,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PipeSegmentImpl implements _PipeSegment {
  const _$PipeSegmentImpl({
    required this.id,
    @OffsetConverter() required this.from,
    @OffsetConverter() required this.to,
    required this.type,
  });

  factory _$PipeSegmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$PipeSegmentImplFromJson(json);

  @override
  final String id;
  @override
  @OffsetConverter()
  final Offset from;
  @override
  @OffsetConverter()
  final Offset to;
  @override
  final PipeType type;

  @override
  String toString() {
    return 'PipeSegment(id: $id, from: $from, to: $to, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PipeSegmentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, from, to, type);

  /// Create a copy of PipeSegment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PipeSegmentImplCopyWith<_$PipeSegmentImpl> get copyWith =>
      __$$PipeSegmentImplCopyWithImpl<_$PipeSegmentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PipeSegmentImplToJson(this);
  }
}

abstract class _PipeSegment implements PipeSegment {
  const factory _PipeSegment({
    required final String id,
    @OffsetConverter() required final Offset from,
    @OffsetConverter() required final Offset to,
    required final PipeType type,
  }) = _$PipeSegmentImpl;

  factory _PipeSegment.fromJson(Map<String, dynamic> json) =
      _$PipeSegmentImpl.fromJson;

  @override
  String get id;
  @override
  @OffsetConverter()
  Offset get from;
  @override
  @OffsetConverter()
  Offset get to;
  @override
  PipeType get type;

  /// Create a copy of PipeSegment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PipeSegmentImplCopyWith<_$PipeSegmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

JunctionBox _$JunctionBoxFromJson(Map<String, dynamic> json) {
  return _JunctionBox.fromJson(json);
}

/// @nodoc
mixin _$JunctionBox {
  String get id => throw _privateConstructorUsedError;
  @OffsetConverter()
  Offset get position => throw _privateConstructorUsedError;
  int get capacity => throw _privateConstructorUsedError;
  int get connections => throw _privateConstructorUsedError;

  /// Serializes this JunctionBox to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of JunctionBox
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $JunctionBoxCopyWith<JunctionBox> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JunctionBoxCopyWith<$Res> {
  factory $JunctionBoxCopyWith(
    JunctionBox value,
    $Res Function(JunctionBox) then,
  ) = _$JunctionBoxCopyWithImpl<$Res, JunctionBox>;
  @useResult
  $Res call({
    String id,
    @OffsetConverter() Offset position,
    int capacity,
    int connections,
  });
}

/// @nodoc
class _$JunctionBoxCopyWithImpl<$Res, $Val extends JunctionBox>
    implements $JunctionBoxCopyWith<$Res> {
  _$JunctionBoxCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of JunctionBox
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? position = null,
    Object? capacity = null,
    Object? connections = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            position: null == position
                ? _value.position
                : position // ignore: cast_nullable_to_non_nullable
                      as Offset,
            capacity: null == capacity
                ? _value.capacity
                : capacity // ignore: cast_nullable_to_non_nullable
                      as int,
            connections: null == connections
                ? _value.connections
                : connections // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$JunctionBoxImplCopyWith<$Res>
    implements $JunctionBoxCopyWith<$Res> {
  factory _$$JunctionBoxImplCopyWith(
    _$JunctionBoxImpl value,
    $Res Function(_$JunctionBoxImpl) then,
  ) = __$$JunctionBoxImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @OffsetConverter() Offset position,
    int capacity,
    int connections,
  });
}

/// @nodoc
class __$$JunctionBoxImplCopyWithImpl<$Res>
    extends _$JunctionBoxCopyWithImpl<$Res, _$JunctionBoxImpl>
    implements _$$JunctionBoxImplCopyWith<$Res> {
  __$$JunctionBoxImplCopyWithImpl(
    _$JunctionBoxImpl _value,
    $Res Function(_$JunctionBoxImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of JunctionBox
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? position = null,
    Object? capacity = null,
    Object? connections = null,
  }) {
    return _then(
      _$JunctionBoxImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        position: null == position
            ? _value.position
            : position // ignore: cast_nullable_to_non_nullable
                  as Offset,
        capacity: null == capacity
            ? _value.capacity
            : capacity // ignore: cast_nullable_to_non_nullable
                  as int,
        connections: null == connections
            ? _value.connections
            : connections // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$JunctionBoxImpl implements _JunctionBox {
  const _$JunctionBoxImpl({
    required this.id,
    @OffsetConverter() required this.position,
    required this.capacity,
    required this.connections,
  });

  factory _$JunctionBoxImpl.fromJson(Map<String, dynamic> json) =>
      _$$JunctionBoxImplFromJson(json);

  @override
  final String id;
  @override
  @OffsetConverter()
  final Offset position;
  @override
  final int capacity;
  @override
  final int connections;

  @override
  String toString() {
    return 'JunctionBox(id: $id, position: $position, capacity: $capacity, connections: $connections)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JunctionBoxImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.capacity, capacity) ||
                other.capacity == capacity) &&
            (identical(other.connections, connections) ||
                other.connections == connections));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, position, capacity, connections);

  /// Create a copy of JunctionBox
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$JunctionBoxImplCopyWith<_$JunctionBoxImpl> get copyWith =>
      __$$JunctionBoxImplCopyWithImpl<_$JunctionBoxImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JunctionBoxImplToJson(this);
  }
}

abstract class _JunctionBox implements JunctionBox {
  const factory _JunctionBox({
    required final String id,
    @OffsetConverter() required final Offset position,
    required final int capacity,
    required final int connections,
  }) = _$JunctionBoxImpl;

  factory _JunctionBox.fromJson(Map<String, dynamic> json) =
      _$JunctionBoxImpl.fromJson;

  @override
  String get id;
  @override
  @OffsetConverter()
  Offset get position;
  @override
  int get capacity;
  @override
  int get connections;

  /// Create a copy of JunctionBox
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$JunctionBoxImplCopyWith<_$JunctionBoxImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ElectricalLayout _$ElectricalLayoutFromJson(Map<String, dynamic> json) {
  return _ElectricalLayout.fromJson(json);
}

/// @nodoc
mixin _$ElectricalLayout {
  String get id => throw _privateConstructorUsedError;
  String get roomId => throw _privateConstructorUsedError;
  List<ElectricalDevice> get devices => throw _privateConstructorUsedError;
  List<WireSegment> get wires => throw _privateConstructorUsedError;
  List<JunctionBox> get junctionBoxes => throw _privateConstructorUsedError;
  List<PipeSegment> get pipes => throw _privateConstructorUsedError;

  /// Serializes this ElectricalLayout to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ElectricalLayout
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ElectricalLayoutCopyWith<ElectricalLayout> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ElectricalLayoutCopyWith<$Res> {
  factory $ElectricalLayoutCopyWith(
    ElectricalLayout value,
    $Res Function(ElectricalLayout) then,
  ) = _$ElectricalLayoutCopyWithImpl<$Res, ElectricalLayout>;
  @useResult
  $Res call({
    String id,
    String roomId,
    List<ElectricalDevice> devices,
    List<WireSegment> wires,
    List<JunctionBox> junctionBoxes,
    List<PipeSegment> pipes,
  });
}

/// @nodoc
class _$ElectricalLayoutCopyWithImpl<$Res, $Val extends ElectricalLayout>
    implements $ElectricalLayoutCopyWith<$Res> {
  _$ElectricalLayoutCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ElectricalLayout
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roomId = null,
    Object? devices = null,
    Object? wires = null,
    Object? junctionBoxes = null,
    Object? pipes = null,
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
            devices: null == devices
                ? _value.devices
                : devices // ignore: cast_nullable_to_non_nullable
                      as List<ElectricalDevice>,
            wires: null == wires
                ? _value.wires
                : wires // ignore: cast_nullable_to_non_nullable
                      as List<WireSegment>,
            junctionBoxes: null == junctionBoxes
                ? _value.junctionBoxes
                : junctionBoxes // ignore: cast_nullable_to_non_nullable
                      as List<JunctionBox>,
            pipes: null == pipes
                ? _value.pipes
                : pipes // ignore: cast_nullable_to_non_nullable
                      as List<PipeSegment>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ElectricalLayoutImplCopyWith<$Res>
    implements $ElectricalLayoutCopyWith<$Res> {
  factory _$$ElectricalLayoutImplCopyWith(
    _$ElectricalLayoutImpl value,
    $Res Function(_$ElectricalLayoutImpl) then,
  ) = __$$ElectricalLayoutImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String roomId,
    List<ElectricalDevice> devices,
    List<WireSegment> wires,
    List<JunctionBox> junctionBoxes,
    List<PipeSegment> pipes,
  });
}

/// @nodoc
class __$$ElectricalLayoutImplCopyWithImpl<$Res>
    extends _$ElectricalLayoutCopyWithImpl<$Res, _$ElectricalLayoutImpl>
    implements _$$ElectricalLayoutImplCopyWith<$Res> {
  __$$ElectricalLayoutImplCopyWithImpl(
    _$ElectricalLayoutImpl _value,
    $Res Function(_$ElectricalLayoutImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ElectricalLayout
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roomId = null,
    Object? devices = null,
    Object? wires = null,
    Object? junctionBoxes = null,
    Object? pipes = null,
  }) {
    return _then(
      _$ElectricalLayoutImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        roomId: null == roomId
            ? _value.roomId
            : roomId // ignore: cast_nullable_to_non_nullable
                  as String,
        devices: null == devices
            ? _value._devices
            : devices // ignore: cast_nullable_to_non_nullable
                  as List<ElectricalDevice>,
        wires: null == wires
            ? _value._wires
            : wires // ignore: cast_nullable_to_non_nullable
                  as List<WireSegment>,
        junctionBoxes: null == junctionBoxes
            ? _value._junctionBoxes
            : junctionBoxes // ignore: cast_nullable_to_non_nullable
                  as List<JunctionBox>,
        pipes: null == pipes
            ? _value._pipes
            : pipes // ignore: cast_nullable_to_non_nullable
                  as List<PipeSegment>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ElectricalLayoutImpl implements _ElectricalLayout {
  const _$ElectricalLayoutImpl({
    required this.id,
    required this.roomId,
    final List<ElectricalDevice> devices = const <ElectricalDevice>[],
    final List<WireSegment> wires = const <WireSegment>[],
    final List<JunctionBox> junctionBoxes = const <JunctionBox>[],
    final List<PipeSegment> pipes = const <PipeSegment>[],
  }) : _devices = devices,
       _wires = wires,
       _junctionBoxes = junctionBoxes,
       _pipes = pipes;

  factory _$ElectricalLayoutImpl.fromJson(Map<String, dynamic> json) =>
      _$$ElectricalLayoutImplFromJson(json);

  @override
  final String id;
  @override
  final String roomId;
  final List<ElectricalDevice> _devices;
  @override
  @JsonKey()
  List<ElectricalDevice> get devices {
    if (_devices is EqualUnmodifiableListView) return _devices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_devices);
  }

  final List<WireSegment> _wires;
  @override
  @JsonKey()
  List<WireSegment> get wires {
    if (_wires is EqualUnmodifiableListView) return _wires;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_wires);
  }

  final List<JunctionBox> _junctionBoxes;
  @override
  @JsonKey()
  List<JunctionBox> get junctionBoxes {
    if (_junctionBoxes is EqualUnmodifiableListView) return _junctionBoxes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_junctionBoxes);
  }

  final List<PipeSegment> _pipes;
  @override
  @JsonKey()
  List<PipeSegment> get pipes {
    if (_pipes is EqualUnmodifiableListView) return _pipes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pipes);
  }

  @override
  String toString() {
    return 'ElectricalLayout(id: $id, roomId: $roomId, devices: $devices, wires: $wires, junctionBoxes: $junctionBoxes, pipes: $pipes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ElectricalLayoutImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            const DeepCollectionEquality().equals(other._devices, _devices) &&
            const DeepCollectionEquality().equals(other._wires, _wires) &&
            const DeepCollectionEquality().equals(
              other._junctionBoxes,
              _junctionBoxes,
            ) &&
            const DeepCollectionEquality().equals(other._pipes, _pipes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    roomId,
    const DeepCollectionEquality().hash(_devices),
    const DeepCollectionEquality().hash(_wires),
    const DeepCollectionEquality().hash(_junctionBoxes),
    const DeepCollectionEquality().hash(_pipes),
  );

  /// Create a copy of ElectricalLayout
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ElectricalLayoutImplCopyWith<_$ElectricalLayoutImpl> get copyWith =>
      __$$ElectricalLayoutImplCopyWithImpl<_$ElectricalLayoutImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ElectricalLayoutImplToJson(this);
  }
}

abstract class _ElectricalLayout implements ElectricalLayout {
  const factory _ElectricalLayout({
    required final String id,
    required final String roomId,
    final List<ElectricalDevice> devices,
    final List<WireSegment> wires,
    final List<JunctionBox> junctionBoxes,
    final List<PipeSegment> pipes,
  }) = _$ElectricalLayoutImpl;

  factory _ElectricalLayout.fromJson(Map<String, dynamic> json) =
      _$ElectricalLayoutImpl.fromJson;

  @override
  String get id;
  @override
  String get roomId;
  @override
  List<ElectricalDevice> get devices;
  @override
  List<WireSegment> get wires;
  @override
  List<JunctionBox> get junctionBoxes;
  @override
  List<PipeSegment> get pipes;

  /// Create a copy of ElectricalLayout
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ElectricalLayoutImplCopyWith<_$ElectricalLayoutImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
