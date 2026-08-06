// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AiPatchImpl _$$AiPatchImplFromJson(Map<String, dynamic> json) =>
    _$AiPatchImpl(
      ceilingH: (json['ceiling_h'] as num?)?.toDouble(),
      wallLengths: (json['wall_lengths'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      surfaces: (json['surfaces'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      materialColors: (json['material_colors'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      furniture: (json['furniture'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      lights: (json['lights'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$$AiPatchImplToJson(_$AiPatchImpl instance) =>
    <String, dynamic>{
      'ceiling_h': instance.ceilingH,
      'wall_lengths': instance.wallLengths,
      'surfaces': instance.surfaces,
      'material_colors': instance.materialColors,
      'furniture': instance.furniture,
      'lights': instance.lights,
    };

_$SmetaAnswerImpl _$$SmetaAnswerImplFromJson(Map<String, dynamic> json) =>
    _$SmetaAnswerImpl(
      answerUz: json['answer_uz'] as String,
      relatedLineIds:
          (json['related_line_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$$SmetaAnswerImplToJson(_$SmetaAnswerImpl instance) =>
    <String, dynamic>{
      'answer_uz': instance.answerUz,
      'related_line_ids': instance.relatedLineIds,
    };
