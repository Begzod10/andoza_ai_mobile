// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderLineCreateImpl _$$OrderLineCreateImplFromJson(
  Map<String, dynamic> json,
) => _$OrderLineCreateImpl(
  materialId: json['material_id'] as String?,
  productName: json['product_name'] as String,
  unit: json['unit'] as String,
  unitPriceUzs: (json['unit_price_uzs'] as num).toInt(),
  quantity: json['quantity'] as num,
);

Map<String, dynamic> _$$OrderLineCreateImplToJson(
  _$OrderLineCreateImpl instance,
) => <String, dynamic>{
  'material_id': instance.materialId,
  'product_name': instance.productName,
  'unit': instance.unit,
  'unit_price_uzs': instance.unitPriceUzs,
  'quantity': instance.quantity,
};

_$ServerOrderLineImpl _$$ServerOrderLineImplFromJson(
  Map<String, dynamic> json,
) => _$ServerOrderLineImpl(
  id: json['id'] as String,
  materialId: json['material_id'] as String?,
  productName: json['product_name'] as String,
  unit: json['unit'] as String,
  unitPriceUzs: (json['unit_price_uzs'] as num).toInt(),
  quantity: json['quantity'] as num,
);

Map<String, dynamic> _$$ServerOrderLineImplToJson(
  _$ServerOrderLineImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'material_id': instance.materialId,
  'product_name': instance.productName,
  'unit': instance.unit,
  'unit_price_uzs': instance.unitPriceUzs,
  'quantity': instance.quantity,
};

_$ServerOrderImpl _$$ServerOrderImplFromJson(Map<String, dynamic> json) =>
    _$ServerOrderImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      dealerName: json['dealer_name'] as String,
      totalUzs: (json['total_uzs'] as num).toInt(),
      status: $enumDecode(_$OrderStatusEnumMap, json['status']),
      createdAt: DateTime.parse(json['created_at'] as String),
      lines:
          (json['lines'] as List<dynamic>?)
              ?.map((e) => ServerOrderLine.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ServerOrderLine>[],
    );

Map<String, dynamic> _$$ServerOrderImplToJson(_$ServerOrderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'dealer_name': instance.dealerName,
      'total_uzs': instance.totalUzs,
      'status': _$OrderStatusEnumMap[instance.status]!,
      'created_at': instance.createdAt.toIso8601String(),
      'lines': instance.lines,
    };

const _$OrderStatusEnumMap = {
  OrderStatus.accepted: 'accepted',
  OrderStatus.gathering: 'gathering',
  OrderStatus.onTheWay: 'on_the_way',
  OrderStatus.delivered: 'delivered',
};
