// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room_create.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WallElementCreate _$WallElementCreateFromJson(Map<String, dynamic> json) {
  return _WallElementCreate.fromJson(json);
}

/// @nodoc
mixin _$WallElementCreate {
  WallElementType get type => throw _privateConstructorUsedError;
  double get width => throw _privateConstructorUsedError;
  double get height => throw _privateConstructorUsedError;
  @JsonKey(name: 'sill_height')
  double get sillHeight => throw _privateConstructorUsedError;
  double get position => throw _privateConstructorUsedError;

  /// Serializes this WallElementCreate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WallElementCreate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WallElementCreateCopyWith<WallElementCreate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WallElementCreateCopyWith<$Res> {
  factory $WallElementCreateCopyWith(
    WallElementCreate value,
    $Res Function(WallElementCreate) then,
  ) = _$WallElementCreateCopyWithImpl<$Res, WallElementCreate>;
  @useResult
  $Res call({
    WallElementType type,
    double width,
    double height,
    @JsonKey(name: 'sill_height') double sillHeight,
    double position,
  });
}

/// @nodoc
class _$WallElementCreateCopyWithImpl<$Res, $Val extends WallElementCreate>
    implements $WallElementCreateCopyWith<$Res> {
  _$WallElementCreateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WallElementCreate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? width = null,
    Object? height = null,
    Object? sillHeight = null,
    Object? position = null,
  }) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as WallElementType,
            width: null == width
                ? _value.width
                : width // ignore: cast_nullable_to_non_nullable
                      as double,
            height: null == height
                ? _value.height
                : height // ignore: cast_nullable_to_non_nullable
                      as double,
            sillHeight: null == sillHeight
                ? _value.sillHeight
                : sillHeight // ignore: cast_nullable_to_non_nullable
                      as double,
            position: null == position
                ? _value.position
                : position // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WallElementCreateImplCopyWith<$Res>
    implements $WallElementCreateCopyWith<$Res> {
  factory _$$WallElementCreateImplCopyWith(
    _$WallElementCreateImpl value,
    $Res Function(_$WallElementCreateImpl) then,
  ) = __$$WallElementCreateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    WallElementType type,
    double width,
    double height,
    @JsonKey(name: 'sill_height') double sillHeight,
    double position,
  });
}

/// @nodoc
class __$$WallElementCreateImplCopyWithImpl<$Res>
    extends _$WallElementCreateCopyWithImpl<$Res, _$WallElementCreateImpl>
    implements _$$WallElementCreateImplCopyWith<$Res> {
  __$$WallElementCreateImplCopyWithImpl(
    _$WallElementCreateImpl _value,
    $Res Function(_$WallElementCreateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WallElementCreate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? width = null,
    Object? height = null,
    Object? sillHeight = null,
    Object? position = null,
  }) {
    return _then(
      _$WallElementCreateImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as WallElementType,
        width: null == width
            ? _value.width
            : width // ignore: cast_nullable_to_non_nullable
                  as double,
        height: null == height
            ? _value.height
            : height // ignore: cast_nullable_to_non_nullable
                  as double,
        sillHeight: null == sillHeight
            ? _value.sillHeight
            : sillHeight // ignore: cast_nullable_to_non_nullable
                  as double,
        position: null == position
            ? _value.position
            : position // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WallElementCreateImpl implements _WallElementCreate {
  const _$WallElementCreateImpl({
    required this.type,
    required this.width,
    required this.height,
    @JsonKey(name: 'sill_height') this.sillHeight = 0.0,
    this.position = 0.5,
  });

  factory _$WallElementCreateImpl.fromJson(Map<String, dynamic> json) =>
      _$$WallElementCreateImplFromJson(json);

  @override
  final WallElementType type;
  @override
  final double width;
  @override
  final double height;
  @override
  @JsonKey(name: 'sill_height')
  final double sillHeight;
  @override
  @JsonKey()
  final double position;

  @override
  String toString() {
    return 'WallElementCreate(type: $type, width: $width, height: $height, sillHeight: $sillHeight, position: $position)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WallElementCreateImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.sillHeight, sillHeight) ||
                other.sillHeight == sillHeight) &&
            (identical(other.position, position) ||
                other.position == position));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, type, width, height, sillHeight, position);

  /// Create a copy of WallElementCreate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WallElementCreateImplCopyWith<_$WallElementCreateImpl> get copyWith =>
      __$$WallElementCreateImplCopyWithImpl<_$WallElementCreateImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$WallElementCreateImplToJson(this);
  }
}

abstract class _WallElementCreate implements WallElementCreate {
  const factory _WallElementCreate({
    required final WallElementType type,
    required final double width,
    required final double height,
    @JsonKey(name: 'sill_height') final double sillHeight,
    final double position,
  }) = _$WallElementCreateImpl;

  factory _WallElementCreate.fromJson(Map<String, dynamic> json) =
      _$WallElementCreateImpl.fromJson;

  @override
  WallElementType get type;
  @override
  double get width;
  @override
  double get height;
  @override
  @JsonKey(name: 'sill_height')
  double get sillHeight;
  @override
  double get position;

  /// Create a copy of WallElementCreate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WallElementCreateImplCopyWith<_$WallElementCreateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WallCreate _$WallCreateFromJson(Map<String, dynamic> json) {
  return _WallCreate.fromJson(json);
}

/// @nodoc
mixin _$WallCreate {
  String get id => throw _privateConstructorUsedError;
  double get length => throw _privateConstructorUsedError;
  List<WallElementCreate> get elements => throw _privateConstructorUsedError;

  /// Serializes this WallCreate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WallCreate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WallCreateCopyWith<WallCreate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WallCreateCopyWith<$Res> {
  factory $WallCreateCopyWith(
    WallCreate value,
    $Res Function(WallCreate) then,
  ) = _$WallCreateCopyWithImpl<$Res, WallCreate>;
  @useResult
  $Res call({String id, double length, List<WallElementCreate> elements});
}

/// @nodoc
class _$WallCreateCopyWithImpl<$Res, $Val extends WallCreate>
    implements $WallCreateCopyWith<$Res> {
  _$WallCreateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WallCreate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? length = null,
    Object? elements = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            length: null == length
                ? _value.length
                : length // ignore: cast_nullable_to_non_nullable
                      as double,
            elements: null == elements
                ? _value.elements
                : elements // ignore: cast_nullable_to_non_nullable
                      as List<WallElementCreate>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WallCreateImplCopyWith<$Res>
    implements $WallCreateCopyWith<$Res> {
  factory _$$WallCreateImplCopyWith(
    _$WallCreateImpl value,
    $Res Function(_$WallCreateImpl) then,
  ) = __$$WallCreateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, double length, List<WallElementCreate> elements});
}

/// @nodoc
class __$$WallCreateImplCopyWithImpl<$Res>
    extends _$WallCreateCopyWithImpl<$Res, _$WallCreateImpl>
    implements _$$WallCreateImplCopyWith<$Res> {
  __$$WallCreateImplCopyWithImpl(
    _$WallCreateImpl _value,
    $Res Function(_$WallCreateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WallCreate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? length = null,
    Object? elements = null,
  }) {
    return _then(
      _$WallCreateImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        length: null == length
            ? _value.length
            : length // ignore: cast_nullable_to_non_nullable
                  as double,
        elements: null == elements
            ? _value._elements
            : elements // ignore: cast_nullable_to_non_nullable
                  as List<WallElementCreate>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WallCreateImpl implements _WallCreate {
  const _$WallCreateImpl({
    required this.id,
    required this.length,
    final List<WallElementCreate> elements = const <WallElementCreate>[],
  }) : _elements = elements;

  factory _$WallCreateImpl.fromJson(Map<String, dynamic> json) =>
      _$$WallCreateImplFromJson(json);

  @override
  final String id;
  @override
  final double length;
  final List<WallElementCreate> _elements;
  @override
  @JsonKey()
  List<WallElementCreate> get elements {
    if (_elements is EqualUnmodifiableListView) return _elements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_elements);
  }

  @override
  String toString() {
    return 'WallCreate(id: $id, length: $length, elements: $elements)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WallCreateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.length, length) || other.length == length) &&
            const DeepCollectionEquality().equals(other._elements, _elements));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    length,
    const DeepCollectionEquality().hash(_elements),
  );

  /// Create a copy of WallCreate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WallCreateImplCopyWith<_$WallCreateImpl> get copyWith =>
      __$$WallCreateImplCopyWithImpl<_$WallCreateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WallCreateImplToJson(this);
  }
}

abstract class _WallCreate implements WallCreate {
  const factory _WallCreate({
    required final String id,
    required final double length,
    final List<WallElementCreate> elements,
  }) = _$WallCreateImpl;

  factory _WallCreate.fromJson(Map<String, dynamic> json) =
      _$WallCreateImpl.fromJson;

  @override
  String get id;
  @override
  double get length;
  @override
  List<WallElementCreate> get elements;

  /// Create a copy of WallCreate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WallCreateImplCopyWith<_$WallCreateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RoomGeometryCreate _$RoomGeometryCreateFromJson(Map<String, dynamic> json) {
  return _RoomGeometryCreate.fromJson(json);
}

/// @nodoc
mixin _$RoomGeometryCreate {
  List<WallCreate> get walls => throw _privateConstructorUsedError;
  @JsonKey(name: 'vertices', includeIfNull: false)
  List<List<double>>? get vertices => throw _privateConstructorUsedError;

  /// Serializes this RoomGeometryCreate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RoomGeometryCreate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoomGeometryCreateCopyWith<RoomGeometryCreate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomGeometryCreateCopyWith<$Res> {
  factory $RoomGeometryCreateCopyWith(
    RoomGeometryCreate value,
    $Res Function(RoomGeometryCreate) then,
  ) = _$RoomGeometryCreateCopyWithImpl<$Res, RoomGeometryCreate>;
  @useResult
  $Res call({
    List<WallCreate> walls,
    @JsonKey(name: 'vertices', includeIfNull: false)
    List<List<double>>? vertices,
  });
}

/// @nodoc
class _$RoomGeometryCreateCopyWithImpl<$Res, $Val extends RoomGeometryCreate>
    implements $RoomGeometryCreateCopyWith<$Res> {
  _$RoomGeometryCreateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RoomGeometryCreate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? walls = null, Object? vertices = freezed}) {
    return _then(
      _value.copyWith(
            walls: null == walls
                ? _value.walls
                : walls // ignore: cast_nullable_to_non_nullable
                      as List<WallCreate>,
            vertices: freezed == vertices
                ? _value.vertices
                : vertices // ignore: cast_nullable_to_non_nullable
                      as List<List<double>>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RoomGeometryCreateImplCopyWith<$Res>
    implements $RoomGeometryCreateCopyWith<$Res> {
  factory _$$RoomGeometryCreateImplCopyWith(
    _$RoomGeometryCreateImpl value,
    $Res Function(_$RoomGeometryCreateImpl) then,
  ) = __$$RoomGeometryCreateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<WallCreate> walls,
    @JsonKey(name: 'vertices', includeIfNull: false)
    List<List<double>>? vertices,
  });
}

/// @nodoc
class __$$RoomGeometryCreateImplCopyWithImpl<$Res>
    extends _$RoomGeometryCreateCopyWithImpl<$Res, _$RoomGeometryCreateImpl>
    implements _$$RoomGeometryCreateImplCopyWith<$Res> {
  __$$RoomGeometryCreateImplCopyWithImpl(
    _$RoomGeometryCreateImpl _value,
    $Res Function(_$RoomGeometryCreateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RoomGeometryCreate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? walls = null, Object? vertices = freezed}) {
    return _then(
      _$RoomGeometryCreateImpl(
        walls: null == walls
            ? _value._walls
            : walls // ignore: cast_nullable_to_non_nullable
                  as List<WallCreate>,
        vertices: freezed == vertices
            ? _value._vertices
            : vertices // ignore: cast_nullable_to_non_nullable
                  as List<List<double>>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RoomGeometryCreateImpl implements _RoomGeometryCreate {
  const _$RoomGeometryCreateImpl({
    required final List<WallCreate> walls,
    @JsonKey(name: 'vertices', includeIfNull: false)
    final List<List<double>>? vertices,
  }) : _walls = walls,
       _vertices = vertices;

  factory _$RoomGeometryCreateImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoomGeometryCreateImplFromJson(json);

  final List<WallCreate> _walls;
  @override
  List<WallCreate> get walls {
    if (_walls is EqualUnmodifiableListView) return _walls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_walls);
  }

  final List<List<double>>? _vertices;
  @override
  @JsonKey(name: 'vertices', includeIfNull: false)
  List<List<double>>? get vertices {
    final value = _vertices;
    if (value == null) return null;
    if (_vertices is EqualUnmodifiableListView) return _vertices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'RoomGeometryCreate(walls: $walls, vertices: $vertices)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomGeometryCreateImpl &&
            const DeepCollectionEquality().equals(other._walls, _walls) &&
            const DeepCollectionEquality().equals(other._vertices, _vertices));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_walls),
    const DeepCollectionEquality().hash(_vertices),
  );

  /// Create a copy of RoomGeometryCreate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomGeometryCreateImplCopyWith<_$RoomGeometryCreateImpl> get copyWith =>
      __$$RoomGeometryCreateImplCopyWithImpl<_$RoomGeometryCreateImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RoomGeometryCreateImplToJson(this);
  }
}

abstract class _RoomGeometryCreate implements RoomGeometryCreate {
  const factory _RoomGeometryCreate({
    required final List<WallCreate> walls,
    @JsonKey(name: 'vertices', includeIfNull: false)
    final List<List<double>>? vertices,
  }) = _$RoomGeometryCreateImpl;

  factory _RoomGeometryCreate.fromJson(Map<String, dynamic> json) =
      _$RoomGeometryCreateImpl.fromJson;

  @override
  List<WallCreate> get walls;
  @override
  @JsonKey(name: 'vertices', includeIfNull: false)
  List<List<double>>? get vertices;

  /// Create a copy of RoomGeometryCreate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoomGeometryCreateImplCopyWith<_$RoomGeometryCreateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RoomCreate _$RoomCreateFromJson(Map<String, dynamic> json) {
  return _RoomCreate.fromJson(json);
}

/// @nodoc
mixin _$RoomCreate {
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'ceiling_h')
  double get ceilingH => throw _privateConstructorUsedError;
  RoomGeometryCreate get geometry => throw _privateConstructorUsedError;

  /// Serializes this RoomCreate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RoomCreate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoomCreateCopyWith<RoomCreate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomCreateCopyWith<$Res> {
  factory $RoomCreateCopyWith(
    RoomCreate value,
    $Res Function(RoomCreate) then,
  ) = _$RoomCreateCopyWithImpl<$Res, RoomCreate>;
  @useResult
  $Res call({
    String name,
    @JsonKey(name: 'ceiling_h') double ceilingH,
    RoomGeometryCreate geometry,
  });

  $RoomGeometryCreateCopyWith<$Res> get geometry;
}

/// @nodoc
class _$RoomCreateCopyWithImpl<$Res, $Val extends RoomCreate>
    implements $RoomCreateCopyWith<$Res> {
  _$RoomCreateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RoomCreate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? ceilingH = null,
    Object? geometry = null,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            ceilingH: null == ceilingH
                ? _value.ceilingH
                : ceilingH // ignore: cast_nullable_to_non_nullable
                      as double,
            geometry: null == geometry
                ? _value.geometry
                : geometry // ignore: cast_nullable_to_non_nullable
                      as RoomGeometryCreate,
          )
          as $Val,
    );
  }

  /// Create a copy of RoomCreate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RoomGeometryCreateCopyWith<$Res> get geometry {
    return $RoomGeometryCreateCopyWith<$Res>(_value.geometry, (value) {
      return _then(_value.copyWith(geometry: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RoomCreateImplCopyWith<$Res>
    implements $RoomCreateCopyWith<$Res> {
  factory _$$RoomCreateImplCopyWith(
    _$RoomCreateImpl value,
    $Res Function(_$RoomCreateImpl) then,
  ) = __$$RoomCreateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    @JsonKey(name: 'ceiling_h') double ceilingH,
    RoomGeometryCreate geometry,
  });

  @override
  $RoomGeometryCreateCopyWith<$Res> get geometry;
}

/// @nodoc
class __$$RoomCreateImplCopyWithImpl<$Res>
    extends _$RoomCreateCopyWithImpl<$Res, _$RoomCreateImpl>
    implements _$$RoomCreateImplCopyWith<$Res> {
  __$$RoomCreateImplCopyWithImpl(
    _$RoomCreateImpl _value,
    $Res Function(_$RoomCreateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RoomCreate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? ceilingH = null,
    Object? geometry = null,
  }) {
    return _then(
      _$RoomCreateImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        ceilingH: null == ceilingH
            ? _value.ceilingH
            : ceilingH // ignore: cast_nullable_to_non_nullable
                  as double,
        geometry: null == geometry
            ? _value.geometry
            : geometry // ignore: cast_nullable_to_non_nullable
                  as RoomGeometryCreate,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RoomCreateImpl implements _RoomCreate {
  const _$RoomCreateImpl({
    required this.name,
    @JsonKey(name: 'ceiling_h') required this.ceilingH,
    required this.geometry,
  });

  factory _$RoomCreateImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoomCreateImplFromJson(json);

  @override
  final String name;
  @override
  @JsonKey(name: 'ceiling_h')
  final double ceilingH;
  @override
  final RoomGeometryCreate geometry;

  @override
  String toString() {
    return 'RoomCreate(name: $name, ceilingH: $ceilingH, geometry: $geometry)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomCreateImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.ceilingH, ceilingH) ||
                other.ceilingH == ceilingH) &&
            (identical(other.geometry, geometry) ||
                other.geometry == geometry));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, ceilingH, geometry);

  /// Create a copy of RoomCreate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomCreateImplCopyWith<_$RoomCreateImpl> get copyWith =>
      __$$RoomCreateImplCopyWithImpl<_$RoomCreateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoomCreateImplToJson(this);
  }
}

abstract class _RoomCreate implements RoomCreate {
  const factory _RoomCreate({
    required final String name,
    @JsonKey(name: 'ceiling_h') required final double ceilingH,
    required final RoomGeometryCreate geometry,
  }) = _$RoomCreateImpl;

  factory _RoomCreate.fromJson(Map<String, dynamic> json) =
      _$RoomCreateImpl.fromJson;

  @override
  String get name;
  @override
  @JsonKey(name: 'ceiling_h')
  double get ceilingH;
  @override
  RoomGeometryCreate get geometry;

  /// Create a copy of RoomCreate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoomCreateImplCopyWith<_$RoomCreateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
