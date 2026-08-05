// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room_out.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RoomOut _$RoomOutFromJson(Map<String, dynamic> json) {
  return _RoomOut.fromJson(json);
}

/// @nodoc
mixin _$RoomOut {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'apartment_id')
  String get apartmentId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'ceiling_h')
  double? get ceilingH => throw _privateConstructorUsedError;
  Map<String, dynamic>? get geometry => throw _privateConstructorUsedError;
  Map<String, dynamic>? get surfaces => throw _privateConstructorUsedError;
  @JsonKey(name: 'furniture_layout')
  List<dynamic>? get furnitureLayout => throw _privateConstructorUsedError;
  Map<String, dynamic>? get state => throw _privateConstructorUsedError;
  @JsonKey(name: 'floor_area')
  double? get floorArea => throw _privateConstructorUsedError;
  @JsonKey(name: 'net_wall_area')
  double? get netWallArea => throw _privateConstructorUsedError;
  double? get perimeter => throw _privateConstructorUsedError;
  @JsonKey(name: 'openings_count')
  int get openingsCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this RoomOut to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RoomOut
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoomOutCopyWith<RoomOut> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomOutCopyWith<$Res> {
  factory $RoomOutCopyWith(RoomOut value, $Res Function(RoomOut) then) =
      _$RoomOutCopyWithImpl<$Res, RoomOut>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'apartment_id') String apartmentId,
    String name,
    @JsonKey(name: 'ceiling_h') double? ceilingH,
    Map<String, dynamic>? geometry,
    Map<String, dynamic>? surfaces,
    @JsonKey(name: 'furniture_layout') List<dynamic>? furnitureLayout,
    Map<String, dynamic>? state,
    @JsonKey(name: 'floor_area') double? floorArea,
    @JsonKey(name: 'net_wall_area') double? netWallArea,
    double? perimeter,
    @JsonKey(name: 'openings_count') int openingsCount,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });
}

/// @nodoc
class _$RoomOutCopyWithImpl<$Res, $Val extends RoomOut>
    implements $RoomOutCopyWith<$Res> {
  _$RoomOutCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RoomOut
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? apartmentId = null,
    Object? name = null,
    Object? ceilingH = freezed,
    Object? geometry = freezed,
    Object? surfaces = freezed,
    Object? furnitureLayout = freezed,
    Object? state = freezed,
    Object? floorArea = freezed,
    Object? netWallArea = freezed,
    Object? perimeter = freezed,
    Object? openingsCount = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            apartmentId: null == apartmentId
                ? _value.apartmentId
                : apartmentId // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            ceilingH: freezed == ceilingH
                ? _value.ceilingH
                : ceilingH // ignore: cast_nullable_to_non_nullable
                      as double?,
            geometry: freezed == geometry
                ? _value.geometry
                : geometry // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            surfaces: freezed == surfaces
                ? _value.surfaces
                : surfaces // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            furnitureLayout: freezed == furnitureLayout
                ? _value.furnitureLayout
                : furnitureLayout // ignore: cast_nullable_to_non_nullable
                      as List<dynamic>?,
            state: freezed == state
                ? _value.state
                : state // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            floorArea: freezed == floorArea
                ? _value.floorArea
                : floorArea // ignore: cast_nullable_to_non_nullable
                      as double?,
            netWallArea: freezed == netWallArea
                ? _value.netWallArea
                : netWallArea // ignore: cast_nullable_to_non_nullable
                      as double?,
            perimeter: freezed == perimeter
                ? _value.perimeter
                : perimeter // ignore: cast_nullable_to_non_nullable
                      as double?,
            openingsCount: null == openingsCount
                ? _value.openingsCount
                : openingsCount // ignore: cast_nullable_to_non_nullable
                      as int,
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
abstract class _$$RoomOutImplCopyWith<$Res> implements $RoomOutCopyWith<$Res> {
  factory _$$RoomOutImplCopyWith(
    _$RoomOutImpl value,
    $Res Function(_$RoomOutImpl) then,
  ) = __$$RoomOutImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'apartment_id') String apartmentId,
    String name,
    @JsonKey(name: 'ceiling_h') double? ceilingH,
    Map<String, dynamic>? geometry,
    Map<String, dynamic>? surfaces,
    @JsonKey(name: 'furniture_layout') List<dynamic>? furnitureLayout,
    Map<String, dynamic>? state,
    @JsonKey(name: 'floor_area') double? floorArea,
    @JsonKey(name: 'net_wall_area') double? netWallArea,
    double? perimeter,
    @JsonKey(name: 'openings_count') int openingsCount,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });
}

/// @nodoc
class __$$RoomOutImplCopyWithImpl<$Res>
    extends _$RoomOutCopyWithImpl<$Res, _$RoomOutImpl>
    implements _$$RoomOutImplCopyWith<$Res> {
  __$$RoomOutImplCopyWithImpl(
    _$RoomOutImpl _value,
    $Res Function(_$RoomOutImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RoomOut
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? apartmentId = null,
    Object? name = null,
    Object? ceilingH = freezed,
    Object? geometry = freezed,
    Object? surfaces = freezed,
    Object? furnitureLayout = freezed,
    Object? state = freezed,
    Object? floorArea = freezed,
    Object? netWallArea = freezed,
    Object? perimeter = freezed,
    Object? openingsCount = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$RoomOutImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        apartmentId: null == apartmentId
            ? _value.apartmentId
            : apartmentId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        ceilingH: freezed == ceilingH
            ? _value.ceilingH
            : ceilingH // ignore: cast_nullable_to_non_nullable
                  as double?,
        geometry: freezed == geometry
            ? _value._geometry
            : geometry // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        surfaces: freezed == surfaces
            ? _value._surfaces
            : surfaces // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        furnitureLayout: freezed == furnitureLayout
            ? _value._furnitureLayout
            : furnitureLayout // ignore: cast_nullable_to_non_nullable
                  as List<dynamic>?,
        state: freezed == state
            ? _value._state
            : state // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        floorArea: freezed == floorArea
            ? _value.floorArea
            : floorArea // ignore: cast_nullable_to_non_nullable
                  as double?,
        netWallArea: freezed == netWallArea
            ? _value.netWallArea
            : netWallArea // ignore: cast_nullable_to_non_nullable
                  as double?,
        perimeter: freezed == perimeter
            ? _value.perimeter
            : perimeter // ignore: cast_nullable_to_non_nullable
                  as double?,
        openingsCount: null == openingsCount
            ? _value.openingsCount
            : openingsCount // ignore: cast_nullable_to_non_nullable
                  as int,
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
class _$RoomOutImpl implements _RoomOut {
  const _$RoomOutImpl({
    required this.id,
    @JsonKey(name: 'apartment_id') required this.apartmentId,
    required this.name,
    @JsonKey(name: 'ceiling_h') this.ceilingH,
    final Map<String, dynamic>? geometry,
    final Map<String, dynamic>? surfaces,
    @JsonKey(name: 'furniture_layout') final List<dynamic>? furnitureLayout,
    final Map<String, dynamic>? state,
    @JsonKey(name: 'floor_area') this.floorArea,
    @JsonKey(name: 'net_wall_area') this.netWallArea,
    this.perimeter,
    @JsonKey(name: 'openings_count') this.openingsCount = 0,
    @JsonKey(name: 'updated_at') required this.updatedAt,
  }) : _geometry = geometry,
       _surfaces = surfaces,
       _furnitureLayout = furnitureLayout,
       _state = state;

  factory _$RoomOutImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoomOutImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'apartment_id')
  final String apartmentId;
  @override
  final String name;
  @override
  @JsonKey(name: 'ceiling_h')
  final double? ceilingH;
  final Map<String, dynamic>? _geometry;
  @override
  Map<String, dynamic>? get geometry {
    final value = _geometry;
    if (value == null) return null;
    if (_geometry is EqualUnmodifiableMapView) return _geometry;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _surfaces;
  @override
  Map<String, dynamic>? get surfaces {
    final value = _surfaces;
    if (value == null) return null;
    if (_surfaces is EqualUnmodifiableMapView) return _surfaces;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<dynamic>? _furnitureLayout;
  @override
  @JsonKey(name: 'furniture_layout')
  List<dynamic>? get furnitureLayout {
    final value = _furnitureLayout;
    if (value == null) return null;
    if (_furnitureLayout is EqualUnmodifiableListView) return _furnitureLayout;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, dynamic>? _state;
  @override
  Map<String, dynamic>? get state {
    final value = _state;
    if (value == null) return null;
    if (_state is EqualUnmodifiableMapView) return _state;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey(name: 'floor_area')
  final double? floorArea;
  @override
  @JsonKey(name: 'net_wall_area')
  final double? netWallArea;
  @override
  final double? perimeter;
  @override
  @JsonKey(name: 'openings_count')
  final int openingsCount;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @override
  String toString() {
    return 'RoomOut(id: $id, apartmentId: $apartmentId, name: $name, ceilingH: $ceilingH, geometry: $geometry, surfaces: $surfaces, furnitureLayout: $furnitureLayout, state: $state, floorArea: $floorArea, netWallArea: $netWallArea, perimeter: $perimeter, openingsCount: $openingsCount, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomOutImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.apartmentId, apartmentId) ||
                other.apartmentId == apartmentId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.ceilingH, ceilingH) ||
                other.ceilingH == ceilingH) &&
            const DeepCollectionEquality().equals(other._geometry, _geometry) &&
            const DeepCollectionEquality().equals(other._surfaces, _surfaces) &&
            const DeepCollectionEquality().equals(
              other._furnitureLayout,
              _furnitureLayout,
            ) &&
            const DeepCollectionEquality().equals(other._state, _state) &&
            (identical(other.floorArea, floorArea) ||
                other.floorArea == floorArea) &&
            (identical(other.netWallArea, netWallArea) ||
                other.netWallArea == netWallArea) &&
            (identical(other.perimeter, perimeter) ||
                other.perimeter == perimeter) &&
            (identical(other.openingsCount, openingsCount) ||
                other.openingsCount == openingsCount) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    apartmentId,
    name,
    ceilingH,
    const DeepCollectionEquality().hash(_geometry),
    const DeepCollectionEquality().hash(_surfaces),
    const DeepCollectionEquality().hash(_furnitureLayout),
    const DeepCollectionEquality().hash(_state),
    floorArea,
    netWallArea,
    perimeter,
    openingsCount,
    updatedAt,
  );

  /// Create a copy of RoomOut
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomOutImplCopyWith<_$RoomOutImpl> get copyWith =>
      __$$RoomOutImplCopyWithImpl<_$RoomOutImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoomOutImplToJson(this);
  }
}

abstract class _RoomOut implements RoomOut {
  const factory _RoomOut({
    required final String id,
    @JsonKey(name: 'apartment_id') required final String apartmentId,
    required final String name,
    @JsonKey(name: 'ceiling_h') final double? ceilingH,
    final Map<String, dynamic>? geometry,
    final Map<String, dynamic>? surfaces,
    @JsonKey(name: 'furniture_layout') final List<dynamic>? furnitureLayout,
    final Map<String, dynamic>? state,
    @JsonKey(name: 'floor_area') final double? floorArea,
    @JsonKey(name: 'net_wall_area') final double? netWallArea,
    final double? perimeter,
    @JsonKey(name: 'openings_count') final int openingsCount,
    @JsonKey(name: 'updated_at') required final DateTime updatedAt,
  }) = _$RoomOutImpl;

  factory _RoomOut.fromJson(Map<String, dynamic> json) = _$RoomOutImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'apartment_id')
  String get apartmentId;
  @override
  String get name;
  @override
  @JsonKey(name: 'ceiling_h')
  double? get ceilingH;
  @override
  Map<String, dynamic>? get geometry;
  @override
  Map<String, dynamic>? get surfaces;
  @override
  @JsonKey(name: 'furniture_layout')
  List<dynamic>? get furnitureLayout;
  @override
  Map<String, dynamic>? get state;
  @override
  @JsonKey(name: 'floor_area')
  double? get floorArea;
  @override
  @JsonKey(name: 'net_wall_area')
  double? get netWallArea;
  @override
  double? get perimeter;
  @override
  @JsonKey(name: 'openings_count')
  int get openingsCount;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;

  /// Create a copy of RoomOut
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoomOutImplCopyWith<_$RoomOutImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
