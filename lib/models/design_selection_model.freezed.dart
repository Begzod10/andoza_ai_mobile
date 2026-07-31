// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'design_selection_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RoomCondition _$RoomConditionFromJson(Map<String, dynamic> json) {
  return _RoomCondition.fromJson(json);
}

/// @nodoc
mixin _$RoomCondition {
  SurfaceCondition get wall => throw _privateConstructorUsedError;
  SurfaceCondition? get floor => throw _privateConstructorUsedError;
  SurfaceCondition? get ceiling => throw _privateConstructorUsedError;

  /// Serializes this RoomCondition to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RoomCondition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoomConditionCopyWith<RoomCondition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomConditionCopyWith<$Res> {
  factory $RoomConditionCopyWith(
    RoomCondition value,
    $Res Function(RoomCondition) then,
  ) = _$RoomConditionCopyWithImpl<$Res, RoomCondition>;
  @useResult
  $Res call({
    SurfaceCondition wall,
    SurfaceCondition? floor,
    SurfaceCondition? ceiling,
  });
}

/// @nodoc
class _$RoomConditionCopyWithImpl<$Res, $Val extends RoomCondition>
    implements $RoomConditionCopyWith<$Res> {
  _$RoomConditionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RoomCondition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wall = null,
    Object? floor = freezed,
    Object? ceiling = freezed,
  }) {
    return _then(
      _value.copyWith(
            wall: null == wall
                ? _value.wall
                : wall // ignore: cast_nullable_to_non_nullable
                      as SurfaceCondition,
            floor: freezed == floor
                ? _value.floor
                : floor // ignore: cast_nullable_to_non_nullable
                      as SurfaceCondition?,
            ceiling: freezed == ceiling
                ? _value.ceiling
                : ceiling // ignore: cast_nullable_to_non_nullable
                      as SurfaceCondition?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RoomConditionImplCopyWith<$Res>
    implements $RoomConditionCopyWith<$Res> {
  factory _$$RoomConditionImplCopyWith(
    _$RoomConditionImpl value,
    $Res Function(_$RoomConditionImpl) then,
  ) = __$$RoomConditionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    SurfaceCondition wall,
    SurfaceCondition? floor,
    SurfaceCondition? ceiling,
  });
}

/// @nodoc
class __$$RoomConditionImplCopyWithImpl<$Res>
    extends _$RoomConditionCopyWithImpl<$Res, _$RoomConditionImpl>
    implements _$$RoomConditionImplCopyWith<$Res> {
  __$$RoomConditionImplCopyWithImpl(
    _$RoomConditionImpl _value,
    $Res Function(_$RoomConditionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RoomCondition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wall = null,
    Object? floor = freezed,
    Object? ceiling = freezed,
  }) {
    return _then(
      _$RoomConditionImpl(
        wall: null == wall
            ? _value.wall
            : wall // ignore: cast_nullable_to_non_nullable
                  as SurfaceCondition,
        floor: freezed == floor
            ? _value.floor
            : floor // ignore: cast_nullable_to_non_nullable
                  as SurfaceCondition?,
        ceiling: freezed == ceiling
            ? _value.ceiling
            : ceiling // ignore: cast_nullable_to_non_nullable
                  as SurfaceCondition?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RoomConditionImpl implements _RoomCondition {
  const _$RoomConditionImpl({required this.wall, this.floor, this.ceiling});

  factory _$RoomConditionImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoomConditionImplFromJson(json);

  @override
  final SurfaceCondition wall;
  @override
  final SurfaceCondition? floor;
  @override
  final SurfaceCondition? ceiling;

  @override
  String toString() {
    return 'RoomCondition(wall: $wall, floor: $floor, ceiling: $ceiling)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomConditionImpl &&
            (identical(other.wall, wall) || other.wall == wall) &&
            (identical(other.floor, floor) || other.floor == floor) &&
            (identical(other.ceiling, ceiling) || other.ceiling == ceiling));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, wall, floor, ceiling);

  /// Create a copy of RoomCondition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomConditionImplCopyWith<_$RoomConditionImpl> get copyWith =>
      __$$RoomConditionImplCopyWithImpl<_$RoomConditionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoomConditionImplToJson(this);
  }
}

abstract class _RoomCondition implements RoomCondition {
  const factory _RoomCondition({
    required final SurfaceCondition wall,
    final SurfaceCondition? floor,
    final SurfaceCondition? ceiling,
  }) = _$RoomConditionImpl;

  factory _RoomCondition.fromJson(Map<String, dynamic> json) =
      _$RoomConditionImpl.fromJson;

  @override
  SurfaceCondition get wall;
  @override
  SurfaceCondition? get floor;
  @override
  SurfaceCondition? get ceiling;

  /// Create a copy of RoomCondition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoomConditionImplCopyWith<_$RoomConditionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FurniturePlacement _$FurniturePlacementFromJson(Map<String, dynamic> json) {
  return _FurniturePlacement.fromJson(json);
}

/// @nodoc
mixin _$FurniturePlacement {
  String get id => throw _privateConstructorUsedError;
  String get itemId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @OffsetConverter()
  Offset get position => throw _privateConstructorUsedError;
  double get rotationDegrees => throw _privateConstructorUsedError;
  String get selectedColor => throw _privateConstructorUsedError;

  /// Serializes this FurniturePlacement to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FurniturePlacement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FurniturePlacementCopyWith<FurniturePlacement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FurniturePlacementCopyWith<$Res> {
  factory $FurniturePlacementCopyWith(
    FurniturePlacement value,
    $Res Function(FurniturePlacement) then,
  ) = _$FurniturePlacementCopyWithImpl<$Res, FurniturePlacement>;
  @useResult
  $Res call({
    String id,
    String itemId,
    String name,
    @OffsetConverter() Offset position,
    double rotationDegrees,
    String selectedColor,
  });
}

/// @nodoc
class _$FurniturePlacementCopyWithImpl<$Res, $Val extends FurniturePlacement>
    implements $FurniturePlacementCopyWith<$Res> {
  _$FurniturePlacementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FurniturePlacement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? itemId = null,
    Object? name = null,
    Object? position = null,
    Object? rotationDegrees = null,
    Object? selectedColor = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            itemId: null == itemId
                ? _value.itemId
                : itemId // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            position: null == position
                ? _value.position
                : position // ignore: cast_nullable_to_non_nullable
                      as Offset,
            rotationDegrees: null == rotationDegrees
                ? _value.rotationDegrees
                : rotationDegrees // ignore: cast_nullable_to_non_nullable
                      as double,
            selectedColor: null == selectedColor
                ? _value.selectedColor
                : selectedColor // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FurniturePlacementImplCopyWith<$Res>
    implements $FurniturePlacementCopyWith<$Res> {
  factory _$$FurniturePlacementImplCopyWith(
    _$FurniturePlacementImpl value,
    $Res Function(_$FurniturePlacementImpl) then,
  ) = __$$FurniturePlacementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String itemId,
    String name,
    @OffsetConverter() Offset position,
    double rotationDegrees,
    String selectedColor,
  });
}

/// @nodoc
class __$$FurniturePlacementImplCopyWithImpl<$Res>
    extends _$FurniturePlacementCopyWithImpl<$Res, _$FurniturePlacementImpl>
    implements _$$FurniturePlacementImplCopyWith<$Res> {
  __$$FurniturePlacementImplCopyWithImpl(
    _$FurniturePlacementImpl _value,
    $Res Function(_$FurniturePlacementImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FurniturePlacement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? itemId = null,
    Object? name = null,
    Object? position = null,
    Object? rotationDegrees = null,
    Object? selectedColor = null,
  }) {
    return _then(
      _$FurniturePlacementImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        itemId: null == itemId
            ? _value.itemId
            : itemId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        position: null == position
            ? _value.position
            : position // ignore: cast_nullable_to_non_nullable
                  as Offset,
        rotationDegrees: null == rotationDegrees
            ? _value.rotationDegrees
            : rotationDegrees // ignore: cast_nullable_to_non_nullable
                  as double,
        selectedColor: null == selectedColor
            ? _value.selectedColor
            : selectedColor // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FurniturePlacementImpl implements _FurniturePlacement {
  const _$FurniturePlacementImpl({
    required this.id,
    required this.itemId,
    required this.name,
    @OffsetConverter() required this.position,
    this.rotationDegrees = 0,
    required this.selectedColor,
  });

  factory _$FurniturePlacementImpl.fromJson(Map<String, dynamic> json) =>
      _$$FurniturePlacementImplFromJson(json);

  @override
  final String id;
  @override
  final String itemId;
  @override
  final String name;
  @override
  @OffsetConverter()
  final Offset position;
  @override
  @JsonKey()
  final double rotationDegrees;
  @override
  final String selectedColor;

  @override
  String toString() {
    return 'FurniturePlacement(id: $id, itemId: $itemId, name: $name, position: $position, rotationDegrees: $rotationDegrees, selectedColor: $selectedColor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FurniturePlacementImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.itemId, itemId) || other.itemId == itemId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.rotationDegrees, rotationDegrees) ||
                other.rotationDegrees == rotationDegrees) &&
            (identical(other.selectedColor, selectedColor) ||
                other.selectedColor == selectedColor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    itemId,
    name,
    position,
    rotationDegrees,
    selectedColor,
  );

  /// Create a copy of FurniturePlacement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FurniturePlacementImplCopyWith<_$FurniturePlacementImpl> get copyWith =>
      __$$FurniturePlacementImplCopyWithImpl<_$FurniturePlacementImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$FurniturePlacementImplToJson(this);
  }
}

abstract class _FurniturePlacement implements FurniturePlacement {
  const factory _FurniturePlacement({
    required final String id,
    required final String itemId,
    required final String name,
    @OffsetConverter() required final Offset position,
    final double rotationDegrees,
    required final String selectedColor,
  }) = _$FurniturePlacementImpl;

  factory _FurniturePlacement.fromJson(Map<String, dynamic> json) =
      _$FurniturePlacementImpl.fromJson;

  @override
  String get id;
  @override
  String get itemId;
  @override
  String get name;
  @override
  @OffsetConverter()
  Offset get position;
  @override
  double get rotationDegrees;
  @override
  String get selectedColor;

  /// Create a copy of FurniturePlacement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FurniturePlacementImplCopyWith<_$FurniturePlacementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MaterialSelection _$MaterialSelectionFromJson(Map<String, dynamic> json) {
  return _MaterialSelection.fromJson(json);
}

/// @nodoc
mixin _$MaterialSelection {
  String get materialId => throw _privateConstructorUsedError;
  MaterialType get material => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  double get area => throw _privateConstructorUsedError;

  /// Serializes this MaterialSelection to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MaterialSelection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MaterialSelectionCopyWith<MaterialSelection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MaterialSelectionCopyWith<$Res> {
  factory $MaterialSelectionCopyWith(
    MaterialSelection value,
    $Res Function(MaterialSelection) then,
  ) = _$MaterialSelectionCopyWithImpl<$Res, MaterialSelection>;
  @useResult
  $Res call({
    String materialId,
    MaterialType material,
    String color,
    double price,
    double area,
  });
}

/// @nodoc
class _$MaterialSelectionCopyWithImpl<$Res, $Val extends MaterialSelection>
    implements $MaterialSelectionCopyWith<$Res> {
  _$MaterialSelectionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MaterialSelection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? materialId = null,
    Object? material = null,
    Object? color = null,
    Object? price = null,
    Object? area = null,
  }) {
    return _then(
      _value.copyWith(
            materialId: null == materialId
                ? _value.materialId
                : materialId // ignore: cast_nullable_to_non_nullable
                      as String,
            material: null == material
                ? _value.material
                : material // ignore: cast_nullable_to_non_nullable
                      as MaterialType,
            color: null == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                      as String,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as double,
            area: null == area
                ? _value.area
                : area // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MaterialSelectionImplCopyWith<$Res>
    implements $MaterialSelectionCopyWith<$Res> {
  factory _$$MaterialSelectionImplCopyWith(
    _$MaterialSelectionImpl value,
    $Res Function(_$MaterialSelectionImpl) then,
  ) = __$$MaterialSelectionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String materialId,
    MaterialType material,
    String color,
    double price,
    double area,
  });
}

/// @nodoc
class __$$MaterialSelectionImplCopyWithImpl<$Res>
    extends _$MaterialSelectionCopyWithImpl<$Res, _$MaterialSelectionImpl>
    implements _$$MaterialSelectionImplCopyWith<$Res> {
  __$$MaterialSelectionImplCopyWithImpl(
    _$MaterialSelectionImpl _value,
    $Res Function(_$MaterialSelectionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MaterialSelection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? materialId = null,
    Object? material = null,
    Object? color = null,
    Object? price = null,
    Object? area = null,
  }) {
    return _then(
      _$MaterialSelectionImpl(
        materialId: null == materialId
            ? _value.materialId
            : materialId // ignore: cast_nullable_to_non_nullable
                  as String,
        material: null == material
            ? _value.material
            : material // ignore: cast_nullable_to_non_nullable
                  as MaterialType,
        color: null == color
            ? _value.color
            : color // ignore: cast_nullable_to_non_nullable
                  as String,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as double,
        area: null == area
            ? _value.area
            : area // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MaterialSelectionImpl implements _MaterialSelection {
  const _$MaterialSelectionImpl({
    required this.materialId,
    required this.material,
    required this.color,
    required this.price,
    required this.area,
  });

  factory _$MaterialSelectionImpl.fromJson(Map<String, dynamic> json) =>
      _$$MaterialSelectionImplFromJson(json);

  @override
  final String materialId;
  @override
  final MaterialType material;
  @override
  final String color;
  @override
  final double price;
  @override
  final double area;

  @override
  String toString() {
    return 'MaterialSelection(materialId: $materialId, material: $material, color: $color, price: $price, area: $area)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MaterialSelectionImpl &&
            (identical(other.materialId, materialId) ||
                other.materialId == materialId) &&
            (identical(other.material, material) ||
                other.material == material) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.area, area) || other.area == area));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, materialId, material, color, price, area);

  /// Create a copy of MaterialSelection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MaterialSelectionImplCopyWith<_$MaterialSelectionImpl> get copyWith =>
      __$$MaterialSelectionImplCopyWithImpl<_$MaterialSelectionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MaterialSelectionImplToJson(this);
  }
}

abstract class _MaterialSelection implements MaterialSelection {
  const factory _MaterialSelection({
    required final String materialId,
    required final MaterialType material,
    required final String color,
    required final double price,
    required final double area,
  }) = _$MaterialSelectionImpl;

  factory _MaterialSelection.fromJson(Map<String, dynamic> json) =
      _$MaterialSelectionImpl.fromJson;

  @override
  String get materialId;
  @override
  MaterialType get material;
  @override
  String get color;
  @override
  double get price;
  @override
  double get area;

  /// Create a copy of MaterialSelection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MaterialSelectionImplCopyWith<_$MaterialSelectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DesignSelection _$DesignSelectionFromJson(Map<String, dynamic> json) {
  return _DesignSelection.fromJson(json);
}

/// @nodoc
mixin _$DesignSelection {
  String get id => throw _privateConstructorUsedError;
  String get roomId => throw _privateConstructorUsedError;
  DesignStage get stage => throw _privateConstructorUsedError;
  Map<String, MaterialSelection> get selections =>
      throw _privateConstructorUsedError;
  RoomCondition? get roomCondition => throw _privateConstructorUsedError;
  List<FurniturePlacement> get furniture => throw _privateConstructorUsedError;

  /// Serializes this DesignSelection to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DesignSelection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DesignSelectionCopyWith<DesignSelection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DesignSelectionCopyWith<$Res> {
  factory $DesignSelectionCopyWith(
    DesignSelection value,
    $Res Function(DesignSelection) then,
  ) = _$DesignSelectionCopyWithImpl<$Res, DesignSelection>;
  @useResult
  $Res call({
    String id,
    String roomId,
    DesignStage stage,
    Map<String, MaterialSelection> selections,
    RoomCondition? roomCondition,
    List<FurniturePlacement> furniture,
  });

  $RoomConditionCopyWith<$Res>? get roomCondition;
}

/// @nodoc
class _$DesignSelectionCopyWithImpl<$Res, $Val extends DesignSelection>
    implements $DesignSelectionCopyWith<$Res> {
  _$DesignSelectionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DesignSelection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roomId = null,
    Object? stage = null,
    Object? selections = null,
    Object? roomCondition = freezed,
    Object? furniture = null,
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
            stage: null == stage
                ? _value.stage
                : stage // ignore: cast_nullable_to_non_nullable
                      as DesignStage,
            selections: null == selections
                ? _value.selections
                : selections // ignore: cast_nullable_to_non_nullable
                      as Map<String, MaterialSelection>,
            roomCondition: freezed == roomCondition
                ? _value.roomCondition
                : roomCondition // ignore: cast_nullable_to_non_nullable
                      as RoomCondition?,
            furniture: null == furniture
                ? _value.furniture
                : furniture // ignore: cast_nullable_to_non_nullable
                      as List<FurniturePlacement>,
          )
          as $Val,
    );
  }

  /// Create a copy of DesignSelection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RoomConditionCopyWith<$Res>? get roomCondition {
    if (_value.roomCondition == null) {
      return null;
    }

    return $RoomConditionCopyWith<$Res>(_value.roomCondition!, (value) {
      return _then(_value.copyWith(roomCondition: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DesignSelectionImplCopyWith<$Res>
    implements $DesignSelectionCopyWith<$Res> {
  factory _$$DesignSelectionImplCopyWith(
    _$DesignSelectionImpl value,
    $Res Function(_$DesignSelectionImpl) then,
  ) = __$$DesignSelectionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String roomId,
    DesignStage stage,
    Map<String, MaterialSelection> selections,
    RoomCondition? roomCondition,
    List<FurniturePlacement> furniture,
  });

  @override
  $RoomConditionCopyWith<$Res>? get roomCondition;
}

/// @nodoc
class __$$DesignSelectionImplCopyWithImpl<$Res>
    extends _$DesignSelectionCopyWithImpl<$Res, _$DesignSelectionImpl>
    implements _$$DesignSelectionImplCopyWith<$Res> {
  __$$DesignSelectionImplCopyWithImpl(
    _$DesignSelectionImpl _value,
    $Res Function(_$DesignSelectionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DesignSelection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roomId = null,
    Object? stage = null,
    Object? selections = null,
    Object? roomCondition = freezed,
    Object? furniture = null,
  }) {
    return _then(
      _$DesignSelectionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        roomId: null == roomId
            ? _value.roomId
            : roomId // ignore: cast_nullable_to_non_nullable
                  as String,
        stage: null == stage
            ? _value.stage
            : stage // ignore: cast_nullable_to_non_nullable
                  as DesignStage,
        selections: null == selections
            ? _value._selections
            : selections // ignore: cast_nullable_to_non_nullable
                  as Map<String, MaterialSelection>,
        roomCondition: freezed == roomCondition
            ? _value.roomCondition
            : roomCondition // ignore: cast_nullable_to_non_nullable
                  as RoomCondition?,
        furniture: null == furniture
            ? _value._furniture
            : furniture // ignore: cast_nullable_to_non_nullable
                  as List<FurniturePlacement>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DesignSelectionImpl implements _DesignSelection {
  const _$DesignSelectionImpl({
    required this.id,
    required this.roomId,
    required this.stage,
    final Map<String, MaterialSelection> selections =
        const <String, MaterialSelection>{},
    this.roomCondition,
    final List<FurniturePlacement> furniture = const <FurniturePlacement>[],
  }) : _selections = selections,
       _furniture = furniture;

  factory _$DesignSelectionImpl.fromJson(Map<String, dynamic> json) =>
      _$$DesignSelectionImplFromJson(json);

  @override
  final String id;
  @override
  final String roomId;
  @override
  final DesignStage stage;
  final Map<String, MaterialSelection> _selections;
  @override
  @JsonKey()
  Map<String, MaterialSelection> get selections {
    if (_selections is EqualUnmodifiableMapView) return _selections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_selections);
  }

  @override
  final RoomCondition? roomCondition;
  final List<FurniturePlacement> _furniture;
  @override
  @JsonKey()
  List<FurniturePlacement> get furniture {
    if (_furniture is EqualUnmodifiableListView) return _furniture;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_furniture);
  }

  @override
  String toString() {
    return 'DesignSelection(id: $id, roomId: $roomId, stage: $stage, selections: $selections, roomCondition: $roomCondition, furniture: $furniture)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DesignSelectionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.stage, stage) || other.stage == stage) &&
            const DeepCollectionEquality().equals(
              other._selections,
              _selections,
            ) &&
            (identical(other.roomCondition, roomCondition) ||
                other.roomCondition == roomCondition) &&
            const DeepCollectionEquality().equals(
              other._furniture,
              _furniture,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    roomId,
    stage,
    const DeepCollectionEquality().hash(_selections),
    roomCondition,
    const DeepCollectionEquality().hash(_furniture),
  );

  /// Create a copy of DesignSelection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DesignSelectionImplCopyWith<_$DesignSelectionImpl> get copyWith =>
      __$$DesignSelectionImplCopyWithImpl<_$DesignSelectionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DesignSelectionImplToJson(this);
  }
}

abstract class _DesignSelection implements DesignSelection {
  const factory _DesignSelection({
    required final String id,
    required final String roomId,
    required final DesignStage stage,
    final Map<String, MaterialSelection> selections,
    final RoomCondition? roomCondition,
    final List<FurniturePlacement> furniture,
  }) = _$DesignSelectionImpl;

  factory _DesignSelection.fromJson(Map<String, dynamic> json) =
      _$DesignSelectionImpl.fromJson;

  @override
  String get id;
  @override
  String get roomId;
  @override
  DesignStage get stage;
  @override
  Map<String, MaterialSelection> get selections;
  @override
  RoomCondition? get roomCondition;
  @override
  List<FurniturePlacement> get furniture;

  /// Create a copy of DesignSelection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DesignSelectionImplCopyWith<_$DesignSelectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
