// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeltaStageImpl _$$DeltaStageImplFromJson(Map<String, dynamic> json) =>
    _$DeltaStageImpl(
      stage: $enumDecode(_$RoomStateValueEnumMap, json['stage']),
      labelUz: json['label_uz'] as String,
      alreadyDone: json['already_done'] as bool,
    );

Map<String, dynamic> _$$DeltaStageImplToJson(_$DeltaStageImpl instance) =>
    <String, dynamic>{
      'stage': _$RoomStateValueEnumMap[instance.stage]!,
      'label_uz': instance.labelUz,
      'already_done': instance.alreadyDone,
    };

const _$RoomStateValueEnumMap = {
  RoomStateValue.xom: 'xom',
  RoomStateValue.suvoq: 'suvoq',
  RoomStateValue.shpaklovka: 'shpaklovka',
  RoomStateValue.tayyor: 'tayyor',
};

_$DeltaResponseImpl _$$DeltaResponseImplFromJson(Map<String, dynamic> json) =>
    _$DeltaResponseImpl(
      roomId: json['room_id'] as String,
      currentState: $enumDecode(_$RoomStateValueEnumMap, json['current_state']),
      fullLines:
          (json['full_lines'] as List<dynamic>?)
              ?.map((e) => EstimateLine.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <EstimateLine>[],
      fullTotalUzs: (json['full_total_uzs'] as num).toInt(),
      deltaLines:
          (json['delta_lines'] as List<dynamic>?)
              ?.map((e) => EstimateLine.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <EstimateLine>[],
      deltaTotalUzs: (json['delta_total_uzs'] as num).toInt(),
      deltaSavingsUzs: (json['delta_savings_uzs'] as num).toInt(),
      completedStages:
          (json['completed_stages'] as List<dynamic>?)
              ?.map((e) => DeltaStage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <DeltaStage>[],
      remainingStages:
          (json['remaining_stages'] as List<dynamic>?)
              ?.map((e) => DeltaStage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <DeltaStage>[],
    );

Map<String, dynamic> _$$DeltaResponseImplToJson(_$DeltaResponseImpl instance) =>
    <String, dynamic>{
      'room_id': instance.roomId,
      'current_state': _$RoomStateValueEnumMap[instance.currentState]!,
      'full_lines': instance.fullLines,
      'full_total_uzs': instance.fullTotalUzs,
      'delta_lines': instance.deltaLines,
      'delta_total_uzs': instance.deltaTotalUzs,
      'delta_savings_uzs': instance.deltaSavingsUzs,
      'completed_stages': instance.completedStages,
      'remaining_stages': instance.remainingStages,
    };
