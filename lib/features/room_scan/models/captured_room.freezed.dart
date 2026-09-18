// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'captured_room.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Vec3 {
  double get x => throw _privateConstructorUsedError;
  double get y => throw _privateConstructorUsedError;
  double get z => throw _privateConstructorUsedError;

  /// Create a copy of Vec3
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $Vec3CopyWith<Vec3> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Vec3CopyWith<$Res> {
  factory $Vec3CopyWith(Vec3 value, $Res Function(Vec3) then) =
      _$Vec3CopyWithImpl<$Res, Vec3>;
  @useResult
  $Res call({double x, double y, double z});
}

/// @nodoc
class _$Vec3CopyWithImpl<$Res, $Val extends Vec3>
    implements $Vec3CopyWith<$Res> {
  _$Vec3CopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Vec3
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? x = null, Object? y = null, Object? z = null}) {
    return _then(
      _value.copyWith(
            x: null == x
                ? _value.x
                : x // ignore: cast_nullable_to_non_nullable
                      as double,
            y: null == y
                ? _value.y
                : y // ignore: cast_nullable_to_non_nullable
                      as double,
            z: null == z
                ? _value.z
                : z // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$Vec3ImplCopyWith<$Res> implements $Vec3CopyWith<$Res> {
  factory _$$Vec3ImplCopyWith(
    _$Vec3Impl value,
    $Res Function(_$Vec3Impl) then,
  ) = __$$Vec3ImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double x, double y, double z});
}

/// @nodoc
class __$$Vec3ImplCopyWithImpl<$Res>
    extends _$Vec3CopyWithImpl<$Res, _$Vec3Impl>
    implements _$$Vec3ImplCopyWith<$Res> {
  __$$Vec3ImplCopyWithImpl(_$Vec3Impl _value, $Res Function(_$Vec3Impl) _then)
    : super(_value, _then);

  /// Create a copy of Vec3
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? x = null, Object? y = null, Object? z = null}) {
    return _then(
      _$Vec3Impl(
        null == x
            ? _value.x
            : x // ignore: cast_nullable_to_non_nullable
                  as double,
        null == y
            ? _value.y
            : y // ignore: cast_nullable_to_non_nullable
                  as double,
        null == z
            ? _value.z
            : z // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc

class _$Vec3Impl implements _Vec3 {
  const _$Vec3Impl(this.x, this.y, this.z);

  @override
  final double x;
  @override
  final double y;
  @override
  final double z;

  @override
  String toString() {
    return 'Vec3(x: $x, y: $y, z: $z)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Vec3Impl &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y) &&
            (identical(other.z, z) || other.z == z));
  }

  @override
  int get hashCode => Object.hash(runtimeType, x, y, z);

  /// Create a copy of Vec3
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Vec3ImplCopyWith<_$Vec3Impl> get copyWith =>
      __$$Vec3ImplCopyWithImpl<_$Vec3Impl>(this, _$identity);
}

abstract class _Vec3 implements Vec3 {
  const factory _Vec3(final double x, final double y, final double z) =
      _$Vec3Impl;

  @override
  double get x;
  @override
  double get y;
  @override
  double get z;

  /// Create a copy of Vec3
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Vec3ImplCopyWith<_$Vec3Impl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ScanTransform {
  List<double> get m => throw _privateConstructorUsedError;

  /// Create a copy of ScanTransform
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScanTransformCopyWith<ScanTransform> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScanTransformCopyWith<$Res> {
  factory $ScanTransformCopyWith(
    ScanTransform value,
    $Res Function(ScanTransform) then,
  ) = _$ScanTransformCopyWithImpl<$Res, ScanTransform>;
  @useResult
  $Res call({List<double> m});
}

/// @nodoc
class _$ScanTransformCopyWithImpl<$Res, $Val extends ScanTransform>
    implements $ScanTransformCopyWith<$Res> {
  _$ScanTransformCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScanTransform
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? m = null}) {
    return _then(
      _value.copyWith(
            m: null == m
                ? _value.m
                : m // ignore: cast_nullable_to_non_nullable
                      as List<double>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ScanTransformImplCopyWith<$Res>
    implements $ScanTransformCopyWith<$Res> {
  factory _$$ScanTransformImplCopyWith(
    _$ScanTransformImpl value,
    $Res Function(_$ScanTransformImpl) then,
  ) = __$$ScanTransformImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<double> m});
}

/// @nodoc
class __$$ScanTransformImplCopyWithImpl<$Res>
    extends _$ScanTransformCopyWithImpl<$Res, _$ScanTransformImpl>
    implements _$$ScanTransformImplCopyWith<$Res> {
  __$$ScanTransformImplCopyWithImpl(
    _$ScanTransformImpl _value,
    $Res Function(_$ScanTransformImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ScanTransform
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? m = null}) {
    return _then(
      _$ScanTransformImpl(
        null == m
            ? _value._m
            : m // ignore: cast_nullable_to_non_nullable
                  as List<double>,
      ),
    );
  }
}

/// @nodoc

class _$ScanTransformImpl extends _ScanTransform {
  const _$ScanTransformImpl(final List<double> m) : _m = m, super._();

  final List<double> _m;
  @override
  List<double> get m {
    if (_m is EqualUnmodifiableListView) return _m;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_m);
  }

  @override
  String toString() {
    return 'ScanTransform(m: $m)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScanTransformImpl &&
            const DeepCollectionEquality().equals(other._m, _m));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_m));

  /// Create a copy of ScanTransform
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScanTransformImplCopyWith<_$ScanTransformImpl> get copyWith =>
      __$$ScanTransformImplCopyWithImpl<_$ScanTransformImpl>(this, _$identity);
}

abstract class _ScanTransform extends ScanTransform {
  const factory _ScanTransform(final List<double> m) = _$ScanTransformImpl;
  const _ScanTransform._() : super._();

  @override
  List<double> get m;

  /// Create a copy of ScanTransform
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScanTransformImplCopyWith<_$ScanTransformImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ScanSurface {
  Vec3 get dimensions => throw _privateConstructorUsedError;
  ScanTransform get transform => throw _privateConstructorUsedError;
  ScanConfidence get confidence => throw _privateConstructorUsedError;

  /// Create a copy of ScanSurface
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScanSurfaceCopyWith<ScanSurface> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScanSurfaceCopyWith<$Res> {
  factory $ScanSurfaceCopyWith(
    ScanSurface value,
    $Res Function(ScanSurface) then,
  ) = _$ScanSurfaceCopyWithImpl<$Res, ScanSurface>;
  @useResult
  $Res call({
    Vec3 dimensions,
    ScanTransform transform,
    ScanConfidence confidence,
  });

  $Vec3CopyWith<$Res> get dimensions;
  $ScanTransformCopyWith<$Res> get transform;
}

/// @nodoc
class _$ScanSurfaceCopyWithImpl<$Res, $Val extends ScanSurface>
    implements $ScanSurfaceCopyWith<$Res> {
  _$ScanSurfaceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScanSurface
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dimensions = null,
    Object? transform = null,
    Object? confidence = null,
  }) {
    return _then(
      _value.copyWith(
            dimensions: null == dimensions
                ? _value.dimensions
                : dimensions // ignore: cast_nullable_to_non_nullable
                      as Vec3,
            transform: null == transform
                ? _value.transform
                : transform // ignore: cast_nullable_to_non_nullable
                      as ScanTransform,
            confidence: null == confidence
                ? _value.confidence
                : confidence // ignore: cast_nullable_to_non_nullable
                      as ScanConfidence,
          )
          as $Val,
    );
  }

  /// Create a copy of ScanSurface
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Vec3CopyWith<$Res> get dimensions {
    return $Vec3CopyWith<$Res>(_value.dimensions, (value) {
      return _then(_value.copyWith(dimensions: value) as $Val);
    });
  }

  /// Create a copy of ScanSurface
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ScanTransformCopyWith<$Res> get transform {
    return $ScanTransformCopyWith<$Res>(_value.transform, (value) {
      return _then(_value.copyWith(transform: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ScanSurfaceImplCopyWith<$Res>
    implements $ScanSurfaceCopyWith<$Res> {
  factory _$$ScanSurfaceImplCopyWith(
    _$ScanSurfaceImpl value,
    $Res Function(_$ScanSurfaceImpl) then,
  ) = __$$ScanSurfaceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Vec3 dimensions,
    ScanTransform transform,
    ScanConfidence confidence,
  });

  @override
  $Vec3CopyWith<$Res> get dimensions;
  @override
  $ScanTransformCopyWith<$Res> get transform;
}

/// @nodoc
class __$$ScanSurfaceImplCopyWithImpl<$Res>
    extends _$ScanSurfaceCopyWithImpl<$Res, _$ScanSurfaceImpl>
    implements _$$ScanSurfaceImplCopyWith<$Res> {
  __$$ScanSurfaceImplCopyWithImpl(
    _$ScanSurfaceImpl _value,
    $Res Function(_$ScanSurfaceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ScanSurface
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dimensions = null,
    Object? transform = null,
    Object? confidence = null,
  }) {
    return _then(
      _$ScanSurfaceImpl(
        dimensions: null == dimensions
            ? _value.dimensions
            : dimensions // ignore: cast_nullable_to_non_nullable
                  as Vec3,
        transform: null == transform
            ? _value.transform
            : transform // ignore: cast_nullable_to_non_nullable
                  as ScanTransform,
        confidence: null == confidence
            ? _value.confidence
            : confidence // ignore: cast_nullable_to_non_nullable
                  as ScanConfidence,
      ),
    );
  }
}

/// @nodoc

class _$ScanSurfaceImpl implements _ScanSurface {
  const _$ScanSurfaceImpl({
    required this.dimensions,
    required this.transform,
    this.confidence = ScanConfidence.medium,
  });

  @override
  final Vec3 dimensions;
  @override
  final ScanTransform transform;
  @override
  @JsonKey()
  final ScanConfidence confidence;

  @override
  String toString() {
    return 'ScanSurface(dimensions: $dimensions, transform: $transform, confidence: $confidence)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScanSurfaceImpl &&
            (identical(other.dimensions, dimensions) ||
                other.dimensions == dimensions) &&
            (identical(other.transform, transform) ||
                other.transform == transform) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, dimensions, transform, confidence);

  /// Create a copy of ScanSurface
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScanSurfaceImplCopyWith<_$ScanSurfaceImpl> get copyWith =>
      __$$ScanSurfaceImplCopyWithImpl<_$ScanSurfaceImpl>(this, _$identity);
}

abstract class _ScanSurface implements ScanSurface {
  const factory _ScanSurface({
    required final Vec3 dimensions,
    required final ScanTransform transform,
    final ScanConfidence confidence,
  }) = _$ScanSurfaceImpl;

  @override
  Vec3 get dimensions;
  @override
  ScanTransform get transform;
  @override
  ScanConfidence get confidence;

  /// Create a copy of ScanSurface
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScanSurfaceImplCopyWith<_$ScanSurfaceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ScanObject {
  ScanObjectCategory get category => throw _privateConstructorUsedError;
  Vec3 get dimensions => throw _privateConstructorUsedError;
  ScanTransform get transform => throw _privateConstructorUsedError;
  ScanConfidence get confidence => throw _privateConstructorUsedError;

  /// Create a copy of ScanObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScanObjectCopyWith<ScanObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScanObjectCopyWith<$Res> {
  factory $ScanObjectCopyWith(
    ScanObject value,
    $Res Function(ScanObject) then,
  ) = _$ScanObjectCopyWithImpl<$Res, ScanObject>;
  @useResult
  $Res call({
    ScanObjectCategory category,
    Vec3 dimensions,
    ScanTransform transform,
    ScanConfidence confidence,
  });

  $Vec3CopyWith<$Res> get dimensions;
  $ScanTransformCopyWith<$Res> get transform;
}

/// @nodoc
class _$ScanObjectCopyWithImpl<$Res, $Val extends ScanObject>
    implements $ScanObjectCopyWith<$Res> {
  _$ScanObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScanObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = null,
    Object? dimensions = null,
    Object? transform = null,
    Object? confidence = null,
  }) {
    return _then(
      _value.copyWith(
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as ScanObjectCategory,
            dimensions: null == dimensions
                ? _value.dimensions
                : dimensions // ignore: cast_nullable_to_non_nullable
                      as Vec3,
            transform: null == transform
                ? _value.transform
                : transform // ignore: cast_nullable_to_non_nullable
                      as ScanTransform,
            confidence: null == confidence
                ? _value.confidence
                : confidence // ignore: cast_nullable_to_non_nullable
                      as ScanConfidence,
          )
          as $Val,
    );
  }

  /// Create a copy of ScanObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Vec3CopyWith<$Res> get dimensions {
    return $Vec3CopyWith<$Res>(_value.dimensions, (value) {
      return _then(_value.copyWith(dimensions: value) as $Val);
    });
  }

  /// Create a copy of ScanObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ScanTransformCopyWith<$Res> get transform {
    return $ScanTransformCopyWith<$Res>(_value.transform, (value) {
      return _then(_value.copyWith(transform: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ScanObjectImplCopyWith<$Res>
    implements $ScanObjectCopyWith<$Res> {
  factory _$$ScanObjectImplCopyWith(
    _$ScanObjectImpl value,
    $Res Function(_$ScanObjectImpl) then,
  ) = __$$ScanObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    ScanObjectCategory category,
    Vec3 dimensions,
    ScanTransform transform,
    ScanConfidence confidence,
  });

  @override
  $Vec3CopyWith<$Res> get dimensions;
  @override
  $ScanTransformCopyWith<$Res> get transform;
}

/// @nodoc
class __$$ScanObjectImplCopyWithImpl<$Res>
    extends _$ScanObjectCopyWithImpl<$Res, _$ScanObjectImpl>
    implements _$$ScanObjectImplCopyWith<$Res> {
  __$$ScanObjectImplCopyWithImpl(
    _$ScanObjectImpl _value,
    $Res Function(_$ScanObjectImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ScanObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = null,
    Object? dimensions = null,
    Object? transform = null,
    Object? confidence = null,
  }) {
    return _then(
      _$ScanObjectImpl(
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as ScanObjectCategory,
        dimensions: null == dimensions
            ? _value.dimensions
            : dimensions // ignore: cast_nullable_to_non_nullable
                  as Vec3,
        transform: null == transform
            ? _value.transform
            : transform // ignore: cast_nullable_to_non_nullable
                  as ScanTransform,
        confidence: null == confidence
            ? _value.confidence
            : confidence // ignore: cast_nullable_to_non_nullable
                  as ScanConfidence,
      ),
    );
  }
}

/// @nodoc

class _$ScanObjectImpl implements _ScanObject {
  const _$ScanObjectImpl({
    required this.category,
    required this.dimensions,
    required this.transform,
    this.confidence = ScanConfidence.medium,
  });

  @override
  final ScanObjectCategory category;
  @override
  final Vec3 dimensions;
  @override
  final ScanTransform transform;
  @override
  @JsonKey()
  final ScanConfidence confidence;

  @override
  String toString() {
    return 'ScanObject(category: $category, dimensions: $dimensions, transform: $transform, confidence: $confidence)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScanObjectImpl &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.dimensions, dimensions) ||
                other.dimensions == dimensions) &&
            (identical(other.transform, transform) ||
                other.transform == transform) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, category, dimensions, transform, confidence);

  /// Create a copy of ScanObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScanObjectImplCopyWith<_$ScanObjectImpl> get copyWith =>
      __$$ScanObjectImplCopyWithImpl<_$ScanObjectImpl>(this, _$identity);
}

abstract class _ScanObject implements ScanObject {
  const factory _ScanObject({
    required final ScanObjectCategory category,
    required final Vec3 dimensions,
    required final ScanTransform transform,
    final ScanConfidence confidence,
  }) = _$ScanObjectImpl;

  @override
  ScanObjectCategory get category;
  @override
  Vec3 get dimensions;
  @override
  ScanTransform get transform;
  @override
  ScanConfidence get confidence;

  /// Create a copy of ScanObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScanObjectImplCopyWith<_$ScanObjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CapturedRoom {
  List<ScanSurface> get walls => throw _privateConstructorUsedError;
  List<ScanSurface> get doors => throw _privateConstructorUsedError;
  List<ScanSurface> get windows => throw _privateConstructorUsedError;
  List<ScanSurface> get openings => throw _privateConstructorUsedError;
  List<ScanObject> get objects => throw _privateConstructorUsedError;

  /// Create a copy of CapturedRoom
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CapturedRoomCopyWith<CapturedRoom> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CapturedRoomCopyWith<$Res> {
  factory $CapturedRoomCopyWith(
    CapturedRoom value,
    $Res Function(CapturedRoom) then,
  ) = _$CapturedRoomCopyWithImpl<$Res, CapturedRoom>;
  @useResult
  $Res call({
    List<ScanSurface> walls,
    List<ScanSurface> doors,
    List<ScanSurface> windows,
    List<ScanSurface> openings,
    List<ScanObject> objects,
  });
}

/// @nodoc
class _$CapturedRoomCopyWithImpl<$Res, $Val extends CapturedRoom>
    implements $CapturedRoomCopyWith<$Res> {
  _$CapturedRoomCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CapturedRoom
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? walls = null,
    Object? doors = null,
    Object? windows = null,
    Object? openings = null,
    Object? objects = null,
  }) {
    return _then(
      _value.copyWith(
            walls: null == walls
                ? _value.walls
                : walls // ignore: cast_nullable_to_non_nullable
                      as List<ScanSurface>,
            doors: null == doors
                ? _value.doors
                : doors // ignore: cast_nullable_to_non_nullable
                      as List<ScanSurface>,
            windows: null == windows
                ? _value.windows
                : windows // ignore: cast_nullable_to_non_nullable
                      as List<ScanSurface>,
            openings: null == openings
                ? _value.openings
                : openings // ignore: cast_nullable_to_non_nullable
                      as List<ScanSurface>,
            objects: null == objects
                ? _value.objects
                : objects // ignore: cast_nullable_to_non_nullable
                      as List<ScanObject>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CapturedRoomImplCopyWith<$Res>
    implements $CapturedRoomCopyWith<$Res> {
  factory _$$CapturedRoomImplCopyWith(
    _$CapturedRoomImpl value,
    $Res Function(_$CapturedRoomImpl) then,
  ) = __$$CapturedRoomImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<ScanSurface> walls,
    List<ScanSurface> doors,
    List<ScanSurface> windows,
    List<ScanSurface> openings,
    List<ScanObject> objects,
  });
}

/// @nodoc
class __$$CapturedRoomImplCopyWithImpl<$Res>
    extends _$CapturedRoomCopyWithImpl<$Res, _$CapturedRoomImpl>
    implements _$$CapturedRoomImplCopyWith<$Res> {
  __$$CapturedRoomImplCopyWithImpl(
    _$CapturedRoomImpl _value,
    $Res Function(_$CapturedRoomImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CapturedRoom
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? walls = null,
    Object? doors = null,
    Object? windows = null,
    Object? openings = null,
    Object? objects = null,
  }) {
    return _then(
      _$CapturedRoomImpl(
        walls: null == walls
            ? _value._walls
            : walls // ignore: cast_nullable_to_non_nullable
                  as List<ScanSurface>,
        doors: null == doors
            ? _value._doors
            : doors // ignore: cast_nullable_to_non_nullable
                  as List<ScanSurface>,
        windows: null == windows
            ? _value._windows
            : windows // ignore: cast_nullable_to_non_nullable
                  as List<ScanSurface>,
        openings: null == openings
            ? _value._openings
            : openings // ignore: cast_nullable_to_non_nullable
                  as List<ScanSurface>,
        objects: null == objects
            ? _value._objects
            : objects // ignore: cast_nullable_to_non_nullable
                  as List<ScanObject>,
      ),
    );
  }
}

/// @nodoc

class _$CapturedRoomImpl implements _CapturedRoom {
  const _$CapturedRoomImpl({
    final List<ScanSurface> walls = const <ScanSurface>[],
    final List<ScanSurface> doors = const <ScanSurface>[],
    final List<ScanSurface> windows = const <ScanSurface>[],
    final List<ScanSurface> openings = const <ScanSurface>[],
    final List<ScanObject> objects = const <ScanObject>[],
  }) : _walls = walls,
       _doors = doors,
       _windows = windows,
       _openings = openings,
       _objects = objects;

  final List<ScanSurface> _walls;
  @override
  @JsonKey()
  List<ScanSurface> get walls {
    if (_walls is EqualUnmodifiableListView) return _walls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_walls);
  }

  final List<ScanSurface> _doors;
  @override
  @JsonKey()
  List<ScanSurface> get doors {
    if (_doors is EqualUnmodifiableListView) return _doors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_doors);
  }

  final List<ScanSurface> _windows;
  @override
  @JsonKey()
  List<ScanSurface> get windows {
    if (_windows is EqualUnmodifiableListView) return _windows;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_windows);
  }

  final List<ScanSurface> _openings;
  @override
  @JsonKey()
  List<ScanSurface> get openings {
    if (_openings is EqualUnmodifiableListView) return _openings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_openings);
  }

  final List<ScanObject> _objects;
  @override
  @JsonKey()
  List<ScanObject> get objects {
    if (_objects is EqualUnmodifiableListView) return _objects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_objects);
  }

  @override
  String toString() {
    return 'CapturedRoom(walls: $walls, doors: $doors, windows: $windows, openings: $openings, objects: $objects)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CapturedRoomImpl &&
            const DeepCollectionEquality().equals(other._walls, _walls) &&
            const DeepCollectionEquality().equals(other._doors, _doors) &&
            const DeepCollectionEquality().equals(other._windows, _windows) &&
            const DeepCollectionEquality().equals(other._openings, _openings) &&
            const DeepCollectionEquality().equals(other._objects, _objects));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_walls),
    const DeepCollectionEquality().hash(_doors),
    const DeepCollectionEquality().hash(_windows),
    const DeepCollectionEquality().hash(_openings),
    const DeepCollectionEquality().hash(_objects),
  );

  /// Create a copy of CapturedRoom
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CapturedRoomImplCopyWith<_$CapturedRoomImpl> get copyWith =>
      __$$CapturedRoomImplCopyWithImpl<_$CapturedRoomImpl>(this, _$identity);
}

abstract class _CapturedRoom implements CapturedRoom {
  const factory _CapturedRoom({
    final List<ScanSurface> walls,
    final List<ScanSurface> doors,
    final List<ScanSurface> windows,
    final List<ScanSurface> openings,
    final List<ScanObject> objects,
  }) = _$CapturedRoomImpl;

  @override
  List<ScanSurface> get walls;
  @override
  List<ScanSurface> get doors;
  @override
  List<ScanSurface> get windows;
  @override
  List<ScanSurface> get openings;
  @override
  List<ScanObject> get objects;

  /// Create a copy of CapturedRoom
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CapturedRoomImplCopyWith<_$CapturedRoomImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
