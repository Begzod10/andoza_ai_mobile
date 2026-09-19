// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'captured_room.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Vec3 {

 double get x; double get y; double get z;
/// Create a copy of Vec3
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Vec3CopyWith<Vec3> get copyWith => _$Vec3CopyWithImpl<Vec3>(this as Vec3, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Vec3;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Vec3&&(identical(other.x, _this.x) || other.x == _this.x)&&(identical(other.y, _this.y) || other.y == _this.y)&&(identical(other.z, _this.z) || other.z == _this.z));
}


@override
int get hashCode {
  final _this = this as Vec3;
  return Object.hash(runtimeType,_this.x,_this.y,_this.z);
}

@override
String toString() {
  final _this = this as Vec3;
  return 'Vec3(x: ${_this.x}, y: ${_this.y}, z: ${_this.z})';
}


}

/// @nodoc
abstract mixin class $Vec3CopyWith<$Res>  {
  factory $Vec3CopyWith(Vec3 value, $Res Function(Vec3) _then) = _$Vec3CopyWithImpl;
@useResult
$Res call({
 double x, double y, double z
});




}
/// @nodoc
class _$Vec3CopyWithImpl<$Res>
    implements $Vec3CopyWith<$Res> {
  _$Vec3CopyWithImpl(this._self, this._then);

  final Vec3 _self;
  final $Res Function(Vec3) _then;

/// Create a copy of Vec3
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? x = null,Object? y = null,Object? z = null,}) {
  return _then(Vec3(
null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,null == z ? _self.z : z // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [Vec3].
extension Vec3Patterns on Vec3 {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Vec3 value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Vec3() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Vec3 value)  $default,){
final _that = this;
switch (_that) {
case _Vec3():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Vec3 value)?  $default,){
final _that = this;
switch (_that) {
case _Vec3() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double x,  double y,  double z)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Vec3() when $default != null:
return $default(_that.x,_that.y,_that.z);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double x,  double y,  double z)  $default,) {final _that = this;
switch (_that) {
case _Vec3():
return $default(_that.x,_that.y,_that.z);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double x,  double y,  double z)?  $default,) {final _that = this;
switch (_that) {
case _Vec3() when $default != null:
return $default(_that.x,_that.y,_that.z);case _:
  return null;

}
}

}

/// @nodoc


class _Vec3 implements Vec3 {
  const _Vec3(this.x, this.y, this.z);
  

@override final  double x;
@override final  double y;
@override final  double z;

/// Create a copy of Vec3
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$Vec3CopyWith<_Vec3> get copyWith => __$Vec3CopyWithImpl<_Vec3>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Vec3&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.z, z) || other.z == z));
}


@override
int get hashCode {
    return Object.hash(runtimeType,x,y,z);
}

@override
String toString() {
    return 'Vec3(x: $x, y: $y, z: $z)';
}


}

/// @nodoc
abstract mixin class _$Vec3CopyWith<$Res> implements $Vec3CopyWith<$Res> {
  factory _$Vec3CopyWith(_Vec3 value, $Res Function(_Vec3) _then) = __$Vec3CopyWithImpl;
@override @useResult
$Res call({
 double x, double y, double z
});




}
/// @nodoc
class __$Vec3CopyWithImpl<$Res>
    implements _$Vec3CopyWith<$Res> {
  __$Vec3CopyWithImpl(this._self, this._then);

  final _Vec3 _self;
  final $Res Function(_Vec3) _then;

/// Create a copy of Vec3
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? x = null,Object? y = null,Object? z = null,}) {
  return _then(_Vec3(
null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,null == z ? _self.z : z // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$ScanTransform {

 List<double> get m;
/// Create a copy of ScanTransform
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScanTransformCopyWith<ScanTransform> get copyWith => _$ScanTransformCopyWithImpl<ScanTransform>(this as ScanTransform, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ScanTransform;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScanTransform&&const DeepCollectionEquality().equals(other.m, _this.m));
}


@override
int get hashCode {
  final _this = this as ScanTransform;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.m));
}

@override
String toString() {
  final _this = this as ScanTransform;
  return 'ScanTransform(m: ${_this.m})';
}


}

/// @nodoc
abstract mixin class $ScanTransformCopyWith<$Res>  {
  factory $ScanTransformCopyWith(ScanTransform value, $Res Function(ScanTransform) _then) = _$ScanTransformCopyWithImpl;
@useResult
$Res call({
 List<double> m
});




}
/// @nodoc
class _$ScanTransformCopyWithImpl<$Res>
    implements $ScanTransformCopyWith<$Res> {
  _$ScanTransformCopyWithImpl(this._self, this._then);

  final ScanTransform _self;
  final $Res Function(ScanTransform) _then;

/// Create a copy of ScanTransform
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? m = null,}) {
  return _then(ScanTransform(
null == m ? _self.m : m // ignore: cast_nullable_to_non_nullable
as List<double>,
  ));
}

}


/// Adds pattern-matching-related methods to [ScanTransform].
extension ScanTransformPatterns on ScanTransform {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScanTransform value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScanTransform() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScanTransform value)  $default,){
final _that = this;
switch (_that) {
case _ScanTransform():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScanTransform value)?  $default,){
final _that = this;
switch (_that) {
case _ScanTransform() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<double> m)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScanTransform() when $default != null:
return $default(_that.m);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<double> m)  $default,) {final _that = this;
switch (_that) {
case _ScanTransform():
return $default(_that.m);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<double> m)?  $default,) {final _that = this;
switch (_that) {
case _ScanTransform() when $default != null:
return $default(_that.m);case _:
  return null;

}
}

}

/// @nodoc


class _ScanTransform extends ScanTransform {
  const _ScanTransform( List<double> m): _m = m,super._();
  

 final  List<double> _m;
@override List<double> get m {
  if (_m is EqualUnmodifiableListView) return _m;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_m);
}


/// Create a copy of ScanTransform
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScanTransformCopyWith<_ScanTransform> get copyWith => __$ScanTransformCopyWithImpl<_ScanTransform>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScanTransform&&const DeepCollectionEquality().equals(other.m, _m));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_m));
}

@override
String toString() {
    return 'ScanTransform(m: $m)';
}


}

/// @nodoc
abstract mixin class _$ScanTransformCopyWith<$Res> implements $ScanTransformCopyWith<$Res> {
  factory _$ScanTransformCopyWith(_ScanTransform value, $Res Function(_ScanTransform) _then) = __$ScanTransformCopyWithImpl;
@override @useResult
$Res call({
 List<double> m
});




}
/// @nodoc
class __$ScanTransformCopyWithImpl<$Res>
    implements _$ScanTransformCopyWith<$Res> {
  __$ScanTransformCopyWithImpl(this._self, this._then);

  final _ScanTransform _self;
  final $Res Function(_ScanTransform) _then;

/// Create a copy of ScanTransform
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? m = null,}) {
  return _then(_ScanTransform(
null == m ? _self._m : m // ignore: cast_nullable_to_non_nullable
as List<double>,
  ));
}


}

/// @nodoc
mixin _$ScanSurface {

 Vec3 get dimensions; ScanTransform get transform; ScanConfidence get confidence;
/// Create a copy of ScanSurface
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScanSurfaceCopyWith<ScanSurface> get copyWith => _$ScanSurfaceCopyWithImpl<ScanSurface>(this as ScanSurface, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ScanSurface;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScanSurface&&(identical(other.dimensions, _this.dimensions) || other.dimensions == _this.dimensions)&&(identical(other.transform, _this.transform) || other.transform == _this.transform)&&(identical(other.confidence, _this.confidence) || other.confidence == _this.confidence));
}


@override
int get hashCode {
  final _this = this as ScanSurface;
  return Object.hash(runtimeType,_this.dimensions,_this.transform,_this.confidence);
}

@override
String toString() {
  final _this = this as ScanSurface;
  return 'ScanSurface(dimensions: ${_this.dimensions}, transform: ${_this.transform}, confidence: ${_this.confidence})';
}


}

/// @nodoc
abstract mixin class $ScanSurfaceCopyWith<$Res>  {
  factory $ScanSurfaceCopyWith(ScanSurface value, $Res Function(ScanSurface) _then) = _$ScanSurfaceCopyWithImpl;
@useResult
$Res call({
 Vec3 dimensions, ScanTransform transform, ScanConfidence confidence
});


$Vec3CopyWith<$Res> get dimensions;$ScanTransformCopyWith<$Res> get transform;

}
/// @nodoc
class _$ScanSurfaceCopyWithImpl<$Res>
    implements $ScanSurfaceCopyWith<$Res> {
  _$ScanSurfaceCopyWithImpl(this._self, this._then);

  final ScanSurface _self;
  final $Res Function(ScanSurface) _then;

/// Create a copy of ScanSurface
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dimensions = null,Object? transform = null,Object? confidence = null,}) {
  return _then(ScanSurface(
dimensions: null == dimensions ? _self.dimensions : dimensions // ignore: cast_nullable_to_non_nullable
as Vec3,transform: null == transform ? _self.transform : transform // ignore: cast_nullable_to_non_nullable
as ScanTransform,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as ScanConfidence,
  ));
}
/// Create a copy of ScanSurface
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$Vec3CopyWith<$Res> get dimensions {
  
  return $Vec3CopyWith<$Res>(_self.dimensions, (value) {
    return _then(_self.copyWith(dimensions: value));
  });
}/// Create a copy of ScanSurface
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScanTransformCopyWith<$Res> get transform {
  
  return $ScanTransformCopyWith<$Res>(_self.transform, (value) {
    return _then(_self.copyWith(transform: value));
  });
}
}


/// Adds pattern-matching-related methods to [ScanSurface].
extension ScanSurfacePatterns on ScanSurface {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScanSurface value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScanSurface() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScanSurface value)  $default,){
final _that = this;
switch (_that) {
case _ScanSurface():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScanSurface value)?  $default,){
final _that = this;
switch (_that) {
case _ScanSurface() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Vec3 dimensions,  ScanTransform transform,  ScanConfidence confidence)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScanSurface() when $default != null:
return $default(_that.dimensions,_that.transform,_that.confidence);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Vec3 dimensions,  ScanTransform transform,  ScanConfidence confidence)  $default,) {final _that = this;
switch (_that) {
case _ScanSurface():
return $default(_that.dimensions,_that.transform,_that.confidence);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Vec3 dimensions,  ScanTransform transform,  ScanConfidence confidence)?  $default,) {final _that = this;
switch (_that) {
case _ScanSurface() when $default != null:
return $default(_that.dimensions,_that.transform,_that.confidence);case _:
  return null;

}
}

}

/// @nodoc


class _ScanSurface implements ScanSurface {
  const _ScanSurface({required this.dimensions, required this.transform, this.confidence = ScanConfidence.medium});
  

@override final  Vec3 dimensions;
@override final  ScanTransform transform;
@override@JsonKey() final  ScanConfidence confidence;

/// Create a copy of ScanSurface
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScanSurfaceCopyWith<_ScanSurface> get copyWith => __$ScanSurfaceCopyWithImpl<_ScanSurface>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScanSurface&&(identical(other.dimensions, dimensions) || other.dimensions == dimensions)&&(identical(other.transform, transform) || other.transform == transform)&&(identical(other.confidence, confidence) || other.confidence == confidence));
}


@override
int get hashCode {
    return Object.hash(runtimeType,dimensions,transform,confidence);
}

@override
String toString() {
    return 'ScanSurface(dimensions: $dimensions, transform: $transform, confidence: $confidence)';
}


}

/// @nodoc
abstract mixin class _$ScanSurfaceCopyWith<$Res> implements $ScanSurfaceCopyWith<$Res> {
  factory _$ScanSurfaceCopyWith(_ScanSurface value, $Res Function(_ScanSurface) _then) = __$ScanSurfaceCopyWithImpl;
@override @useResult
$Res call({
 Vec3 dimensions, ScanTransform transform, ScanConfidence confidence
});


@override $Vec3CopyWith<$Res> get dimensions;@override $ScanTransformCopyWith<$Res> get transform;

}
/// @nodoc
class __$ScanSurfaceCopyWithImpl<$Res>
    implements _$ScanSurfaceCopyWith<$Res> {
  __$ScanSurfaceCopyWithImpl(this._self, this._then);

  final _ScanSurface _self;
  final $Res Function(_ScanSurface) _then;

/// Create a copy of ScanSurface
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dimensions = null,Object? transform = null,Object? confidence = null,}) {
  return _then(_ScanSurface(
dimensions: null == dimensions ? _self.dimensions : dimensions // ignore: cast_nullable_to_non_nullable
as Vec3,transform: null == transform ? _self.transform : transform // ignore: cast_nullable_to_non_nullable
as ScanTransform,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as ScanConfidence,
  ));
}

/// Create a copy of ScanSurface
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$Vec3CopyWith<$Res> get dimensions {
  
  return $Vec3CopyWith<$Res>(_self.dimensions, (value) {
    return _then(_self.copyWith(dimensions: value));
  });
}/// Create a copy of ScanSurface
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScanTransformCopyWith<$Res> get transform {
  
  return $ScanTransformCopyWith<$Res>(_self.transform, (value) {
    return _then(_self.copyWith(transform: value));
  });
}
}

/// @nodoc
mixin _$ScanObject {

 ScanObjectCategory get category; Vec3 get dimensions; ScanTransform get transform; ScanConfidence get confidence;
/// Create a copy of ScanObject
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScanObjectCopyWith<ScanObject> get copyWith => _$ScanObjectCopyWithImpl<ScanObject>(this as ScanObject, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ScanObject;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScanObject&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.dimensions, _this.dimensions) || other.dimensions == _this.dimensions)&&(identical(other.transform, _this.transform) || other.transform == _this.transform)&&(identical(other.confidence, _this.confidence) || other.confidence == _this.confidence));
}


@override
int get hashCode {
  final _this = this as ScanObject;
  return Object.hash(runtimeType,_this.category,_this.dimensions,_this.transform,_this.confidence);
}

@override
String toString() {
  final _this = this as ScanObject;
  return 'ScanObject(category: ${_this.category}, dimensions: ${_this.dimensions}, transform: ${_this.transform}, confidence: ${_this.confidence})';
}


}

/// @nodoc
abstract mixin class $ScanObjectCopyWith<$Res>  {
  factory $ScanObjectCopyWith(ScanObject value, $Res Function(ScanObject) _then) = _$ScanObjectCopyWithImpl;
@useResult
$Res call({
 ScanObjectCategory category, Vec3 dimensions, ScanTransform transform, ScanConfidence confidence
});


$Vec3CopyWith<$Res> get dimensions;$ScanTransformCopyWith<$Res> get transform;

}
/// @nodoc
class _$ScanObjectCopyWithImpl<$Res>
    implements $ScanObjectCopyWith<$Res> {
  _$ScanObjectCopyWithImpl(this._self, this._then);

  final ScanObject _self;
  final $Res Function(ScanObject) _then;

/// Create a copy of ScanObject
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? category = null,Object? dimensions = null,Object? transform = null,Object? confidence = null,}) {
  return _then(ScanObject(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ScanObjectCategory,dimensions: null == dimensions ? _self.dimensions : dimensions // ignore: cast_nullable_to_non_nullable
as Vec3,transform: null == transform ? _self.transform : transform // ignore: cast_nullable_to_non_nullable
as ScanTransform,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as ScanConfidence,
  ));
}
/// Create a copy of ScanObject
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$Vec3CopyWith<$Res> get dimensions {
  
  return $Vec3CopyWith<$Res>(_self.dimensions, (value) {
    return _then(_self.copyWith(dimensions: value));
  });
}/// Create a copy of ScanObject
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScanTransformCopyWith<$Res> get transform {
  
  return $ScanTransformCopyWith<$Res>(_self.transform, (value) {
    return _then(_self.copyWith(transform: value));
  });
}
}


/// Adds pattern-matching-related methods to [ScanObject].
extension ScanObjectPatterns on ScanObject {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScanObject value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScanObject() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScanObject value)  $default,){
final _that = this;
switch (_that) {
case _ScanObject():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScanObject value)?  $default,){
final _that = this;
switch (_that) {
case _ScanObject() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ScanObjectCategory category,  Vec3 dimensions,  ScanTransform transform,  ScanConfidence confidence)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScanObject() when $default != null:
return $default(_that.category,_that.dimensions,_that.transform,_that.confidence);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ScanObjectCategory category,  Vec3 dimensions,  ScanTransform transform,  ScanConfidence confidence)  $default,) {final _that = this;
switch (_that) {
case _ScanObject():
return $default(_that.category,_that.dimensions,_that.transform,_that.confidence);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ScanObjectCategory category,  Vec3 dimensions,  ScanTransform transform,  ScanConfidence confidence)?  $default,) {final _that = this;
switch (_that) {
case _ScanObject() when $default != null:
return $default(_that.category,_that.dimensions,_that.transform,_that.confidence);case _:
  return null;

}
}

}

/// @nodoc


class _ScanObject implements ScanObject {
  const _ScanObject({required this.category, required this.dimensions, required this.transform, this.confidence = ScanConfidence.medium});
  

@override final  ScanObjectCategory category;
@override final  Vec3 dimensions;
@override final  ScanTransform transform;
@override@JsonKey() final  ScanConfidence confidence;

/// Create a copy of ScanObject
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScanObjectCopyWith<_ScanObject> get copyWith => __$ScanObjectCopyWithImpl<_ScanObject>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScanObject&&(identical(other.category, category) || other.category == category)&&(identical(other.dimensions, dimensions) || other.dimensions == dimensions)&&(identical(other.transform, transform) || other.transform == transform)&&(identical(other.confidence, confidence) || other.confidence == confidence));
}


@override
int get hashCode {
    return Object.hash(runtimeType,category,dimensions,transform,confidence);
}

@override
String toString() {
    return 'ScanObject(category: $category, dimensions: $dimensions, transform: $transform, confidence: $confidence)';
}


}

/// @nodoc
abstract mixin class _$ScanObjectCopyWith<$Res> implements $ScanObjectCopyWith<$Res> {
  factory _$ScanObjectCopyWith(_ScanObject value, $Res Function(_ScanObject) _then) = __$ScanObjectCopyWithImpl;
@override @useResult
$Res call({
 ScanObjectCategory category, Vec3 dimensions, ScanTransform transform, ScanConfidence confidence
});


@override $Vec3CopyWith<$Res> get dimensions;@override $ScanTransformCopyWith<$Res> get transform;

}
/// @nodoc
class __$ScanObjectCopyWithImpl<$Res>
    implements _$ScanObjectCopyWith<$Res> {
  __$ScanObjectCopyWithImpl(this._self, this._then);

  final _ScanObject _self;
  final $Res Function(_ScanObject) _then;

/// Create a copy of ScanObject
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? category = null,Object? dimensions = null,Object? transform = null,Object? confidence = null,}) {
  return _then(_ScanObject(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ScanObjectCategory,dimensions: null == dimensions ? _self.dimensions : dimensions // ignore: cast_nullable_to_non_nullable
as Vec3,transform: null == transform ? _self.transform : transform // ignore: cast_nullable_to_non_nullable
as ScanTransform,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as ScanConfidence,
  ));
}

/// Create a copy of ScanObject
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$Vec3CopyWith<$Res> get dimensions {
  
  return $Vec3CopyWith<$Res>(_self.dimensions, (value) {
    return _then(_self.copyWith(dimensions: value));
  });
}/// Create a copy of ScanObject
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScanTransformCopyWith<$Res> get transform {
  
  return $ScanTransformCopyWith<$Res>(_self.transform, (value) {
    return _then(_self.copyWith(transform: value));
  });
}
}

/// @nodoc
mixin _$CapturedRoom {

 List<ScanSurface> get walls; List<ScanSurface> get doors; List<ScanSurface> get windows; List<ScanSurface> get openings; List<ScanObject> get objects;
/// Create a copy of CapturedRoom
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CapturedRoomCopyWith<CapturedRoom> get copyWith => _$CapturedRoomCopyWithImpl<CapturedRoom>(this as CapturedRoom, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CapturedRoom;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CapturedRoom&&const DeepCollectionEquality().equals(other.walls, _this.walls)&&const DeepCollectionEquality().equals(other.doors, _this.doors)&&const DeepCollectionEquality().equals(other.windows, _this.windows)&&const DeepCollectionEquality().equals(other.openings, _this.openings)&&const DeepCollectionEquality().equals(other.objects, _this.objects));
}


@override
int get hashCode {
  final _this = this as CapturedRoom;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.walls),const DeepCollectionEquality().hash(_this.doors),const DeepCollectionEquality().hash(_this.windows),const DeepCollectionEquality().hash(_this.openings),const DeepCollectionEquality().hash(_this.objects));
}

@override
String toString() {
  final _this = this as CapturedRoom;
  return 'CapturedRoom(walls: ${_this.walls}, doors: ${_this.doors}, windows: ${_this.windows}, openings: ${_this.openings}, objects: ${_this.objects})';
}


}

/// @nodoc
abstract mixin class $CapturedRoomCopyWith<$Res>  {
  factory $CapturedRoomCopyWith(CapturedRoom value, $Res Function(CapturedRoom) _then) = _$CapturedRoomCopyWithImpl;
@useResult
$Res call({
 List<ScanSurface> walls, List<ScanSurface> doors, List<ScanSurface> windows, List<ScanSurface> openings, List<ScanObject> objects
});




}
/// @nodoc
class _$CapturedRoomCopyWithImpl<$Res>
    implements $CapturedRoomCopyWith<$Res> {
  _$CapturedRoomCopyWithImpl(this._self, this._then);

  final CapturedRoom _self;
  final $Res Function(CapturedRoom) _then;

/// Create a copy of CapturedRoom
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? walls = null,Object? doors = null,Object? windows = null,Object? openings = null,Object? objects = null,}) {
  return _then(CapturedRoom(
walls: null == walls ? _self.walls : walls // ignore: cast_nullable_to_non_nullable
as List<ScanSurface>,doors: null == doors ? _self.doors : doors // ignore: cast_nullable_to_non_nullable
as List<ScanSurface>,windows: null == windows ? _self.windows : windows // ignore: cast_nullable_to_non_nullable
as List<ScanSurface>,openings: null == openings ? _self.openings : openings // ignore: cast_nullable_to_non_nullable
as List<ScanSurface>,objects: null == objects ? _self.objects : objects // ignore: cast_nullable_to_non_nullable
as List<ScanObject>,
  ));
}

}


/// Adds pattern-matching-related methods to [CapturedRoom].
extension CapturedRoomPatterns on CapturedRoom {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CapturedRoom value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CapturedRoom() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CapturedRoom value)  $default,){
final _that = this;
switch (_that) {
case _CapturedRoom():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CapturedRoom value)?  $default,){
final _that = this;
switch (_that) {
case _CapturedRoom() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ScanSurface> walls,  List<ScanSurface> doors,  List<ScanSurface> windows,  List<ScanSurface> openings,  List<ScanObject> objects)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CapturedRoom() when $default != null:
return $default(_that.walls,_that.doors,_that.windows,_that.openings,_that.objects);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ScanSurface> walls,  List<ScanSurface> doors,  List<ScanSurface> windows,  List<ScanSurface> openings,  List<ScanObject> objects)  $default,) {final _that = this;
switch (_that) {
case _CapturedRoom():
return $default(_that.walls,_that.doors,_that.windows,_that.openings,_that.objects);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ScanSurface> walls,  List<ScanSurface> doors,  List<ScanSurface> windows,  List<ScanSurface> openings,  List<ScanObject> objects)?  $default,) {final _that = this;
switch (_that) {
case _CapturedRoom() when $default != null:
return $default(_that.walls,_that.doors,_that.windows,_that.openings,_that.objects);case _:
  return null;

}
}

}

/// @nodoc


class _CapturedRoom implements CapturedRoom {
  const _CapturedRoom({ List<ScanSurface> walls = const <ScanSurface>[],  List<ScanSurface> doors = const <ScanSurface>[],  List<ScanSurface> windows = const <ScanSurface>[],  List<ScanSurface> openings = const <ScanSurface>[],  List<ScanObject> objects = const <ScanObject>[]}): _walls = walls,_doors = doors,_windows = windows,_openings = openings,_objects = objects;
  

 final  List<ScanSurface> _walls;
@override@JsonKey() List<ScanSurface> get walls {
  if (_walls is EqualUnmodifiableListView) return _walls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_walls);
}

 final  List<ScanSurface> _doors;
@override@JsonKey() List<ScanSurface> get doors {
  if (_doors is EqualUnmodifiableListView) return _doors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_doors);
}

 final  List<ScanSurface> _windows;
@override@JsonKey() List<ScanSurface> get windows {
  if (_windows is EqualUnmodifiableListView) return _windows;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_windows);
}

 final  List<ScanSurface> _openings;
@override@JsonKey() List<ScanSurface> get openings {
  if (_openings is EqualUnmodifiableListView) return _openings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_openings);
}

 final  List<ScanObject> _objects;
@override@JsonKey() List<ScanObject> get objects {
  if (_objects is EqualUnmodifiableListView) return _objects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_objects);
}


/// Create a copy of CapturedRoom
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CapturedRoomCopyWith<_CapturedRoom> get copyWith => __$CapturedRoomCopyWithImpl<_CapturedRoom>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CapturedRoom&&const DeepCollectionEquality().equals(other.walls, _walls)&&const DeepCollectionEquality().equals(other.doors, _doors)&&const DeepCollectionEquality().equals(other.windows, _windows)&&const DeepCollectionEquality().equals(other.openings, _openings)&&const DeepCollectionEquality().equals(other.objects, _objects));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_walls),const DeepCollectionEquality().hash(_doors),const DeepCollectionEquality().hash(_windows),const DeepCollectionEquality().hash(_openings),const DeepCollectionEquality().hash(_objects));
}

@override
String toString() {
    return 'CapturedRoom(walls: $walls, doors: $doors, windows: $windows, openings: $openings, objects: $objects)';
}


}

/// @nodoc
abstract mixin class _$CapturedRoomCopyWith<$Res> implements $CapturedRoomCopyWith<$Res> {
  factory _$CapturedRoomCopyWith(_CapturedRoom value, $Res Function(_CapturedRoom) _then) = __$CapturedRoomCopyWithImpl;
@override @useResult
$Res call({
 List<ScanSurface> walls, List<ScanSurface> doors, List<ScanSurface> windows, List<ScanSurface> openings, List<ScanObject> objects
});




}
/// @nodoc
class __$CapturedRoomCopyWithImpl<$Res>
    implements _$CapturedRoomCopyWith<$Res> {
  __$CapturedRoomCopyWithImpl(this._self, this._then);

  final _CapturedRoom _self;
  final $Res Function(_CapturedRoom) _then;

/// Create a copy of CapturedRoom
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? walls = null,Object? doors = null,Object? windows = null,Object? openings = null,Object? objects = null,}) {
  return _then(_CapturedRoom(
walls: null == walls ? _self._walls : walls // ignore: cast_nullable_to_non_nullable
as List<ScanSurface>,doors: null == doors ? _self._doors : doors // ignore: cast_nullable_to_non_nullable
as List<ScanSurface>,windows: null == windows ? _self._windows : windows // ignore: cast_nullable_to_non_nullable
as List<ScanSurface>,openings: null == openings ? _self._openings : openings // ignore: cast_nullable_to_non_nullable
as List<ScanSurface>,objects: null == objects ? _self._objects : objects // ignore: cast_nullable_to_non_nullable
as List<ScanObject>,
  ));
}


}

// dart format on
