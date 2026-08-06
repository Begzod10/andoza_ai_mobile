// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AiPatch _$AiPatchFromJson(Map<String, dynamic> json) {
  return _AiPatch.fromJson(json);
}

/// @nodoc
mixin _$AiPatch {
  @JsonKey(name: 'ceiling_h')
  double? get ceilingH => throw _privateConstructorUsedError;
  @JsonKey(name: 'wall_lengths')
  Map<String, double>? get wallLengths => throw _privateConstructorUsedError;
  Map<String, String>? get surfaces => throw _privateConstructorUsedError;
  @JsonKey(name: 'material_colors')
  Map<String, String>? get materialColors => throw _privateConstructorUsedError;
  List<Map<String, dynamic>>? get furniture =>
      throw _privateConstructorUsedError;
  List<Map<String, dynamic>>? get lights => throw _privateConstructorUsedError;

  /// Serializes this AiPatch to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AiPatch
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AiPatchCopyWith<AiPatch> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AiPatchCopyWith<$Res> {
  factory $AiPatchCopyWith(AiPatch value, $Res Function(AiPatch) then) =
      _$AiPatchCopyWithImpl<$Res, AiPatch>;
  @useResult
  $Res call({
    @JsonKey(name: 'ceiling_h') double? ceilingH,
    @JsonKey(name: 'wall_lengths') Map<String, double>? wallLengths,
    Map<String, String>? surfaces,
    @JsonKey(name: 'material_colors') Map<String, String>? materialColors,
    List<Map<String, dynamic>>? furniture,
    List<Map<String, dynamic>>? lights,
  });
}

/// @nodoc
class _$AiPatchCopyWithImpl<$Res, $Val extends AiPatch>
    implements $AiPatchCopyWith<$Res> {
  _$AiPatchCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AiPatch
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ceilingH = freezed,
    Object? wallLengths = freezed,
    Object? surfaces = freezed,
    Object? materialColors = freezed,
    Object? furniture = freezed,
    Object? lights = freezed,
  }) {
    return _then(
      _value.copyWith(
            ceilingH: freezed == ceilingH
                ? _value.ceilingH
                : ceilingH // ignore: cast_nullable_to_non_nullable
                      as double?,
            wallLengths: freezed == wallLengths
                ? _value.wallLengths
                : wallLengths // ignore: cast_nullable_to_non_nullable
                      as Map<String, double>?,
            surfaces: freezed == surfaces
                ? _value.surfaces
                : surfaces // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>?,
            materialColors: freezed == materialColors
                ? _value.materialColors
                : materialColors // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>?,
            furniture: freezed == furniture
                ? _value.furniture
                : furniture // ignore: cast_nullable_to_non_nullable
                      as List<Map<String, dynamic>>?,
            lights: freezed == lights
                ? _value.lights
                : lights // ignore: cast_nullable_to_non_nullable
                      as List<Map<String, dynamic>>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AiPatchImplCopyWith<$Res> implements $AiPatchCopyWith<$Res> {
  factory _$$AiPatchImplCopyWith(
    _$AiPatchImpl value,
    $Res Function(_$AiPatchImpl) then,
  ) = __$$AiPatchImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'ceiling_h') double? ceilingH,
    @JsonKey(name: 'wall_lengths') Map<String, double>? wallLengths,
    Map<String, String>? surfaces,
    @JsonKey(name: 'material_colors') Map<String, String>? materialColors,
    List<Map<String, dynamic>>? furniture,
    List<Map<String, dynamic>>? lights,
  });
}

/// @nodoc
class __$$AiPatchImplCopyWithImpl<$Res>
    extends _$AiPatchCopyWithImpl<$Res, _$AiPatchImpl>
    implements _$$AiPatchImplCopyWith<$Res> {
  __$$AiPatchImplCopyWithImpl(
    _$AiPatchImpl _value,
    $Res Function(_$AiPatchImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AiPatch
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ceilingH = freezed,
    Object? wallLengths = freezed,
    Object? surfaces = freezed,
    Object? materialColors = freezed,
    Object? furniture = freezed,
    Object? lights = freezed,
  }) {
    return _then(
      _$AiPatchImpl(
        ceilingH: freezed == ceilingH
            ? _value.ceilingH
            : ceilingH // ignore: cast_nullable_to_non_nullable
                  as double?,
        wallLengths: freezed == wallLengths
            ? _value._wallLengths
            : wallLengths // ignore: cast_nullable_to_non_nullable
                  as Map<String, double>?,
        surfaces: freezed == surfaces
            ? _value._surfaces
            : surfaces // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>?,
        materialColors: freezed == materialColors
            ? _value._materialColors
            : materialColors // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>?,
        furniture: freezed == furniture
            ? _value._furniture
            : furniture // ignore: cast_nullable_to_non_nullable
                  as List<Map<String, dynamic>>?,
        lights: freezed == lights
            ? _value._lights
            : lights // ignore: cast_nullable_to_non_nullable
                  as List<Map<String, dynamic>>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AiPatchImpl implements _AiPatch {
  const _$AiPatchImpl({
    @JsonKey(name: 'ceiling_h') this.ceilingH,
    @JsonKey(name: 'wall_lengths') final Map<String, double>? wallLengths,
    final Map<String, String>? surfaces,
    @JsonKey(name: 'material_colors') final Map<String, String>? materialColors,
    final List<Map<String, dynamic>>? furniture,
    final List<Map<String, dynamic>>? lights,
  }) : _wallLengths = wallLengths,
       _surfaces = surfaces,
       _materialColors = materialColors,
       _furniture = furniture,
       _lights = lights;

  factory _$AiPatchImpl.fromJson(Map<String, dynamic> json) =>
      _$$AiPatchImplFromJson(json);

  @override
  @JsonKey(name: 'ceiling_h')
  final double? ceilingH;
  final Map<String, double>? _wallLengths;
  @override
  @JsonKey(name: 'wall_lengths')
  Map<String, double>? get wallLengths {
    final value = _wallLengths;
    if (value == null) return null;
    if (_wallLengths is EqualUnmodifiableMapView) return _wallLengths;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, String>? _surfaces;
  @override
  Map<String, String>? get surfaces {
    final value = _surfaces;
    if (value == null) return null;
    if (_surfaces is EqualUnmodifiableMapView) return _surfaces;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, String>? _materialColors;
  @override
  @JsonKey(name: 'material_colors')
  Map<String, String>? get materialColors {
    final value = _materialColors;
    if (value == null) return null;
    if (_materialColors is EqualUnmodifiableMapView) return _materialColors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<Map<String, dynamic>>? _furniture;
  @override
  List<Map<String, dynamic>>? get furniture {
    final value = _furniture;
    if (value == null) return null;
    if (_furniture is EqualUnmodifiableListView) return _furniture;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Map<String, dynamic>>? _lights;
  @override
  List<Map<String, dynamic>>? get lights {
    final value = _lights;
    if (value == null) return null;
    if (_lights is EqualUnmodifiableListView) return _lights;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'AiPatch(ceilingH: $ceilingH, wallLengths: $wallLengths, surfaces: $surfaces, materialColors: $materialColors, furniture: $furniture, lights: $lights)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AiPatchImpl &&
            (identical(other.ceilingH, ceilingH) ||
                other.ceilingH == ceilingH) &&
            const DeepCollectionEquality().equals(
              other._wallLengths,
              _wallLengths,
            ) &&
            const DeepCollectionEquality().equals(other._surfaces, _surfaces) &&
            const DeepCollectionEquality().equals(
              other._materialColors,
              _materialColors,
            ) &&
            const DeepCollectionEquality().equals(
              other._furniture,
              _furniture,
            ) &&
            const DeepCollectionEquality().equals(other._lights, _lights));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    ceilingH,
    const DeepCollectionEquality().hash(_wallLengths),
    const DeepCollectionEquality().hash(_surfaces),
    const DeepCollectionEquality().hash(_materialColors),
    const DeepCollectionEquality().hash(_furniture),
    const DeepCollectionEquality().hash(_lights),
  );

  /// Create a copy of AiPatch
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AiPatchImplCopyWith<_$AiPatchImpl> get copyWith =>
      __$$AiPatchImplCopyWithImpl<_$AiPatchImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AiPatchImplToJson(this);
  }
}

abstract class _AiPatch implements AiPatch {
  const factory _AiPatch({
    @JsonKey(name: 'ceiling_h') final double? ceilingH,
    @JsonKey(name: 'wall_lengths') final Map<String, double>? wallLengths,
    final Map<String, String>? surfaces,
    @JsonKey(name: 'material_colors') final Map<String, String>? materialColors,
    final List<Map<String, dynamic>>? furniture,
    final List<Map<String, dynamic>>? lights,
  }) = _$AiPatchImpl;

  factory _AiPatch.fromJson(Map<String, dynamic> json) = _$AiPatchImpl.fromJson;

  @override
  @JsonKey(name: 'ceiling_h')
  double? get ceilingH;
  @override
  @JsonKey(name: 'wall_lengths')
  Map<String, double>? get wallLengths;
  @override
  Map<String, String>? get surfaces;
  @override
  @JsonKey(name: 'material_colors')
  Map<String, String>? get materialColors;
  @override
  List<Map<String, dynamic>>? get furniture;
  @override
  List<Map<String, dynamic>>? get lights;

  /// Create a copy of AiPatch
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AiPatchImplCopyWith<_$AiPatchImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SmetaAnswer _$SmetaAnswerFromJson(Map<String, dynamic> json) {
  return _SmetaAnswer.fromJson(json);
}

/// @nodoc
mixin _$SmetaAnswer {
  @JsonKey(name: 'answer_uz')
  String get answerUz => throw _privateConstructorUsedError;
  @JsonKey(name: 'related_line_ids')
  List<String> get relatedLineIds => throw _privateConstructorUsedError;

  /// Serializes this SmetaAnswer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SmetaAnswer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SmetaAnswerCopyWith<SmetaAnswer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SmetaAnswerCopyWith<$Res> {
  factory $SmetaAnswerCopyWith(
    SmetaAnswer value,
    $Res Function(SmetaAnswer) then,
  ) = _$SmetaAnswerCopyWithImpl<$Res, SmetaAnswer>;
  @useResult
  $Res call({
    @JsonKey(name: 'answer_uz') String answerUz,
    @JsonKey(name: 'related_line_ids') List<String> relatedLineIds,
  });
}

/// @nodoc
class _$SmetaAnswerCopyWithImpl<$Res, $Val extends SmetaAnswer>
    implements $SmetaAnswerCopyWith<$Res> {
  _$SmetaAnswerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SmetaAnswer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? answerUz = null, Object? relatedLineIds = null}) {
    return _then(
      _value.copyWith(
            answerUz: null == answerUz
                ? _value.answerUz
                : answerUz // ignore: cast_nullable_to_non_nullable
                      as String,
            relatedLineIds: null == relatedLineIds
                ? _value.relatedLineIds
                : relatedLineIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SmetaAnswerImplCopyWith<$Res>
    implements $SmetaAnswerCopyWith<$Res> {
  factory _$$SmetaAnswerImplCopyWith(
    _$SmetaAnswerImpl value,
    $Res Function(_$SmetaAnswerImpl) then,
  ) = __$$SmetaAnswerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'answer_uz') String answerUz,
    @JsonKey(name: 'related_line_ids') List<String> relatedLineIds,
  });
}

/// @nodoc
class __$$SmetaAnswerImplCopyWithImpl<$Res>
    extends _$SmetaAnswerCopyWithImpl<$Res, _$SmetaAnswerImpl>
    implements _$$SmetaAnswerImplCopyWith<$Res> {
  __$$SmetaAnswerImplCopyWithImpl(
    _$SmetaAnswerImpl _value,
    $Res Function(_$SmetaAnswerImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SmetaAnswer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? answerUz = null, Object? relatedLineIds = null}) {
    return _then(
      _$SmetaAnswerImpl(
        answerUz: null == answerUz
            ? _value.answerUz
            : answerUz // ignore: cast_nullable_to_non_nullable
                  as String,
        relatedLineIds: null == relatedLineIds
            ? _value._relatedLineIds
            : relatedLineIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SmetaAnswerImpl implements _SmetaAnswer {
  const _$SmetaAnswerImpl({
    @JsonKey(name: 'answer_uz') required this.answerUz,
    @JsonKey(name: 'related_line_ids')
    final List<String> relatedLineIds = const <String>[],
  }) : _relatedLineIds = relatedLineIds;

  factory _$SmetaAnswerImpl.fromJson(Map<String, dynamic> json) =>
      _$$SmetaAnswerImplFromJson(json);

  @override
  @JsonKey(name: 'answer_uz')
  final String answerUz;
  final List<String> _relatedLineIds;
  @override
  @JsonKey(name: 'related_line_ids')
  List<String> get relatedLineIds {
    if (_relatedLineIds is EqualUnmodifiableListView) return _relatedLineIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_relatedLineIds);
  }

  @override
  String toString() {
    return 'SmetaAnswer(answerUz: $answerUz, relatedLineIds: $relatedLineIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SmetaAnswerImpl &&
            (identical(other.answerUz, answerUz) ||
                other.answerUz == answerUz) &&
            const DeepCollectionEquality().equals(
              other._relatedLineIds,
              _relatedLineIds,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    answerUz,
    const DeepCollectionEquality().hash(_relatedLineIds),
  );

  /// Create a copy of SmetaAnswer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SmetaAnswerImplCopyWith<_$SmetaAnswerImpl> get copyWith =>
      __$$SmetaAnswerImplCopyWithImpl<_$SmetaAnswerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SmetaAnswerImplToJson(this);
  }
}

abstract class _SmetaAnswer implements SmetaAnswer {
  const factory _SmetaAnswer({
    @JsonKey(name: 'answer_uz') required final String answerUz,
    @JsonKey(name: 'related_line_ids') final List<String> relatedLineIds,
  }) = _$SmetaAnswerImpl;

  factory _SmetaAnswer.fromJson(Map<String, dynamic> json) =
      _$SmetaAnswerImpl.fromJson;

  @override
  @JsonKey(name: 'answer_uz')
  String get answerUz;
  @override
  @JsonKey(name: 'related_line_ids')
  List<String> get relatedLineIds;

  /// Create a copy of SmetaAnswer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SmetaAnswerImplCopyWith<_$SmetaAnswerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
