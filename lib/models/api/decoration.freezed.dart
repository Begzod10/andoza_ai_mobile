// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'decoration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WallsDecoration _$WallsDecorationFromJson(Map<String, dynamic> json) {
  return _WallsDecoration.fromJson(json);
}

/// @nodoc
mixin _$WallsDecoration {
  @JsonKey(name: 'material_id')
  String? get materialId => throw _privateConstructorUsedError;
  String get finish => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;

  /// Serializes this WallsDecoration to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WallsDecoration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WallsDecorationCopyWith<WallsDecoration> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WallsDecorationCopyWith<$Res> {
  factory $WallsDecorationCopyWith(
    WallsDecoration value,
    $Res Function(WallsDecoration) then,
  ) = _$WallsDecorationCopyWithImpl<$Res, WallsDecoration>;
  @useResult
  $Res call({
    @JsonKey(name: 'material_id') String? materialId,
    String finish,
    String? color,
  });
}

/// @nodoc
class _$WallsDecorationCopyWithImpl<$Res, $Val extends WallsDecoration>
    implements $WallsDecorationCopyWith<$Res> {
  _$WallsDecorationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WallsDecoration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? materialId = freezed,
    Object? finish = null,
    Object? color = freezed,
  }) {
    return _then(
      _value.copyWith(
            materialId: freezed == materialId
                ? _value.materialId
                : materialId // ignore: cast_nullable_to_non_nullable
                      as String?,
            finish: null == finish
                ? _value.finish
                : finish // ignore: cast_nullable_to_non_nullable
                      as String,
            color: freezed == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WallsDecorationImplCopyWith<$Res>
    implements $WallsDecorationCopyWith<$Res> {
  factory _$$WallsDecorationImplCopyWith(
    _$WallsDecorationImpl value,
    $Res Function(_$WallsDecorationImpl) then,
  ) = __$$WallsDecorationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'material_id') String? materialId,
    String finish,
    String? color,
  });
}

/// @nodoc
class __$$WallsDecorationImplCopyWithImpl<$Res>
    extends _$WallsDecorationCopyWithImpl<$Res, _$WallsDecorationImpl>
    implements _$$WallsDecorationImplCopyWith<$Res> {
  __$$WallsDecorationImplCopyWithImpl(
    _$WallsDecorationImpl _value,
    $Res Function(_$WallsDecorationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WallsDecoration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? materialId = freezed,
    Object? finish = null,
    Object? color = freezed,
  }) {
    return _then(
      _$WallsDecorationImpl(
        materialId: freezed == materialId
            ? _value.materialId
            : materialId // ignore: cast_nullable_to_non_nullable
                  as String?,
        finish: null == finish
            ? _value.finish
            : finish // ignore: cast_nullable_to_non_nullable
                  as String,
        color: freezed == color
            ? _value.color
            : color // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WallsDecorationImpl implements _WallsDecoration {
  const _$WallsDecorationImpl({
    @JsonKey(name: 'material_id') this.materialId,
    this.finish = 'paint',
    this.color,
  });

  factory _$WallsDecorationImpl.fromJson(Map<String, dynamic> json) =>
      _$$WallsDecorationImplFromJson(json);

  @override
  @JsonKey(name: 'material_id')
  final String? materialId;
  @override
  @JsonKey()
  final String finish;
  @override
  final String? color;

  @override
  String toString() {
    return 'WallsDecoration(materialId: $materialId, finish: $finish, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WallsDecorationImpl &&
            (identical(other.materialId, materialId) ||
                other.materialId == materialId) &&
            (identical(other.finish, finish) || other.finish == finish) &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, materialId, finish, color);

  /// Create a copy of WallsDecoration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WallsDecorationImplCopyWith<_$WallsDecorationImpl> get copyWith =>
      __$$WallsDecorationImplCopyWithImpl<_$WallsDecorationImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$WallsDecorationImplToJson(this);
  }
}

abstract class _WallsDecoration implements WallsDecoration {
  const factory _WallsDecoration({
    @JsonKey(name: 'material_id') final String? materialId,
    final String finish,
    final String? color,
  }) = _$WallsDecorationImpl;

  factory _WallsDecoration.fromJson(Map<String, dynamic> json) =
      _$WallsDecorationImpl.fromJson;

  @override
  @JsonKey(name: 'material_id')
  String? get materialId;
  @override
  String get finish;
  @override
  String? get color;

  /// Create a copy of WallsDecoration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WallsDecorationImplCopyWith<_$WallsDecorationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FloorDecoration _$FloorDecorationFromJson(Map<String, dynamic> json) {
  return _FloorDecoration.fromJson(json);
}

/// @nodoc
mixin _$FloorDecoration {
  @JsonKey(name: 'material_id')
  String? get materialId => throw _privateConstructorUsedError;

  /// Serializes this FloorDecoration to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FloorDecoration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FloorDecorationCopyWith<FloorDecoration> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FloorDecorationCopyWith<$Res> {
  factory $FloorDecorationCopyWith(
    FloorDecoration value,
    $Res Function(FloorDecoration) then,
  ) = _$FloorDecorationCopyWithImpl<$Res, FloorDecoration>;
  @useResult
  $Res call({@JsonKey(name: 'material_id') String? materialId});
}

/// @nodoc
class _$FloorDecorationCopyWithImpl<$Res, $Val extends FloorDecoration>
    implements $FloorDecorationCopyWith<$Res> {
  _$FloorDecorationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FloorDecoration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? materialId = freezed}) {
    return _then(
      _value.copyWith(
            materialId: freezed == materialId
                ? _value.materialId
                : materialId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FloorDecorationImplCopyWith<$Res>
    implements $FloorDecorationCopyWith<$Res> {
  factory _$$FloorDecorationImplCopyWith(
    _$FloorDecorationImpl value,
    $Res Function(_$FloorDecorationImpl) then,
  ) = __$$FloorDecorationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'material_id') String? materialId});
}

/// @nodoc
class __$$FloorDecorationImplCopyWithImpl<$Res>
    extends _$FloorDecorationCopyWithImpl<$Res, _$FloorDecorationImpl>
    implements _$$FloorDecorationImplCopyWith<$Res> {
  __$$FloorDecorationImplCopyWithImpl(
    _$FloorDecorationImpl _value,
    $Res Function(_$FloorDecorationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FloorDecoration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? materialId = freezed}) {
    return _then(
      _$FloorDecorationImpl(
        materialId: freezed == materialId
            ? _value.materialId
            : materialId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FloorDecorationImpl implements _FloorDecoration {
  const _$FloorDecorationImpl({@JsonKey(name: 'material_id') this.materialId});

  factory _$FloorDecorationImpl.fromJson(Map<String, dynamic> json) =>
      _$$FloorDecorationImplFromJson(json);

  @override
  @JsonKey(name: 'material_id')
  final String? materialId;

  @override
  String toString() {
    return 'FloorDecoration(materialId: $materialId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FloorDecorationImpl &&
            (identical(other.materialId, materialId) ||
                other.materialId == materialId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, materialId);

  /// Create a copy of FloorDecoration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FloorDecorationImplCopyWith<_$FloorDecorationImpl> get copyWith =>
      __$$FloorDecorationImplCopyWithImpl<_$FloorDecorationImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$FloorDecorationImplToJson(this);
  }
}

abstract class _FloorDecoration implements FloorDecoration {
  const factory _FloorDecoration({
    @JsonKey(name: 'material_id') final String? materialId,
  }) = _$FloorDecorationImpl;

  factory _FloorDecoration.fromJson(Map<String, dynamic> json) =
      _$FloorDecorationImpl.fromJson;

  @override
  @JsonKey(name: 'material_id')
  String? get materialId;

  /// Create a copy of FloorDecoration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FloorDecorationImplCopyWith<_$FloorDecorationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CeilingDecoration _$CeilingDecorationFromJson(Map<String, dynamic> json) {
  return _CeilingDecoration.fromJson(json);
}

/// @nodoc
mixin _$CeilingDecoration {
  @JsonKey(name: 'material_id')
  String? get materialId => throw _privateConstructorUsedError;

  /// Serializes this CeilingDecoration to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CeilingDecoration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CeilingDecorationCopyWith<CeilingDecoration> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CeilingDecorationCopyWith<$Res> {
  factory $CeilingDecorationCopyWith(
    CeilingDecoration value,
    $Res Function(CeilingDecoration) then,
  ) = _$CeilingDecorationCopyWithImpl<$Res, CeilingDecoration>;
  @useResult
  $Res call({@JsonKey(name: 'material_id') String? materialId});
}

/// @nodoc
class _$CeilingDecorationCopyWithImpl<$Res, $Val extends CeilingDecoration>
    implements $CeilingDecorationCopyWith<$Res> {
  _$CeilingDecorationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CeilingDecoration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? materialId = freezed}) {
    return _then(
      _value.copyWith(
            materialId: freezed == materialId
                ? _value.materialId
                : materialId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CeilingDecorationImplCopyWith<$Res>
    implements $CeilingDecorationCopyWith<$Res> {
  factory _$$CeilingDecorationImplCopyWith(
    _$CeilingDecorationImpl value,
    $Res Function(_$CeilingDecorationImpl) then,
  ) = __$$CeilingDecorationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'material_id') String? materialId});
}

/// @nodoc
class __$$CeilingDecorationImplCopyWithImpl<$Res>
    extends _$CeilingDecorationCopyWithImpl<$Res, _$CeilingDecorationImpl>
    implements _$$CeilingDecorationImplCopyWith<$Res> {
  __$$CeilingDecorationImplCopyWithImpl(
    _$CeilingDecorationImpl _value,
    $Res Function(_$CeilingDecorationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CeilingDecoration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? materialId = freezed}) {
    return _then(
      _$CeilingDecorationImpl(
        materialId: freezed == materialId
            ? _value.materialId
            : materialId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CeilingDecorationImpl implements _CeilingDecoration {
  const _$CeilingDecorationImpl({
    @JsonKey(name: 'material_id') this.materialId,
  });

  factory _$CeilingDecorationImpl.fromJson(Map<String, dynamic> json) =>
      _$$CeilingDecorationImplFromJson(json);

  @override
  @JsonKey(name: 'material_id')
  final String? materialId;

  @override
  String toString() {
    return 'CeilingDecoration(materialId: $materialId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CeilingDecorationImpl &&
            (identical(other.materialId, materialId) ||
                other.materialId == materialId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, materialId);

  /// Create a copy of CeilingDecoration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CeilingDecorationImplCopyWith<_$CeilingDecorationImpl> get copyWith =>
      __$$CeilingDecorationImplCopyWithImpl<_$CeilingDecorationImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CeilingDecorationImplToJson(this);
  }
}

abstract class _CeilingDecoration implements CeilingDecoration {
  const factory _CeilingDecoration({
    @JsonKey(name: 'material_id') final String? materialId,
  }) = _$CeilingDecorationImpl;

  factory _CeilingDecoration.fromJson(Map<String, dynamic> json) =
      _$CeilingDecorationImpl.fromJson;

  @override
  @JsonKey(name: 'material_id')
  String? get materialId;

  /// Create a copy of CeilingDecoration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CeilingDecorationImplCopyWith<_$CeilingDecorationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DecorationFurniture _$DecorationFurnitureFromJson(Map<String, dynamic> json) {
  return _DecorationFurniture.fromJson(json);
}

/// @nodoc
mixin _$DecorationFurniture {
  @JsonKey(name: 'furniture_id')
  String get furnitureId => throw _privateConstructorUsedError;
  double get x => throw _privateConstructorUsedError;
  double get y => throw _privateConstructorUsedError;
  double get rotation => throw _privateConstructorUsedError;

  /// Serializes this DecorationFurniture to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DecorationFurniture
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DecorationFurnitureCopyWith<DecorationFurniture> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DecorationFurnitureCopyWith<$Res> {
  factory $DecorationFurnitureCopyWith(
    DecorationFurniture value,
    $Res Function(DecorationFurniture) then,
  ) = _$DecorationFurnitureCopyWithImpl<$Res, DecorationFurniture>;
  @useResult
  $Res call({
    @JsonKey(name: 'furniture_id') String furnitureId,
    double x,
    double y,
    double rotation,
  });
}

/// @nodoc
class _$DecorationFurnitureCopyWithImpl<$Res, $Val extends DecorationFurniture>
    implements $DecorationFurnitureCopyWith<$Res> {
  _$DecorationFurnitureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DecorationFurniture
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? furnitureId = null,
    Object? x = null,
    Object? y = null,
    Object? rotation = null,
  }) {
    return _then(
      _value.copyWith(
            furnitureId: null == furnitureId
                ? _value.furnitureId
                : furnitureId // ignore: cast_nullable_to_non_nullable
                      as String,
            x: null == x
                ? _value.x
                : x // ignore: cast_nullable_to_non_nullable
                      as double,
            y: null == y
                ? _value.y
                : y // ignore: cast_nullable_to_non_nullable
                      as double,
            rotation: null == rotation
                ? _value.rotation
                : rotation // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DecorationFurnitureImplCopyWith<$Res>
    implements $DecorationFurnitureCopyWith<$Res> {
  factory _$$DecorationFurnitureImplCopyWith(
    _$DecorationFurnitureImpl value,
    $Res Function(_$DecorationFurnitureImpl) then,
  ) = __$$DecorationFurnitureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'furniture_id') String furnitureId,
    double x,
    double y,
    double rotation,
  });
}

/// @nodoc
class __$$DecorationFurnitureImplCopyWithImpl<$Res>
    extends _$DecorationFurnitureCopyWithImpl<$Res, _$DecorationFurnitureImpl>
    implements _$$DecorationFurnitureImplCopyWith<$Res> {
  __$$DecorationFurnitureImplCopyWithImpl(
    _$DecorationFurnitureImpl _value,
    $Res Function(_$DecorationFurnitureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DecorationFurniture
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? furnitureId = null,
    Object? x = null,
    Object? y = null,
    Object? rotation = null,
  }) {
    return _then(
      _$DecorationFurnitureImpl(
        furnitureId: null == furnitureId
            ? _value.furnitureId
            : furnitureId // ignore: cast_nullable_to_non_nullable
                  as String,
        x: null == x
            ? _value.x
            : x // ignore: cast_nullable_to_non_nullable
                  as double,
        y: null == y
            ? _value.y
            : y // ignore: cast_nullable_to_non_nullable
                  as double,
        rotation: null == rotation
            ? _value.rotation
            : rotation // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DecorationFurnitureImpl implements _DecorationFurniture {
  const _$DecorationFurnitureImpl({
    @JsonKey(name: 'furniture_id') required this.furnitureId,
    required this.x,
    required this.y,
    this.rotation = 0.0,
  });

  factory _$DecorationFurnitureImpl.fromJson(Map<String, dynamic> json) =>
      _$$DecorationFurnitureImplFromJson(json);

  @override
  @JsonKey(name: 'furniture_id')
  final String furnitureId;
  @override
  final double x;
  @override
  final double y;
  @override
  @JsonKey()
  final double rotation;

  @override
  String toString() {
    return 'DecorationFurniture(furnitureId: $furnitureId, x: $x, y: $y, rotation: $rotation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DecorationFurnitureImpl &&
            (identical(other.furnitureId, furnitureId) ||
                other.furnitureId == furnitureId) &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y) &&
            (identical(other.rotation, rotation) ||
                other.rotation == rotation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, furnitureId, x, y, rotation);

  /// Create a copy of DecorationFurniture
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DecorationFurnitureImplCopyWith<_$DecorationFurnitureImpl> get copyWith =>
      __$$DecorationFurnitureImplCopyWithImpl<_$DecorationFurnitureImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DecorationFurnitureImplToJson(this);
  }
}

abstract class _DecorationFurniture implements DecorationFurniture {
  const factory _DecorationFurniture({
    @JsonKey(name: 'furniture_id') required final String furnitureId,
    required final double x,
    required final double y,
    final double rotation,
  }) = _$DecorationFurnitureImpl;

  factory _DecorationFurniture.fromJson(Map<String, dynamic> json) =
      _$DecorationFurnitureImpl.fromJson;

  @override
  @JsonKey(name: 'furniture_id')
  String get furnitureId;
  @override
  double get x;
  @override
  double get y;
  @override
  double get rotation;

  /// Create a copy of DecorationFurniture
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DecorationFurnitureImplCopyWith<_$DecorationFurnitureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Decoration _$DecorationFromJson(Map<String, dynamic> json) {
  return _Decoration.fromJson(json);
}

/// @nodoc
mixin _$Decoration {
  @JsonKey(name: 'room_id')
  String get roomId => throw _privateConstructorUsedError;
  WallsDecoration get walls => throw _privateConstructorUsedError;
  FloorDecoration get floor => throw _privateConstructorUsedError;
  CeilingDecoration get ceiling => throw _privateConstructorUsedError;
  List<DecorationFurniture> get furniture => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Decoration to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Decoration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DecorationCopyWith<Decoration> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DecorationCopyWith<$Res> {
  factory $DecorationCopyWith(
    Decoration value,
    $Res Function(Decoration) then,
  ) = _$DecorationCopyWithImpl<$Res, Decoration>;
  @useResult
  $Res call({
    @JsonKey(name: 'room_id') String roomId,
    WallsDecoration walls,
    FloorDecoration floor,
    CeilingDecoration ceiling,
    List<DecorationFurniture> furniture,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });

  $WallsDecorationCopyWith<$Res> get walls;
  $FloorDecorationCopyWith<$Res> get floor;
  $CeilingDecorationCopyWith<$Res> get ceiling;
}

/// @nodoc
class _$DecorationCopyWithImpl<$Res, $Val extends Decoration>
    implements $DecorationCopyWith<$Res> {
  _$DecorationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Decoration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roomId = null,
    Object? walls = null,
    Object? floor = null,
    Object? ceiling = null,
    Object? furniture = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            roomId: null == roomId
                ? _value.roomId
                : roomId // ignore: cast_nullable_to_non_nullable
                      as String,
            walls: null == walls
                ? _value.walls
                : walls // ignore: cast_nullable_to_non_nullable
                      as WallsDecoration,
            floor: null == floor
                ? _value.floor
                : floor // ignore: cast_nullable_to_non_nullable
                      as FloorDecoration,
            ceiling: null == ceiling
                ? _value.ceiling
                : ceiling // ignore: cast_nullable_to_non_nullable
                      as CeilingDecoration,
            furniture: null == furniture
                ? _value.furniture
                : furniture // ignore: cast_nullable_to_non_nullable
                      as List<DecorationFurniture>,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }

  /// Create a copy of Decoration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WallsDecorationCopyWith<$Res> get walls {
    return $WallsDecorationCopyWith<$Res>(_value.walls, (value) {
      return _then(_value.copyWith(walls: value) as $Val);
    });
  }

  /// Create a copy of Decoration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FloorDecorationCopyWith<$Res> get floor {
    return $FloorDecorationCopyWith<$Res>(_value.floor, (value) {
      return _then(_value.copyWith(floor: value) as $Val);
    });
  }

  /// Create a copy of Decoration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CeilingDecorationCopyWith<$Res> get ceiling {
    return $CeilingDecorationCopyWith<$Res>(_value.ceiling, (value) {
      return _then(_value.copyWith(ceiling: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DecorationImplCopyWith<$Res>
    implements $DecorationCopyWith<$Res> {
  factory _$$DecorationImplCopyWith(
    _$DecorationImpl value,
    $Res Function(_$DecorationImpl) then,
  ) = __$$DecorationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'room_id') String roomId,
    WallsDecoration walls,
    FloorDecoration floor,
    CeilingDecoration ceiling,
    List<DecorationFurniture> furniture,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });

  @override
  $WallsDecorationCopyWith<$Res> get walls;
  @override
  $FloorDecorationCopyWith<$Res> get floor;
  @override
  $CeilingDecorationCopyWith<$Res> get ceiling;
}

/// @nodoc
class __$$DecorationImplCopyWithImpl<$Res>
    extends _$DecorationCopyWithImpl<$Res, _$DecorationImpl>
    implements _$$DecorationImplCopyWith<$Res> {
  __$$DecorationImplCopyWithImpl(
    _$DecorationImpl _value,
    $Res Function(_$DecorationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Decoration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roomId = null,
    Object? walls = null,
    Object? floor = null,
    Object? ceiling = null,
    Object? furniture = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$DecorationImpl(
        roomId: null == roomId
            ? _value.roomId
            : roomId // ignore: cast_nullable_to_non_nullable
                  as String,
        walls: null == walls
            ? _value.walls
            : walls // ignore: cast_nullable_to_non_nullable
                  as WallsDecoration,
        floor: null == floor
            ? _value.floor
            : floor // ignore: cast_nullable_to_non_nullable
                  as FloorDecoration,
        ceiling: null == ceiling
            ? _value.ceiling
            : ceiling // ignore: cast_nullable_to_non_nullable
                  as CeilingDecoration,
        furniture: null == furniture
            ? _value._furniture
            : furniture // ignore: cast_nullable_to_non_nullable
                  as List<DecorationFurniture>,
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
class _$DecorationImpl implements _Decoration {
  const _$DecorationImpl({
    @JsonKey(name: 'room_id') required this.roomId,
    this.walls = const WallsDecoration(),
    this.floor = const FloorDecoration(),
    this.ceiling = const CeilingDecoration(),
    final List<DecorationFurniture> furniture = const <DecorationFurniture>[],
    @JsonKey(name: 'updated_at') required this.updatedAt,
  }) : _furniture = furniture;

  factory _$DecorationImpl.fromJson(Map<String, dynamic> json) =>
      _$$DecorationImplFromJson(json);

  @override
  @JsonKey(name: 'room_id')
  final String roomId;
  @override
  @JsonKey()
  final WallsDecoration walls;
  @override
  @JsonKey()
  final FloorDecoration floor;
  @override
  @JsonKey()
  final CeilingDecoration ceiling;
  final List<DecorationFurniture> _furniture;
  @override
  @JsonKey()
  List<DecorationFurniture> get furniture {
    if (_furniture is EqualUnmodifiableListView) return _furniture;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_furniture);
  }

  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Decoration(roomId: $roomId, walls: $walls, floor: $floor, ceiling: $ceiling, furniture: $furniture, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DecorationImpl &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.walls, walls) || other.walls == walls) &&
            (identical(other.floor, floor) || other.floor == floor) &&
            (identical(other.ceiling, ceiling) || other.ceiling == ceiling) &&
            const DeepCollectionEquality().equals(
              other._furniture,
              _furniture,
            ) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    roomId,
    walls,
    floor,
    ceiling,
    const DeepCollectionEquality().hash(_furniture),
    updatedAt,
  );

  /// Create a copy of Decoration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DecorationImplCopyWith<_$DecorationImpl> get copyWith =>
      __$$DecorationImplCopyWithImpl<_$DecorationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DecorationImplToJson(this);
  }
}

abstract class _Decoration implements Decoration {
  const factory _Decoration({
    @JsonKey(name: 'room_id') required final String roomId,
    final WallsDecoration walls,
    final FloorDecoration floor,
    final CeilingDecoration ceiling,
    final List<DecorationFurniture> furniture,
    @JsonKey(name: 'updated_at') required final DateTime updatedAt,
  }) = _$DecorationImpl;

  factory _Decoration.fromJson(Map<String, dynamic> json) =
      _$DecorationImpl.fromJson;

  @override
  @JsonKey(name: 'room_id')
  String get roomId;
  @override
  WallsDecoration get walls;
  @override
  FloorDecoration get floor;
  @override
  CeilingDecoration get ceiling;
  @override
  List<DecorationFurniture> get furniture;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;

  /// Create a copy of Decoration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DecorationImplCopyWith<_$DecorationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
