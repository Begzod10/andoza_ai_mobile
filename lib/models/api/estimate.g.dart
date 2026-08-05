// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'estimate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EstimateLineImpl _$$EstimateLineImplFromJson(Map<String, dynamic> json) =>
    _$EstimateLineImpl(
      label: json['label'] as String,
      formula: json['formula'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      unit: json['unit'] as String,
      unitPrice: (json['unit_price'] as num).toInt(),
      totalUzs: (json['total_uzs'] as num).toInt(),
      isApproximate: json['is_approximate'] as bool? ?? false,
      storeId: json['store_id'] as String?,
      category: json['category'] as String? ?? '',
    );

Map<String, dynamic> _$$EstimateLineImplToJson(_$EstimateLineImpl instance) =>
    <String, dynamic>{
      'label': instance.label,
      'formula': instance.formula,
      'quantity': instance.quantity,
      'unit': instance.unit,
      'unit_price': instance.unitPrice,
      'total_uzs': instance.totalUzs,
      'is_approximate': instance.isApproximate,
      'store_id': instance.storeId,
      'category': instance.category,
    };

_$EstimateImpl _$$EstimateImplFromJson(Map<String, dynamic> json) =>
    _$EstimateImpl(
      id: json['id'] as String,
      roomId: json['room_id'] as String,
      lines:
          (json['lines'] as List<dynamic>?)
              ?.map((e) => EstimateLine.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <EstimateLine>[],
      totalUzs: (json['total_uzs'] as num).toInt(),
      totalMin: (json['total_min'] as num).toInt(),
      totalMax: (json['total_max'] as num).toInt(),
      currency: json['currency'] as String? ?? 'UZS',
      status: json['status'] as String? ?? 'final',
      createdAt: DateTime.parse(json['created_at'] as String),
      hasElectrical: json['has_electrical'] as bool? ?? false,
    );

Map<String, dynamic> _$$EstimateImplToJson(_$EstimateImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'room_id': instance.roomId,
      'lines': instance.lines,
      'total_uzs': instance.totalUzs,
      'total_min': instance.totalMin,
      'total_max': instance.totalMax,
      'currency': instance.currency,
      'status': instance.status,
      'created_at': instance.createdAt.toIso8601String(),
      'has_electrical': instance.hasElectrical,
    };

_$EstimateSummaryImpl _$$EstimateSummaryImplFromJson(
  Map<String, dynamic> json,
) => _$EstimateSummaryImpl(
  id: json['id'] as String,
  roomId: json['room_id'] as String,
  totalUzs: (json['total_uzs'] as num).toInt(),
  currency: json['currency'] as String,
  status: json['status'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$$EstimateSummaryImplToJson(
  _$EstimateSummaryImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'room_id': instance.roomId,
  'total_uzs': instance.totalUzs,
  'currency': instance.currency,
  'status': instance.status,
  'created_at': instance.createdAt.toIso8601String(),
};

_$PaginatedEstimatesImpl _$$PaginatedEstimatesImplFromJson(
  Map<String, dynamic> json,
) => _$PaginatedEstimatesImpl(
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => EstimateSummary.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <EstimateSummary>[],
  total: (json['total'] as num?)?.toInt() ?? 0,
  limit: (json['limit'] as num?)?.toInt() ?? 20,
  offset: (json['offset'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$PaginatedEstimatesImplToJson(
  _$PaginatedEstimatesImpl instance,
) => <String, dynamic>{
  'items': instance.items,
  'total': instance.total,
  'limit': instance.limit,
  'offset': instance.offset,
};
