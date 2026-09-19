// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AiPatch {

@JsonKey(name: 'ceiling_h') double? get ceilingH;@JsonKey(name: 'wall_lengths') Map<String, double>? get wallLengths; Map<String, String>? get surfaces;@JsonKey(name: 'material_colors') Map<String, String>? get materialColors; List<Map<String, dynamic>>? get furniture; List<Map<String, dynamic>>? get lights;
/// Create a copy of AiPatch
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiPatchCopyWith<AiPatch> get copyWith => _$AiPatchCopyWithImpl<AiPatch>(this as AiPatch, _$identity);

  /// Serializes this AiPatch to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AiPatch;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiPatch&&(identical(other.ceilingH, _this.ceilingH) || other.ceilingH == _this.ceilingH)&&const DeepCollectionEquality().equals(other.wallLengths, _this.wallLengths)&&const DeepCollectionEquality().equals(other.surfaces, _this.surfaces)&&const DeepCollectionEquality().equals(other.materialColors, _this.materialColors)&&const DeepCollectionEquality().equals(other.furniture, _this.furniture)&&const DeepCollectionEquality().equals(other.lights, _this.lights));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AiPatch;
  return Object.hash(runtimeType,_this.ceilingH,const DeepCollectionEquality().hash(_this.wallLengths),const DeepCollectionEquality().hash(_this.surfaces),const DeepCollectionEquality().hash(_this.materialColors),const DeepCollectionEquality().hash(_this.furniture),const DeepCollectionEquality().hash(_this.lights));
}

@override
String toString() {
  final _this = this as AiPatch;
  return 'AiPatch(ceilingH: ${_this.ceilingH}, wallLengths: ${_this.wallLengths}, surfaces: ${_this.surfaces}, materialColors: ${_this.materialColors}, furniture: ${_this.furniture}, lights: ${_this.lights})';
}


}

/// @nodoc
abstract mixin class $AiPatchCopyWith<$Res>  {
  factory $AiPatchCopyWith(AiPatch value, $Res Function(AiPatch) _then) = _$AiPatchCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'ceiling_h') double? ceilingH,@JsonKey(name: 'wall_lengths') Map<String, double>? wallLengths, Map<String, String>? surfaces,@JsonKey(name: 'material_colors') Map<String, String>? materialColors, List<Map<String, dynamic>>? furniture, List<Map<String, dynamic>>? lights
});




}
/// @nodoc
class _$AiPatchCopyWithImpl<$Res>
    implements $AiPatchCopyWith<$Res> {
  _$AiPatchCopyWithImpl(this._self, this._then);

  final AiPatch _self;
  final $Res Function(AiPatch) _then;

/// Create a copy of AiPatch
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ceilingH = freezed,Object? wallLengths = freezed,Object? surfaces = freezed,Object? materialColors = freezed,Object? furniture = freezed,Object? lights = freezed,}) {
  return _then(AiPatch(
ceilingH: freezed == ceilingH ? _self.ceilingH : ceilingH // ignore: cast_nullable_to_non_nullable
as double?,wallLengths: freezed == wallLengths ? _self.wallLengths : wallLengths // ignore: cast_nullable_to_non_nullable
as Map<String, double>?,surfaces: freezed == surfaces ? _self.surfaces : surfaces // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,materialColors: freezed == materialColors ? _self.materialColors : materialColors // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,furniture: freezed == furniture ? _self.furniture : furniture // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>?,lights: freezed == lights ? _self.lights : lights // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>?,
  ));
}

}


/// Adds pattern-matching-related methods to [AiPatch].
extension AiPatchPatterns on AiPatch {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiPatch value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiPatch() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiPatch value)  $default,){
final _that = this;
switch (_that) {
case _AiPatch():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiPatch value)?  $default,){
final _that = this;
switch (_that) {
case _AiPatch() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'ceiling_h')  double? ceilingH, @JsonKey(name: 'wall_lengths')  Map<String, double>? wallLengths,  Map<String, String>? surfaces, @JsonKey(name: 'material_colors')  Map<String, String>? materialColors,  List<Map<String, dynamic>>? furniture,  List<Map<String, dynamic>>? lights)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiPatch() when $default != null:
return $default(_that.ceilingH,_that.wallLengths,_that.surfaces,_that.materialColors,_that.furniture,_that.lights);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'ceiling_h')  double? ceilingH, @JsonKey(name: 'wall_lengths')  Map<String, double>? wallLengths,  Map<String, String>? surfaces, @JsonKey(name: 'material_colors')  Map<String, String>? materialColors,  List<Map<String, dynamic>>? furniture,  List<Map<String, dynamic>>? lights)  $default,) {final _that = this;
switch (_that) {
case _AiPatch():
return $default(_that.ceilingH,_that.wallLengths,_that.surfaces,_that.materialColors,_that.furniture,_that.lights);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'ceiling_h')  double? ceilingH, @JsonKey(name: 'wall_lengths')  Map<String, double>? wallLengths,  Map<String, String>? surfaces, @JsonKey(name: 'material_colors')  Map<String, String>? materialColors,  List<Map<String, dynamic>>? furniture,  List<Map<String, dynamic>>? lights)?  $default,) {final _that = this;
switch (_that) {
case _AiPatch() when $default != null:
return $default(_that.ceilingH,_that.wallLengths,_that.surfaces,_that.materialColors,_that.furniture,_that.lights);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiPatch implements AiPatch {
  const _AiPatch({@JsonKey(name: 'ceiling_h') this.ceilingH, @JsonKey(name: 'wall_lengths')  Map<String, double>? wallLengths,  Map<String, String>? surfaces, @JsonKey(name: 'material_colors')  Map<String, String>? materialColors,  List<Map<String, dynamic>>? furniture,  List<Map<String, dynamic>>? lights}): _wallLengths = wallLengths,_surfaces = surfaces,_materialColors = materialColors,_furniture = furniture,_lights = lights;
  factory _AiPatch.fromJson(Map<String, dynamic> json) => _$AiPatchFromJson(json);

@override@JsonKey(name: 'ceiling_h') final  double? ceilingH;
 final  Map<String, double>? _wallLengths;
@override@JsonKey(name: 'wall_lengths') Map<String, double>? get wallLengths {
  final value = _wallLengths;
  if (value == null) return null;
  if (_wallLengths is EqualUnmodifiableMapView) return _wallLengths;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, String>? _surfaces;
@override Map<String, String>? get surfaces {
  final value = _surfaces;
  if (value == null) return null;
  if (_surfaces is EqualUnmodifiableMapView) return _surfaces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, String>? _materialColors;
@override@JsonKey(name: 'material_colors') Map<String, String>? get materialColors {
  final value = _materialColors;
  if (value == null) return null;
  if (_materialColors is EqualUnmodifiableMapView) return _materialColors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  List<Map<String, dynamic>>? _furniture;
@override List<Map<String, dynamic>>? get furniture {
  final value = _furniture;
  if (value == null) return null;
  if (_furniture is EqualUnmodifiableListView) return _furniture;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<Map<String, dynamic>>? _lights;
@override List<Map<String, dynamic>>? get lights {
  final value = _lights;
  if (value == null) return null;
  if (_lights is EqualUnmodifiableListView) return _lights;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of AiPatch
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiPatchCopyWith<_AiPatch> get copyWith => __$AiPatchCopyWithImpl<_AiPatch>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiPatchToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiPatch&&(identical(other.ceilingH, ceilingH) || other.ceilingH == ceilingH)&&const DeepCollectionEquality().equals(other.wallLengths, _wallLengths)&&const DeepCollectionEquality().equals(other.surfaces, _surfaces)&&const DeepCollectionEquality().equals(other.materialColors, _materialColors)&&const DeepCollectionEquality().equals(other.furniture, _furniture)&&const DeepCollectionEquality().equals(other.lights, _lights));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,ceilingH,const DeepCollectionEquality().hash(_wallLengths),const DeepCollectionEquality().hash(_surfaces),const DeepCollectionEquality().hash(_materialColors),const DeepCollectionEquality().hash(_furniture),const DeepCollectionEquality().hash(_lights));
}

@override
String toString() {
    return 'AiPatch(ceilingH: $ceilingH, wallLengths: $wallLengths, surfaces: $surfaces, materialColors: $materialColors, furniture: $furniture, lights: $lights)';
}


}

/// @nodoc
abstract mixin class _$AiPatchCopyWith<$Res> implements $AiPatchCopyWith<$Res> {
  factory _$AiPatchCopyWith(_AiPatch value, $Res Function(_AiPatch) _then) = __$AiPatchCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'ceiling_h') double? ceilingH,@JsonKey(name: 'wall_lengths') Map<String, double>? wallLengths, Map<String, String>? surfaces,@JsonKey(name: 'material_colors') Map<String, String>? materialColors, List<Map<String, dynamic>>? furniture, List<Map<String, dynamic>>? lights
});




}
/// @nodoc
class __$AiPatchCopyWithImpl<$Res>
    implements _$AiPatchCopyWith<$Res> {
  __$AiPatchCopyWithImpl(this._self, this._then);

  final _AiPatch _self;
  final $Res Function(_AiPatch) _then;

/// Create a copy of AiPatch
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ceilingH = freezed,Object? wallLengths = freezed,Object? surfaces = freezed,Object? materialColors = freezed,Object? furniture = freezed,Object? lights = freezed,}) {
  return _then(_AiPatch(
ceilingH: freezed == ceilingH ? _self.ceilingH : ceilingH // ignore: cast_nullable_to_non_nullable
as double?,wallLengths: freezed == wallLengths ? _self._wallLengths : wallLengths // ignore: cast_nullable_to_non_nullable
as Map<String, double>?,surfaces: freezed == surfaces ? _self._surfaces : surfaces // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,materialColors: freezed == materialColors ? _self._materialColors : materialColors // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,furniture: freezed == furniture ? _self._furniture : furniture // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>?,lights: freezed == lights ? _self._lights : lights // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>?,
  ));
}


}


/// @nodoc
mixin _$SmetaAnswer {

@JsonKey(name: 'answer_uz') String get answerUz;@JsonKey(name: 'related_line_ids') List<String> get relatedLineIds;
/// Create a copy of SmetaAnswer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SmetaAnswerCopyWith<SmetaAnswer> get copyWith => _$SmetaAnswerCopyWithImpl<SmetaAnswer>(this as SmetaAnswer, _$identity);

  /// Serializes this SmetaAnswer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SmetaAnswer;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SmetaAnswer&&(identical(other.answerUz, _this.answerUz) || other.answerUz == _this.answerUz)&&const DeepCollectionEquality().equals(other.relatedLineIds, _this.relatedLineIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SmetaAnswer;
  return Object.hash(runtimeType,_this.answerUz,const DeepCollectionEquality().hash(_this.relatedLineIds));
}

@override
String toString() {
  final _this = this as SmetaAnswer;
  return 'SmetaAnswer(answerUz: ${_this.answerUz}, relatedLineIds: ${_this.relatedLineIds})';
}


}

/// @nodoc
abstract mixin class $SmetaAnswerCopyWith<$Res>  {
  factory $SmetaAnswerCopyWith(SmetaAnswer value, $Res Function(SmetaAnswer) _then) = _$SmetaAnswerCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'answer_uz') String answerUz,@JsonKey(name: 'related_line_ids') List<String> relatedLineIds
});




}
/// @nodoc
class _$SmetaAnswerCopyWithImpl<$Res>
    implements $SmetaAnswerCopyWith<$Res> {
  _$SmetaAnswerCopyWithImpl(this._self, this._then);

  final SmetaAnswer _self;
  final $Res Function(SmetaAnswer) _then;

/// Create a copy of SmetaAnswer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? answerUz = null,Object? relatedLineIds = null,}) {
  return _then(SmetaAnswer(
answerUz: null == answerUz ? _self.answerUz : answerUz // ignore: cast_nullable_to_non_nullable
as String,relatedLineIds: null == relatedLineIds ? _self.relatedLineIds : relatedLineIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [SmetaAnswer].
extension SmetaAnswerPatterns on SmetaAnswer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SmetaAnswer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SmetaAnswer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SmetaAnswer value)  $default,){
final _that = this;
switch (_that) {
case _SmetaAnswer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SmetaAnswer value)?  $default,){
final _that = this;
switch (_that) {
case _SmetaAnswer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'answer_uz')  String answerUz, @JsonKey(name: 'related_line_ids')  List<String> relatedLineIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SmetaAnswer() when $default != null:
return $default(_that.answerUz,_that.relatedLineIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'answer_uz')  String answerUz, @JsonKey(name: 'related_line_ids')  List<String> relatedLineIds)  $default,) {final _that = this;
switch (_that) {
case _SmetaAnswer():
return $default(_that.answerUz,_that.relatedLineIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'answer_uz')  String answerUz, @JsonKey(name: 'related_line_ids')  List<String> relatedLineIds)?  $default,) {final _that = this;
switch (_that) {
case _SmetaAnswer() when $default != null:
return $default(_that.answerUz,_that.relatedLineIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SmetaAnswer implements SmetaAnswer {
  const _SmetaAnswer({@JsonKey(name: 'answer_uz') required this.answerUz, @JsonKey(name: 'related_line_ids')  List<String> relatedLineIds = const <String>[]}): _relatedLineIds = relatedLineIds;
  factory _SmetaAnswer.fromJson(Map<String, dynamic> json) => _$SmetaAnswerFromJson(json);

@override@JsonKey(name: 'answer_uz') final  String answerUz;
 final  List<String> _relatedLineIds;
@override@JsonKey(name: 'related_line_ids') List<String> get relatedLineIds {
  if (_relatedLineIds is EqualUnmodifiableListView) return _relatedLineIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_relatedLineIds);
}


/// Create a copy of SmetaAnswer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SmetaAnswerCopyWith<_SmetaAnswer> get copyWith => __$SmetaAnswerCopyWithImpl<_SmetaAnswer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SmetaAnswerToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SmetaAnswer&&(identical(other.answerUz, answerUz) || other.answerUz == answerUz)&&const DeepCollectionEquality().equals(other.relatedLineIds, _relatedLineIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,answerUz,const DeepCollectionEquality().hash(_relatedLineIds));
}

@override
String toString() {
    return 'SmetaAnswer(answerUz: $answerUz, relatedLineIds: $relatedLineIds)';
}


}

/// @nodoc
abstract mixin class _$SmetaAnswerCopyWith<$Res> implements $SmetaAnswerCopyWith<$Res> {
  factory _$SmetaAnswerCopyWith(_SmetaAnswer value, $Res Function(_SmetaAnswer) _then) = __$SmetaAnswerCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'answer_uz') String answerUz,@JsonKey(name: 'related_line_ids') List<String> relatedLineIds
});




}
/// @nodoc
class __$SmetaAnswerCopyWithImpl<$Res>
    implements _$SmetaAnswerCopyWith<$Res> {
  __$SmetaAnswerCopyWithImpl(this._self, this._then);

  final _SmetaAnswer _self;
  final $Res Function(_SmetaAnswer) _then;

/// Create a copy of SmetaAnswer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? answerUz = null,Object? relatedLineIds = null,}) {
  return _then(_SmetaAnswer(
answerUz: null == answerUz ? _self.answerUz : answerUz // ignore: cast_nullable_to_non_nullable
as String,relatedLineIds: null == relatedLineIds ? _self._relatedLineIds : relatedLineIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
