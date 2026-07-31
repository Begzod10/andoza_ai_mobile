// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'estimate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EstimateLineItemImpl _$$EstimateLineItemImplFromJson(
  Map<String, dynamic> json,
) => _$EstimateLineItemImpl(
  id: json['id'] as String,
  description: json['description'] as String,
  quantity: (json['quantity'] as num).toDouble(),
  unitPrice: (json['unitPrice'] as num).toDouble(),
  lineTotal: (json['lineTotal'] as num).toDouble(),
);

Map<String, dynamic> _$$EstimateLineItemImplToJson(
  _$EstimateLineItemImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'description': instance.description,
  'quantity': instance.quantity,
  'unitPrice': instance.unitPrice,
  'lineTotal': instance.lineTotal,
};

_$EstimateStageImpl _$$EstimateStageImplFromJson(Map<String, dynamic> json) =>
    _$EstimateStageImpl(
      name: $enumDecode(_$RenovationStageEnumMap, json['name']),
      lineItems:
          (json['lineItems'] as List<dynamic>?)
              ?.map((e) => EstimateLineItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <EstimateLineItem>[],
      subtotal: (json['subtotal'] as num).toDouble(),
      isExcluded: json['isExcluded'] as bool? ?? false,
      counterfactualSubtotal:
          (json['counterfactualSubtotal'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$$EstimateStageImplToJson(_$EstimateStageImpl instance) =>
    <String, dynamic>{
      'name': _$RenovationStageEnumMap[instance.name]!,
      'lineItems': instance.lineItems,
      'subtotal': instance.subtotal,
      'isExcluded': instance.isExcluded,
      'counterfactualSubtotal': instance.counterfactualSubtotal,
    };

const _$RenovationStageEnumMap = {
  RenovationStage.suvoq: 'SUVOQ',
  RenovationStage.shpaklovka: 'SHPAKLOVKA',
  RenovationStage.boyoqOboi: 'BOYOQ_OBOI',
  RenovationStage.pol: 'POL',
  RenovationStage.mebel: 'MEBEL',
  RenovationStage.elektr: 'ELEKTR',
  RenovationStage.yoruglik: 'YORUGLIK',
  RenovationStage.santexnika: 'SANTEXNIKA',
};

_$EstimateImpl _$$EstimateImplFromJson(Map<String, dynamic> json) =>
    _$EstimateImpl(
      id: json['id'] as String,
      roomId: json['roomId'] as String,
      roomArea: (json['roomArea'] as num).toDouble(),
      stages:
          (json['stages'] as List<dynamic>?)
              ?.map((e) => EstimateStage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <EstimateStage>[],
      totalPrice: (json['totalPrice'] as num).toDouble(),
      currency: json['currency'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$EstimateImplToJson(_$EstimateImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'roomId': instance.roomId,
      'roomArea': instance.roomArea,
      'stages': instance.stages,
      'totalPrice': instance.totalPrice,
      'currency': instance.currency,
      'createdAt': instance.createdAt.toIso8601String(),
    };
