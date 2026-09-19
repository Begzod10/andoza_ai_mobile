// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delta.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeltaStage {

@JsonKey(unknownEnumValue: RoomStateValue.unknown) RoomStateValue get stage;@JsonKey(name: 'label_uz') String get labelUz;@JsonKey(name: 'already_done') bool get alreadyDone;
/// Create a copy of DeltaStage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeltaStageCopyWith<DeltaStage> get copyWith => _$DeltaStageCopyWithImpl<DeltaStage>(this as DeltaStage, _$identity);

  /// Serializes this DeltaStage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DeltaStage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeltaStage&&(identical(other.stage, _this.stage) || other.stage == _this.stage)&&(identical(other.labelUz, _this.labelUz) || other.labelUz == _this.labelUz)&&(identical(other.alreadyDone, _this.alreadyDone) || other.alreadyDone == _this.alreadyDone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DeltaStage;
  return Object.hash(runtimeType,_this.stage,_this.labelUz,_this.alreadyDone);
}

@override
String toString() {
  final _this = this as DeltaStage;
  return 'DeltaStage(stage: ${_this.stage}, labelUz: ${_this.labelUz}, alreadyDone: ${_this.alreadyDone})';
}


}

/// @nodoc
abstract mixin class $DeltaStageCopyWith<$Res>  {
  factory $DeltaStageCopyWith(DeltaStage value, $Res Function(DeltaStage) _then) = _$DeltaStageCopyWithImpl;
@useResult
$Res call({
@JsonKey(unknownEnumValue: RoomStateValue.unknown) RoomStateValue stage,@JsonKey(name: 'label_uz') String labelUz,@JsonKey(name: 'already_done') bool alreadyDone
});




}
/// @nodoc
class _$DeltaStageCopyWithImpl<$Res>
    implements $DeltaStageCopyWith<$Res> {
  _$DeltaStageCopyWithImpl(this._self, this._then);

  final DeltaStage _self;
  final $Res Function(DeltaStage) _then;

/// Create a copy of DeltaStage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stage = null,Object? labelUz = null,Object? alreadyDone = null,}) {
  return _then(DeltaStage(
stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as RoomStateValue,labelUz: null == labelUz ? _self.labelUz : labelUz // ignore: cast_nullable_to_non_nullable
as String,alreadyDone: null == alreadyDone ? _self.alreadyDone : alreadyDone // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [DeltaStage].
extension DeltaStagePatterns on DeltaStage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeltaStage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeltaStage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeltaStage value)  $default,){
final _that = this;
switch (_that) {
case _DeltaStage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeltaStage value)?  $default,){
final _that = this;
switch (_that) {
case _DeltaStage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: RoomStateValue.unknown)  RoomStateValue stage, @JsonKey(name: 'label_uz')  String labelUz, @JsonKey(name: 'already_done')  bool alreadyDone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeltaStage() when $default != null:
return $default(_that.stage,_that.labelUz,_that.alreadyDone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: RoomStateValue.unknown)  RoomStateValue stage, @JsonKey(name: 'label_uz')  String labelUz, @JsonKey(name: 'already_done')  bool alreadyDone)  $default,) {final _that = this;
switch (_that) {
case _DeltaStage():
return $default(_that.stage,_that.labelUz,_that.alreadyDone);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(unknownEnumValue: RoomStateValue.unknown)  RoomStateValue stage, @JsonKey(name: 'label_uz')  String labelUz, @JsonKey(name: 'already_done')  bool alreadyDone)?  $default,) {final _that = this;
switch (_that) {
case _DeltaStage() when $default != null:
return $default(_that.stage,_that.labelUz,_that.alreadyDone);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeltaStage implements DeltaStage {
  const _DeltaStage({@JsonKey(unknownEnumValue: RoomStateValue.unknown) required this.stage, @JsonKey(name: 'label_uz') required this.labelUz, @JsonKey(name: 'already_done') required this.alreadyDone});
  factory _DeltaStage.fromJson(Map<String, dynamic> json) => _$DeltaStageFromJson(json);

@override@JsonKey(unknownEnumValue: RoomStateValue.unknown) final  RoomStateValue stage;
@override@JsonKey(name: 'label_uz') final  String labelUz;
@override@JsonKey(name: 'already_done') final  bool alreadyDone;

/// Create a copy of DeltaStage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeltaStageCopyWith<_DeltaStage> get copyWith => __$DeltaStageCopyWithImpl<_DeltaStage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeltaStageToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeltaStage&&(identical(other.stage, stage) || other.stage == stage)&&(identical(other.labelUz, labelUz) || other.labelUz == labelUz)&&(identical(other.alreadyDone, alreadyDone) || other.alreadyDone == alreadyDone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,stage,labelUz,alreadyDone);
}

@override
String toString() {
    return 'DeltaStage(stage: $stage, labelUz: $labelUz, alreadyDone: $alreadyDone)';
}


}

/// @nodoc
abstract mixin class _$DeltaStageCopyWith<$Res> implements $DeltaStageCopyWith<$Res> {
  factory _$DeltaStageCopyWith(_DeltaStage value, $Res Function(_DeltaStage) _then) = __$DeltaStageCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(unknownEnumValue: RoomStateValue.unknown) RoomStateValue stage,@JsonKey(name: 'label_uz') String labelUz,@JsonKey(name: 'already_done') bool alreadyDone
});




}
/// @nodoc
class __$DeltaStageCopyWithImpl<$Res>
    implements _$DeltaStageCopyWith<$Res> {
  __$DeltaStageCopyWithImpl(this._self, this._then);

  final _DeltaStage _self;
  final $Res Function(_DeltaStage) _then;

/// Create a copy of DeltaStage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stage = null,Object? labelUz = null,Object? alreadyDone = null,}) {
  return _then(_DeltaStage(
stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as RoomStateValue,labelUz: null == labelUz ? _self.labelUz : labelUz // ignore: cast_nullable_to_non_nullable
as String,alreadyDone: null == alreadyDone ? _self.alreadyDone : alreadyDone // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$DeltaResponse {

@JsonKey(name: 'room_id') String get roomId;@JsonKey(name: 'current_state', unknownEnumValue: RoomStateValue.unknown) RoomStateValue get currentState;@JsonKey(name: 'full_lines') List<EstimateLine> get fullLines;@JsonKey(name: 'full_total_uzs') int get fullTotalUzs;@JsonKey(name: 'delta_lines') List<EstimateLine> get deltaLines;@JsonKey(name: 'delta_total_uzs') int get deltaTotalUzs;@JsonKey(name: 'delta_savings_uzs') int get deltaSavingsUzs;@JsonKey(name: 'completed_stages') List<DeltaStage> get completedStages;@JsonKey(name: 'remaining_stages') List<DeltaStage> get remainingStages;
/// Create a copy of DeltaResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeltaResponseCopyWith<DeltaResponse> get copyWith => _$DeltaResponseCopyWithImpl<DeltaResponse>(this as DeltaResponse, _$identity);

  /// Serializes this DeltaResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DeltaResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeltaResponse&&(identical(other.roomId, _this.roomId) || other.roomId == _this.roomId)&&(identical(other.currentState, _this.currentState) || other.currentState == _this.currentState)&&const DeepCollectionEquality().equals(other.fullLines, _this.fullLines)&&(identical(other.fullTotalUzs, _this.fullTotalUzs) || other.fullTotalUzs == _this.fullTotalUzs)&&const DeepCollectionEquality().equals(other.deltaLines, _this.deltaLines)&&(identical(other.deltaTotalUzs, _this.deltaTotalUzs) || other.deltaTotalUzs == _this.deltaTotalUzs)&&(identical(other.deltaSavingsUzs, _this.deltaSavingsUzs) || other.deltaSavingsUzs == _this.deltaSavingsUzs)&&const DeepCollectionEquality().equals(other.completedStages, _this.completedStages)&&const DeepCollectionEquality().equals(other.remainingStages, _this.remainingStages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DeltaResponse;
  return Object.hash(runtimeType,_this.roomId,_this.currentState,const DeepCollectionEquality().hash(_this.fullLines),_this.fullTotalUzs,const DeepCollectionEquality().hash(_this.deltaLines),_this.deltaTotalUzs,_this.deltaSavingsUzs,const DeepCollectionEquality().hash(_this.completedStages),const DeepCollectionEquality().hash(_this.remainingStages));
}

@override
String toString() {
  final _this = this as DeltaResponse;
  return 'DeltaResponse(roomId: ${_this.roomId}, currentState: ${_this.currentState}, fullLines: ${_this.fullLines}, fullTotalUzs: ${_this.fullTotalUzs}, deltaLines: ${_this.deltaLines}, deltaTotalUzs: ${_this.deltaTotalUzs}, deltaSavingsUzs: ${_this.deltaSavingsUzs}, completedStages: ${_this.completedStages}, remainingStages: ${_this.remainingStages})';
}


}

/// @nodoc
abstract mixin class $DeltaResponseCopyWith<$Res>  {
  factory $DeltaResponseCopyWith(DeltaResponse value, $Res Function(DeltaResponse) _then) = _$DeltaResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'room_id') String roomId,@JsonKey(name: 'current_state', unknownEnumValue: RoomStateValue.unknown) RoomStateValue currentState,@JsonKey(name: 'full_lines') List<EstimateLine> fullLines,@JsonKey(name: 'full_total_uzs') int fullTotalUzs,@JsonKey(name: 'delta_lines') List<EstimateLine> deltaLines,@JsonKey(name: 'delta_total_uzs') int deltaTotalUzs,@JsonKey(name: 'delta_savings_uzs') int deltaSavingsUzs,@JsonKey(name: 'completed_stages') List<DeltaStage> completedStages,@JsonKey(name: 'remaining_stages') List<DeltaStage> remainingStages
});




}
/// @nodoc
class _$DeltaResponseCopyWithImpl<$Res>
    implements $DeltaResponseCopyWith<$Res> {
  _$DeltaResponseCopyWithImpl(this._self, this._then);

  final DeltaResponse _self;
  final $Res Function(DeltaResponse) _then;

/// Create a copy of DeltaResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? roomId = null,Object? currentState = null,Object? fullLines = null,Object? fullTotalUzs = null,Object? deltaLines = null,Object? deltaTotalUzs = null,Object? deltaSavingsUzs = null,Object? completedStages = null,Object? remainingStages = null,}) {
  return _then(DeltaResponse(
roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,currentState: null == currentState ? _self.currentState : currentState // ignore: cast_nullable_to_non_nullable
as RoomStateValue,fullLines: null == fullLines ? _self.fullLines : fullLines // ignore: cast_nullable_to_non_nullable
as List<EstimateLine>,fullTotalUzs: null == fullTotalUzs ? _self.fullTotalUzs : fullTotalUzs // ignore: cast_nullable_to_non_nullable
as int,deltaLines: null == deltaLines ? _self.deltaLines : deltaLines // ignore: cast_nullable_to_non_nullable
as List<EstimateLine>,deltaTotalUzs: null == deltaTotalUzs ? _self.deltaTotalUzs : deltaTotalUzs // ignore: cast_nullable_to_non_nullable
as int,deltaSavingsUzs: null == deltaSavingsUzs ? _self.deltaSavingsUzs : deltaSavingsUzs // ignore: cast_nullable_to_non_nullable
as int,completedStages: null == completedStages ? _self.completedStages : completedStages // ignore: cast_nullable_to_non_nullable
as List<DeltaStage>,remainingStages: null == remainingStages ? _self.remainingStages : remainingStages // ignore: cast_nullable_to_non_nullable
as List<DeltaStage>,
  ));
}

}


/// Adds pattern-matching-related methods to [DeltaResponse].
extension DeltaResponsePatterns on DeltaResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeltaResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeltaResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeltaResponse value)  $default,){
final _that = this;
switch (_that) {
case _DeltaResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeltaResponse value)?  $default,){
final _that = this;
switch (_that) {
case _DeltaResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'room_id')  String roomId, @JsonKey(name: 'current_state', unknownEnumValue: RoomStateValue.unknown)  RoomStateValue currentState, @JsonKey(name: 'full_lines')  List<EstimateLine> fullLines, @JsonKey(name: 'full_total_uzs')  int fullTotalUzs, @JsonKey(name: 'delta_lines')  List<EstimateLine> deltaLines, @JsonKey(name: 'delta_total_uzs')  int deltaTotalUzs, @JsonKey(name: 'delta_savings_uzs')  int deltaSavingsUzs, @JsonKey(name: 'completed_stages')  List<DeltaStage> completedStages, @JsonKey(name: 'remaining_stages')  List<DeltaStage> remainingStages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeltaResponse() when $default != null:
return $default(_that.roomId,_that.currentState,_that.fullLines,_that.fullTotalUzs,_that.deltaLines,_that.deltaTotalUzs,_that.deltaSavingsUzs,_that.completedStages,_that.remainingStages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'room_id')  String roomId, @JsonKey(name: 'current_state', unknownEnumValue: RoomStateValue.unknown)  RoomStateValue currentState, @JsonKey(name: 'full_lines')  List<EstimateLine> fullLines, @JsonKey(name: 'full_total_uzs')  int fullTotalUzs, @JsonKey(name: 'delta_lines')  List<EstimateLine> deltaLines, @JsonKey(name: 'delta_total_uzs')  int deltaTotalUzs, @JsonKey(name: 'delta_savings_uzs')  int deltaSavingsUzs, @JsonKey(name: 'completed_stages')  List<DeltaStage> completedStages, @JsonKey(name: 'remaining_stages')  List<DeltaStage> remainingStages)  $default,) {final _that = this;
switch (_that) {
case _DeltaResponse():
return $default(_that.roomId,_that.currentState,_that.fullLines,_that.fullTotalUzs,_that.deltaLines,_that.deltaTotalUzs,_that.deltaSavingsUzs,_that.completedStages,_that.remainingStages);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'room_id')  String roomId, @JsonKey(name: 'current_state', unknownEnumValue: RoomStateValue.unknown)  RoomStateValue currentState, @JsonKey(name: 'full_lines')  List<EstimateLine> fullLines, @JsonKey(name: 'full_total_uzs')  int fullTotalUzs, @JsonKey(name: 'delta_lines')  List<EstimateLine> deltaLines, @JsonKey(name: 'delta_total_uzs')  int deltaTotalUzs, @JsonKey(name: 'delta_savings_uzs')  int deltaSavingsUzs, @JsonKey(name: 'completed_stages')  List<DeltaStage> completedStages, @JsonKey(name: 'remaining_stages')  List<DeltaStage> remainingStages)?  $default,) {final _that = this;
switch (_that) {
case _DeltaResponse() when $default != null:
return $default(_that.roomId,_that.currentState,_that.fullLines,_that.fullTotalUzs,_that.deltaLines,_that.deltaTotalUzs,_that.deltaSavingsUzs,_that.completedStages,_that.remainingStages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeltaResponse implements DeltaResponse {
  const _DeltaResponse({@JsonKey(name: 'room_id') required this.roomId, @JsonKey(name: 'current_state', unknownEnumValue: RoomStateValue.unknown) required this.currentState, @JsonKey(name: 'full_lines')  List<EstimateLine> fullLines = const <EstimateLine>[], @JsonKey(name: 'full_total_uzs') required this.fullTotalUzs, @JsonKey(name: 'delta_lines')  List<EstimateLine> deltaLines = const <EstimateLine>[], @JsonKey(name: 'delta_total_uzs') required this.deltaTotalUzs, @JsonKey(name: 'delta_savings_uzs') required this.deltaSavingsUzs, @JsonKey(name: 'completed_stages')  List<DeltaStage> completedStages = const <DeltaStage>[], @JsonKey(name: 'remaining_stages')  List<DeltaStage> remainingStages = const <DeltaStage>[]}): _fullLines = fullLines,_deltaLines = deltaLines,_completedStages = completedStages,_remainingStages = remainingStages;
  factory _DeltaResponse.fromJson(Map<String, dynamic> json) => _$DeltaResponseFromJson(json);

@override@JsonKey(name: 'room_id') final  String roomId;
@override@JsonKey(name: 'current_state', unknownEnumValue: RoomStateValue.unknown) final  RoomStateValue currentState;
 final  List<EstimateLine> _fullLines;
@override@JsonKey(name: 'full_lines') List<EstimateLine> get fullLines {
  if (_fullLines is EqualUnmodifiableListView) return _fullLines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fullLines);
}

@override@JsonKey(name: 'full_total_uzs') final  int fullTotalUzs;
 final  List<EstimateLine> _deltaLines;
@override@JsonKey(name: 'delta_lines') List<EstimateLine> get deltaLines {
  if (_deltaLines is EqualUnmodifiableListView) return _deltaLines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_deltaLines);
}

@override@JsonKey(name: 'delta_total_uzs') final  int deltaTotalUzs;
@override@JsonKey(name: 'delta_savings_uzs') final  int deltaSavingsUzs;
 final  List<DeltaStage> _completedStages;
@override@JsonKey(name: 'completed_stages') List<DeltaStage> get completedStages {
  if (_completedStages is EqualUnmodifiableListView) return _completedStages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_completedStages);
}

 final  List<DeltaStage> _remainingStages;
@override@JsonKey(name: 'remaining_stages') List<DeltaStage> get remainingStages {
  if (_remainingStages is EqualUnmodifiableListView) return _remainingStages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_remainingStages);
}


/// Create a copy of DeltaResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeltaResponseCopyWith<_DeltaResponse> get copyWith => __$DeltaResponseCopyWithImpl<_DeltaResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeltaResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeltaResponse&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.currentState, currentState) || other.currentState == currentState)&&const DeepCollectionEquality().equals(other.fullLines, _fullLines)&&(identical(other.fullTotalUzs, fullTotalUzs) || other.fullTotalUzs == fullTotalUzs)&&const DeepCollectionEquality().equals(other.deltaLines, _deltaLines)&&(identical(other.deltaTotalUzs, deltaTotalUzs) || other.deltaTotalUzs == deltaTotalUzs)&&(identical(other.deltaSavingsUzs, deltaSavingsUzs) || other.deltaSavingsUzs == deltaSavingsUzs)&&const DeepCollectionEquality().equals(other.completedStages, _completedStages)&&const DeepCollectionEquality().equals(other.remainingStages, _remainingStages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,roomId,currentState,const DeepCollectionEquality().hash(_fullLines),fullTotalUzs,const DeepCollectionEquality().hash(_deltaLines),deltaTotalUzs,deltaSavingsUzs,const DeepCollectionEquality().hash(_completedStages),const DeepCollectionEquality().hash(_remainingStages));
}

@override
String toString() {
    return 'DeltaResponse(roomId: $roomId, currentState: $currentState, fullLines: $fullLines, fullTotalUzs: $fullTotalUzs, deltaLines: $deltaLines, deltaTotalUzs: $deltaTotalUzs, deltaSavingsUzs: $deltaSavingsUzs, completedStages: $completedStages, remainingStages: $remainingStages)';
}


}

/// @nodoc
abstract mixin class _$DeltaResponseCopyWith<$Res> implements $DeltaResponseCopyWith<$Res> {
  factory _$DeltaResponseCopyWith(_DeltaResponse value, $Res Function(_DeltaResponse) _then) = __$DeltaResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'room_id') String roomId,@JsonKey(name: 'current_state', unknownEnumValue: RoomStateValue.unknown) RoomStateValue currentState,@JsonKey(name: 'full_lines') List<EstimateLine> fullLines,@JsonKey(name: 'full_total_uzs') int fullTotalUzs,@JsonKey(name: 'delta_lines') List<EstimateLine> deltaLines,@JsonKey(name: 'delta_total_uzs') int deltaTotalUzs,@JsonKey(name: 'delta_savings_uzs') int deltaSavingsUzs,@JsonKey(name: 'completed_stages') List<DeltaStage> completedStages,@JsonKey(name: 'remaining_stages') List<DeltaStage> remainingStages
});




}
/// @nodoc
class __$DeltaResponseCopyWithImpl<$Res>
    implements _$DeltaResponseCopyWith<$Res> {
  __$DeltaResponseCopyWithImpl(this._self, this._then);

  final _DeltaResponse _self;
  final $Res Function(_DeltaResponse) _then;

/// Create a copy of DeltaResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? roomId = null,Object? currentState = null,Object? fullLines = null,Object? fullTotalUzs = null,Object? deltaLines = null,Object? deltaTotalUzs = null,Object? deltaSavingsUzs = null,Object? completedStages = null,Object? remainingStages = null,}) {
  return _then(_DeltaResponse(
roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,currentState: null == currentState ? _self.currentState : currentState // ignore: cast_nullable_to_non_nullable
as RoomStateValue,fullLines: null == fullLines ? _self._fullLines : fullLines // ignore: cast_nullable_to_non_nullable
as List<EstimateLine>,fullTotalUzs: null == fullTotalUzs ? _self.fullTotalUzs : fullTotalUzs // ignore: cast_nullable_to_non_nullable
as int,deltaLines: null == deltaLines ? _self._deltaLines : deltaLines // ignore: cast_nullable_to_non_nullable
as List<EstimateLine>,deltaTotalUzs: null == deltaTotalUzs ? _self.deltaTotalUzs : deltaTotalUzs // ignore: cast_nullable_to_non_nullable
as int,deltaSavingsUzs: null == deltaSavingsUzs ? _self.deltaSavingsUzs : deltaSavingsUzs // ignore: cast_nullable_to_non_nullable
as int,completedStages: null == completedStages ? _self._completedStages : completedStages // ignore: cast_nullable_to_non_nullable
as List<DeltaStage>,remainingStages: null == remainingStages ? _self._remainingStages : remainingStages // ignore: cast_nullable_to_non_nullable
as List<DeltaStage>,
  ));
}


}

// dart format on
