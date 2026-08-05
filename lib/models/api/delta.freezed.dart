// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delta.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DeltaStage _$DeltaStageFromJson(Map<String, dynamic> json) {
  return _DeltaStage.fromJson(json);
}

/// @nodoc
mixin _$DeltaStage {
  RoomStateValue get stage => throw _privateConstructorUsedError;
  @JsonKey(name: 'label_uz')
  String get labelUz => throw _privateConstructorUsedError;
  @JsonKey(name: 'already_done')
  bool get alreadyDone => throw _privateConstructorUsedError;

  /// Serializes this DeltaStage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeltaStage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeltaStageCopyWith<DeltaStage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeltaStageCopyWith<$Res> {
  factory $DeltaStageCopyWith(
    DeltaStage value,
    $Res Function(DeltaStage) then,
  ) = _$DeltaStageCopyWithImpl<$Res, DeltaStage>;
  @useResult
  $Res call({
    RoomStateValue stage,
    @JsonKey(name: 'label_uz') String labelUz,
    @JsonKey(name: 'already_done') bool alreadyDone,
  });
}

/// @nodoc
class _$DeltaStageCopyWithImpl<$Res, $Val extends DeltaStage>
    implements $DeltaStageCopyWith<$Res> {
  _$DeltaStageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeltaStage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stage = null,
    Object? labelUz = null,
    Object? alreadyDone = null,
  }) {
    return _then(
      _value.copyWith(
            stage: null == stage
                ? _value.stage
                : stage // ignore: cast_nullable_to_non_nullable
                      as RoomStateValue,
            labelUz: null == labelUz
                ? _value.labelUz
                : labelUz // ignore: cast_nullable_to_non_nullable
                      as String,
            alreadyDone: null == alreadyDone
                ? _value.alreadyDone
                : alreadyDone // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DeltaStageImplCopyWith<$Res>
    implements $DeltaStageCopyWith<$Res> {
  factory _$$DeltaStageImplCopyWith(
    _$DeltaStageImpl value,
    $Res Function(_$DeltaStageImpl) then,
  ) = __$$DeltaStageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    RoomStateValue stage,
    @JsonKey(name: 'label_uz') String labelUz,
    @JsonKey(name: 'already_done') bool alreadyDone,
  });
}

/// @nodoc
class __$$DeltaStageImplCopyWithImpl<$Res>
    extends _$DeltaStageCopyWithImpl<$Res, _$DeltaStageImpl>
    implements _$$DeltaStageImplCopyWith<$Res> {
  __$$DeltaStageImplCopyWithImpl(
    _$DeltaStageImpl _value,
    $Res Function(_$DeltaStageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DeltaStage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stage = null,
    Object? labelUz = null,
    Object? alreadyDone = null,
  }) {
    return _then(
      _$DeltaStageImpl(
        stage: null == stage
            ? _value.stage
            : stage // ignore: cast_nullable_to_non_nullable
                  as RoomStateValue,
        labelUz: null == labelUz
            ? _value.labelUz
            : labelUz // ignore: cast_nullable_to_non_nullable
                  as String,
        alreadyDone: null == alreadyDone
            ? _value.alreadyDone
            : alreadyDone // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DeltaStageImpl implements _DeltaStage {
  const _$DeltaStageImpl({
    required this.stage,
    @JsonKey(name: 'label_uz') required this.labelUz,
    @JsonKey(name: 'already_done') required this.alreadyDone,
  });

  factory _$DeltaStageImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeltaStageImplFromJson(json);

  @override
  final RoomStateValue stage;
  @override
  @JsonKey(name: 'label_uz')
  final String labelUz;
  @override
  @JsonKey(name: 'already_done')
  final bool alreadyDone;

  @override
  String toString() {
    return 'DeltaStage(stage: $stage, labelUz: $labelUz, alreadyDone: $alreadyDone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeltaStageImpl &&
            (identical(other.stage, stage) || other.stage == stage) &&
            (identical(other.labelUz, labelUz) || other.labelUz == labelUz) &&
            (identical(other.alreadyDone, alreadyDone) ||
                other.alreadyDone == alreadyDone));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, stage, labelUz, alreadyDone);

  /// Create a copy of DeltaStage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeltaStageImplCopyWith<_$DeltaStageImpl> get copyWith =>
      __$$DeltaStageImplCopyWithImpl<_$DeltaStageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeltaStageImplToJson(this);
  }
}

abstract class _DeltaStage implements DeltaStage {
  const factory _DeltaStage({
    required final RoomStateValue stage,
    @JsonKey(name: 'label_uz') required final String labelUz,
    @JsonKey(name: 'already_done') required final bool alreadyDone,
  }) = _$DeltaStageImpl;

  factory _DeltaStage.fromJson(Map<String, dynamic> json) =
      _$DeltaStageImpl.fromJson;

  @override
  RoomStateValue get stage;
  @override
  @JsonKey(name: 'label_uz')
  String get labelUz;
  @override
  @JsonKey(name: 'already_done')
  bool get alreadyDone;

  /// Create a copy of DeltaStage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeltaStageImplCopyWith<_$DeltaStageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DeltaResponse _$DeltaResponseFromJson(Map<String, dynamic> json) {
  return _DeltaResponse.fromJson(json);
}

/// @nodoc
mixin _$DeltaResponse {
  @JsonKey(name: 'room_id')
  String get roomId => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_state')
  RoomStateValue get currentState => throw _privateConstructorUsedError;
  @JsonKey(name: 'full_lines')
  List<EstimateLine> get fullLines => throw _privateConstructorUsedError;
  @JsonKey(name: 'full_total_uzs')
  int get fullTotalUzs => throw _privateConstructorUsedError;
  @JsonKey(name: 'delta_lines')
  List<EstimateLine> get deltaLines => throw _privateConstructorUsedError;
  @JsonKey(name: 'delta_total_uzs')
  int get deltaTotalUzs => throw _privateConstructorUsedError;
  @JsonKey(name: 'delta_savings_uzs')
  int get deltaSavingsUzs => throw _privateConstructorUsedError;
  @JsonKey(name: 'completed_stages')
  List<DeltaStage> get completedStages => throw _privateConstructorUsedError;
  @JsonKey(name: 'remaining_stages')
  List<DeltaStage> get remainingStages => throw _privateConstructorUsedError;

  /// Serializes this DeltaResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeltaResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeltaResponseCopyWith<DeltaResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeltaResponseCopyWith<$Res> {
  factory $DeltaResponseCopyWith(
    DeltaResponse value,
    $Res Function(DeltaResponse) then,
  ) = _$DeltaResponseCopyWithImpl<$Res, DeltaResponse>;
  @useResult
  $Res call({
    @JsonKey(name: 'room_id') String roomId,
    @JsonKey(name: 'current_state') RoomStateValue currentState,
    @JsonKey(name: 'full_lines') List<EstimateLine> fullLines,
    @JsonKey(name: 'full_total_uzs') int fullTotalUzs,
    @JsonKey(name: 'delta_lines') List<EstimateLine> deltaLines,
    @JsonKey(name: 'delta_total_uzs') int deltaTotalUzs,
    @JsonKey(name: 'delta_savings_uzs') int deltaSavingsUzs,
    @JsonKey(name: 'completed_stages') List<DeltaStage> completedStages,
    @JsonKey(name: 'remaining_stages') List<DeltaStage> remainingStages,
  });
}

/// @nodoc
class _$DeltaResponseCopyWithImpl<$Res, $Val extends DeltaResponse>
    implements $DeltaResponseCopyWith<$Res> {
  _$DeltaResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeltaResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roomId = null,
    Object? currentState = null,
    Object? fullLines = null,
    Object? fullTotalUzs = null,
    Object? deltaLines = null,
    Object? deltaTotalUzs = null,
    Object? deltaSavingsUzs = null,
    Object? completedStages = null,
    Object? remainingStages = null,
  }) {
    return _then(
      _value.copyWith(
            roomId: null == roomId
                ? _value.roomId
                : roomId // ignore: cast_nullable_to_non_nullable
                      as String,
            currentState: null == currentState
                ? _value.currentState
                : currentState // ignore: cast_nullable_to_non_nullable
                      as RoomStateValue,
            fullLines: null == fullLines
                ? _value.fullLines
                : fullLines // ignore: cast_nullable_to_non_nullable
                      as List<EstimateLine>,
            fullTotalUzs: null == fullTotalUzs
                ? _value.fullTotalUzs
                : fullTotalUzs // ignore: cast_nullable_to_non_nullable
                      as int,
            deltaLines: null == deltaLines
                ? _value.deltaLines
                : deltaLines // ignore: cast_nullable_to_non_nullable
                      as List<EstimateLine>,
            deltaTotalUzs: null == deltaTotalUzs
                ? _value.deltaTotalUzs
                : deltaTotalUzs // ignore: cast_nullable_to_non_nullable
                      as int,
            deltaSavingsUzs: null == deltaSavingsUzs
                ? _value.deltaSavingsUzs
                : deltaSavingsUzs // ignore: cast_nullable_to_non_nullable
                      as int,
            completedStages: null == completedStages
                ? _value.completedStages
                : completedStages // ignore: cast_nullable_to_non_nullable
                      as List<DeltaStage>,
            remainingStages: null == remainingStages
                ? _value.remainingStages
                : remainingStages // ignore: cast_nullable_to_non_nullable
                      as List<DeltaStage>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DeltaResponseImplCopyWith<$Res>
    implements $DeltaResponseCopyWith<$Res> {
  factory _$$DeltaResponseImplCopyWith(
    _$DeltaResponseImpl value,
    $Res Function(_$DeltaResponseImpl) then,
  ) = __$$DeltaResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'room_id') String roomId,
    @JsonKey(name: 'current_state') RoomStateValue currentState,
    @JsonKey(name: 'full_lines') List<EstimateLine> fullLines,
    @JsonKey(name: 'full_total_uzs') int fullTotalUzs,
    @JsonKey(name: 'delta_lines') List<EstimateLine> deltaLines,
    @JsonKey(name: 'delta_total_uzs') int deltaTotalUzs,
    @JsonKey(name: 'delta_savings_uzs') int deltaSavingsUzs,
    @JsonKey(name: 'completed_stages') List<DeltaStage> completedStages,
    @JsonKey(name: 'remaining_stages') List<DeltaStage> remainingStages,
  });
}

/// @nodoc
class __$$DeltaResponseImplCopyWithImpl<$Res>
    extends _$DeltaResponseCopyWithImpl<$Res, _$DeltaResponseImpl>
    implements _$$DeltaResponseImplCopyWith<$Res> {
  __$$DeltaResponseImplCopyWithImpl(
    _$DeltaResponseImpl _value,
    $Res Function(_$DeltaResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DeltaResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roomId = null,
    Object? currentState = null,
    Object? fullLines = null,
    Object? fullTotalUzs = null,
    Object? deltaLines = null,
    Object? deltaTotalUzs = null,
    Object? deltaSavingsUzs = null,
    Object? completedStages = null,
    Object? remainingStages = null,
  }) {
    return _then(
      _$DeltaResponseImpl(
        roomId: null == roomId
            ? _value.roomId
            : roomId // ignore: cast_nullable_to_non_nullable
                  as String,
        currentState: null == currentState
            ? _value.currentState
            : currentState // ignore: cast_nullable_to_non_nullable
                  as RoomStateValue,
        fullLines: null == fullLines
            ? _value._fullLines
            : fullLines // ignore: cast_nullable_to_non_nullable
                  as List<EstimateLine>,
        fullTotalUzs: null == fullTotalUzs
            ? _value.fullTotalUzs
            : fullTotalUzs // ignore: cast_nullable_to_non_nullable
                  as int,
        deltaLines: null == deltaLines
            ? _value._deltaLines
            : deltaLines // ignore: cast_nullable_to_non_nullable
                  as List<EstimateLine>,
        deltaTotalUzs: null == deltaTotalUzs
            ? _value.deltaTotalUzs
            : deltaTotalUzs // ignore: cast_nullable_to_non_nullable
                  as int,
        deltaSavingsUzs: null == deltaSavingsUzs
            ? _value.deltaSavingsUzs
            : deltaSavingsUzs // ignore: cast_nullable_to_non_nullable
                  as int,
        completedStages: null == completedStages
            ? _value._completedStages
            : completedStages // ignore: cast_nullable_to_non_nullable
                  as List<DeltaStage>,
        remainingStages: null == remainingStages
            ? _value._remainingStages
            : remainingStages // ignore: cast_nullable_to_non_nullable
                  as List<DeltaStage>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DeltaResponseImpl implements _DeltaResponse {
  const _$DeltaResponseImpl({
    @JsonKey(name: 'room_id') required this.roomId,
    @JsonKey(name: 'current_state') required this.currentState,
    @JsonKey(name: 'full_lines')
    final List<EstimateLine> fullLines = const <EstimateLine>[],
    @JsonKey(name: 'full_total_uzs') required this.fullTotalUzs,
    @JsonKey(name: 'delta_lines')
    final List<EstimateLine> deltaLines = const <EstimateLine>[],
    @JsonKey(name: 'delta_total_uzs') required this.deltaTotalUzs,
    @JsonKey(name: 'delta_savings_uzs') required this.deltaSavingsUzs,
    @JsonKey(name: 'completed_stages')
    final List<DeltaStage> completedStages = const <DeltaStage>[],
    @JsonKey(name: 'remaining_stages')
    final List<DeltaStage> remainingStages = const <DeltaStage>[],
  }) : _fullLines = fullLines,
       _deltaLines = deltaLines,
       _completedStages = completedStages,
       _remainingStages = remainingStages;

  factory _$DeltaResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeltaResponseImplFromJson(json);

  @override
  @JsonKey(name: 'room_id')
  final String roomId;
  @override
  @JsonKey(name: 'current_state')
  final RoomStateValue currentState;
  final List<EstimateLine> _fullLines;
  @override
  @JsonKey(name: 'full_lines')
  List<EstimateLine> get fullLines {
    if (_fullLines is EqualUnmodifiableListView) return _fullLines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fullLines);
  }

  @override
  @JsonKey(name: 'full_total_uzs')
  final int fullTotalUzs;
  final List<EstimateLine> _deltaLines;
  @override
  @JsonKey(name: 'delta_lines')
  List<EstimateLine> get deltaLines {
    if (_deltaLines is EqualUnmodifiableListView) return _deltaLines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_deltaLines);
  }

  @override
  @JsonKey(name: 'delta_total_uzs')
  final int deltaTotalUzs;
  @override
  @JsonKey(name: 'delta_savings_uzs')
  final int deltaSavingsUzs;
  final List<DeltaStage> _completedStages;
  @override
  @JsonKey(name: 'completed_stages')
  List<DeltaStage> get completedStages {
    if (_completedStages is EqualUnmodifiableListView) return _completedStages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_completedStages);
  }

  final List<DeltaStage> _remainingStages;
  @override
  @JsonKey(name: 'remaining_stages')
  List<DeltaStage> get remainingStages {
    if (_remainingStages is EqualUnmodifiableListView) return _remainingStages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_remainingStages);
  }

  @override
  String toString() {
    return 'DeltaResponse(roomId: $roomId, currentState: $currentState, fullLines: $fullLines, fullTotalUzs: $fullTotalUzs, deltaLines: $deltaLines, deltaTotalUzs: $deltaTotalUzs, deltaSavingsUzs: $deltaSavingsUzs, completedStages: $completedStages, remainingStages: $remainingStages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeltaResponseImpl &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.currentState, currentState) ||
                other.currentState == currentState) &&
            const DeepCollectionEquality().equals(
              other._fullLines,
              _fullLines,
            ) &&
            (identical(other.fullTotalUzs, fullTotalUzs) ||
                other.fullTotalUzs == fullTotalUzs) &&
            const DeepCollectionEquality().equals(
              other._deltaLines,
              _deltaLines,
            ) &&
            (identical(other.deltaTotalUzs, deltaTotalUzs) ||
                other.deltaTotalUzs == deltaTotalUzs) &&
            (identical(other.deltaSavingsUzs, deltaSavingsUzs) ||
                other.deltaSavingsUzs == deltaSavingsUzs) &&
            const DeepCollectionEquality().equals(
              other._completedStages,
              _completedStages,
            ) &&
            const DeepCollectionEquality().equals(
              other._remainingStages,
              _remainingStages,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    roomId,
    currentState,
    const DeepCollectionEquality().hash(_fullLines),
    fullTotalUzs,
    const DeepCollectionEquality().hash(_deltaLines),
    deltaTotalUzs,
    deltaSavingsUzs,
    const DeepCollectionEquality().hash(_completedStages),
    const DeepCollectionEquality().hash(_remainingStages),
  );

  /// Create a copy of DeltaResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeltaResponseImplCopyWith<_$DeltaResponseImpl> get copyWith =>
      __$$DeltaResponseImplCopyWithImpl<_$DeltaResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeltaResponseImplToJson(this);
  }
}

abstract class _DeltaResponse implements DeltaResponse {
  const factory _DeltaResponse({
    @JsonKey(name: 'room_id') required final String roomId,
    @JsonKey(name: 'current_state') required final RoomStateValue currentState,
    @JsonKey(name: 'full_lines') final List<EstimateLine> fullLines,
    @JsonKey(name: 'full_total_uzs') required final int fullTotalUzs,
    @JsonKey(name: 'delta_lines') final List<EstimateLine> deltaLines,
    @JsonKey(name: 'delta_total_uzs') required final int deltaTotalUzs,
    @JsonKey(name: 'delta_savings_uzs') required final int deltaSavingsUzs,
    @JsonKey(name: 'completed_stages') final List<DeltaStage> completedStages,
    @JsonKey(name: 'remaining_stages') final List<DeltaStage> remainingStages,
  }) = _$DeltaResponseImpl;

  factory _DeltaResponse.fromJson(Map<String, dynamic> json) =
      _$DeltaResponseImpl.fromJson;

  @override
  @JsonKey(name: 'room_id')
  String get roomId;
  @override
  @JsonKey(name: 'current_state')
  RoomStateValue get currentState;
  @override
  @JsonKey(name: 'full_lines')
  List<EstimateLine> get fullLines;
  @override
  @JsonKey(name: 'full_total_uzs')
  int get fullTotalUzs;
  @override
  @JsonKey(name: 'delta_lines')
  List<EstimateLine> get deltaLines;
  @override
  @JsonKey(name: 'delta_total_uzs')
  int get deltaTotalUzs;
  @override
  @JsonKey(name: 'delta_savings_uzs')
  int get deltaSavingsUzs;
  @override
  @JsonKey(name: 'completed_stages')
  List<DeltaStage> get completedStages;
  @override
  @JsonKey(name: 'remaining_stages')
  List<DeltaStage> get remainingStages;

  /// Create a copy of DeltaResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeltaResponseImplCopyWith<_$DeltaResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
