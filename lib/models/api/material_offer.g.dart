// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material_offer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MaterialOfferImpl _$$MaterialOfferImplFromJson(Map<String, dynamic> json) =>
    _$MaterialOfferImpl(
      id: json['id'] as String,
      materialId: json['material_id'] as String,
      storeId: json['store_id'] as String,
      storeName: json['store_name'] as String,
      storeDistrict: json['store_district'] as String?,
      storePartnerTier: json['store_partner_tier'] as String,
      priceUzs: (json['price_uzs'] as num).toInt(),
      inStock: json['in_stock'] as bool,
      deliveryDays: (json['delivery_days'] as num).toInt(),
    );

Map<String, dynamic> _$$MaterialOfferImplToJson(_$MaterialOfferImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'material_id': instance.materialId,
      'store_id': instance.storeId,
      'store_name': instance.storeName,
      'store_district': instance.storeDistrict,
      'store_partner_tier': instance.storePartnerTier,
      'price_uzs': instance.priceUzs,
      'in_stock': instance.inStock,
      'delivery_days': instance.deliveryDays,
    };
