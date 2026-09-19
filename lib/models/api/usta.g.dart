// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Usta _$UstaFromJson(Map<String, dynamic> json) => _Usta(
  id: json['id'] as String,
  name: json['name'] as String,
  category: json['category'] as String,
  district: json['district'] as String?,
  phone: json['phone'] as String,
  telegram: json['telegram'] as String?,
  rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
  jobsCount: (json['jobs_count'] as num?)?.toInt() ?? 0,
  priceMin: (json['price_min'] as num?)?.toInt(),
  priceMax: (json['price_max'] as num?)?.toInt(),
  verified: json['verified'] as bool? ?? false,
  lat: (json['lat'] as num?)?.toDouble(),
  lng: (json['lng'] as num?)?.toDouble(),
  avatarUrl: json['avatar_url'] as String?,
);

Map<String, dynamic> _$UstaToJson(_Usta instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'category': instance.category,
  'district': instance.district,
  'phone': instance.phone,
  'telegram': instance.telegram,
  'rating': instance.rating,
  'jobs_count': instance.jobsCount,
  'price_min': instance.priceMin,
  'price_max': instance.priceMax,
  'verified': instance.verified,
  'lat': instance.lat,
  'lng': instance.lng,
  'avatar_url': instance.avatarUrl,
};
