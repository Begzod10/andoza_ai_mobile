// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OrderLineCreate _$OrderLineCreateFromJson(Map<String, dynamic> json) =>
    _OrderLineCreate(
      materialId: json['material_id'] as String?,
      productName: json['product_name'] as String,
      unit: json['unit'] as String,
      unitPriceUzs: (json['unit_price_uzs'] as num).toInt(),
      quantity: json['quantity'] as num,
    );

Map<String, dynamic> _$OrderLineCreateToJson(_OrderLineCreate instance) =>
    <String, dynamic>{
      'material_id': instance.materialId,
      'product_name': instance.productName,
      'unit': instance.unit,
      'unit_price_uzs': instance.unitPriceUzs,
      'quantity': instance.quantity,
    };

_ServerOrderLine _$ServerOrderLineFromJson(Map<String, dynamic> json) =>
    _ServerOrderLine(
      id: json['id'] as String,
      materialId: json['material_id'] as String?,
      productName: json['product_name'] as String,
      unit: json['unit'] as String,
      unitPriceUzs: (json['unit_price_uzs'] as num).toInt(),
      quantity: json['quantity'] as num,
    );

Map<String, dynamic> _$ServerOrderLineToJson(_ServerOrderLine instance) =>
    <String, dynamic>{
      'id': instance.id,
      'material_id': instance.materialId,
      'product_name': instance.productName,
      'unit': instance.unit,
      'unit_price_uzs': instance.unitPriceUzs,
      'quantity': instance.quantity,
    };

_ServerOrder _$ServerOrderFromJson(Map<String, dynamic> json) => _ServerOrder(
  id: json['id'] as String,
  userId: json['user_id'] as String,
  dealerName: json['dealer_name'] as String,
  totalUzs: (json['total_uzs'] as num).toInt(),
  status: $enumDecode(
    _$OrderStatusEnumMap,
    json['status'],
    unknownValue: OrderStatus.unknown,
  ),
  createdAt: DateTime.parse(json['created_at'] as String),
  lines:
      (json['lines'] as List<dynamic>?)
          ?.map((e) => ServerOrderLine.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ServerOrderLine>[],
);

Map<String, dynamic> _$ServerOrderToJson(_ServerOrder instance) =>
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
  OrderStatus.unknown: 'unknown',
};
