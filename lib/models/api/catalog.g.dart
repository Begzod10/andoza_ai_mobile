// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MaterialImpl _$$MaterialImplFromJson(Map<String, dynamic> json) =>
    _$MaterialImpl(
      id: json['id'] as String,
      storeId: json['store_id'] as String,
      category: json['category'] as String,
      nameUz: json['name_uz'] as String,
      unit: json['unit'] as String,
      priceUzs: (json['price_uzs'] as num).toInt(),
      colorHex: json['color_hex'] as String?,
      textureKey: json['texture_key'] as String?,
      pbrRoughness: (json['pbr_roughness'] as num?)?.toDouble() ?? 1.0,
    );

Map<String, dynamic> _$$MaterialImplToJson(_$MaterialImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'store_id': instance.storeId,
      'category': instance.category,
      'name_uz': instance.nameUz,
      'unit': instance.unit,
      'price_uzs': instance.priceUzs,
      'color_hex': instance.colorHex,
      'texture_key': instance.textureKey,
      'pbr_roughness': instance.pbrRoughness,
    };

_$PaginatedMaterialsImpl _$$PaginatedMaterialsImplFromJson(
  Map<String, dynamic> json,
) => _$PaginatedMaterialsImpl(
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => Material.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <Material>[],
  total: (json['total'] as num?)?.toInt() ?? 0,
  page: (json['page'] as num?)?.toInt() ?? 1,
  perPage: (json['per_page'] as num?)?.toInt() ?? 20,
);

Map<String, dynamic> _$$PaginatedMaterialsImplToJson(
  _$PaginatedMaterialsImpl instance,
) => <String, dynamic>{
  'items': instance.items,
  'total': instance.total,
  'page': instance.page,
  'per_page': instance.perPage,
};

_$FurnitureImpl _$$FurnitureImplFromJson(Map<String, dynamic> json) =>
    _$FurnitureImpl(
      id: json['id'] as String,
      storeId: json['store_id'] as String?,
      category: json['category'] as String,
      nameUz: json['name_uz'] as String,
      priceUzs: (json['price_uzs'] as num?)?.toInt(),
      glbKey: json['glb_key'] as String?,
      footprintW: (json['footprint_w'] as num?)?.toDouble(),
      footprintD: (json['footprint_d'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$FurnitureImplToJson(_$FurnitureImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'store_id': instance.storeId,
      'category': instance.category,
      'name_uz': instance.nameUz,
      'price_uzs': instance.priceUzs,
      'glb_key': instance.glbKey,
      'footprint_w': instance.footprintW,
      'footprint_d': instance.footprintD,
    };

_$PaginatedFurnitureImpl _$$PaginatedFurnitureImplFromJson(
  Map<String, dynamic> json,
) => _$PaginatedFurnitureImpl(
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => Furniture.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <Furniture>[],
  total: (json['total'] as num?)?.toInt() ?? 0,
  page: (json['page'] as num?)?.toInt() ?? 1,
  perPage: (json['per_page'] as num?)?.toInt() ?? 20,
);

Map<String, dynamic> _$$PaginatedFurnitureImplToJson(
  _$PaginatedFurnitureImpl instance,
) => <String, dynamic>{
  'items': instance.items,
  'total': instance.total,
  'page': instance.page,
  'per_page': instance.perPage,
};

_$StoreImpl _$$StoreImplFromJson(Map<String, dynamic> json) => _$StoreImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  district: json['district'] as String?,
  phone: json['phone'] as String?,
  telegram: json['telegram'] as String?,
  logoColor: json['logo_color'] as String?,
  partnerTier: json['partner_tier'] as String,
);

Map<String, dynamic> _$$StoreImplToJson(_$StoreImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'district': instance.district,
      'phone': instance.phone,
      'telegram': instance.telegram,
      'logo_color': instance.logoColor,
      'partner_tier': instance.partnerTier,
    };
