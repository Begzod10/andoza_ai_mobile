// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apartment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApartmentImpl _$$ApartmentImplFromJson(Map<String, dynamic> json) =>
    _$ApartmentImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      name: json['name'] as String,
      address: json['address'] as String?,
      developer: json['developer'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      rooms:
          (json['rooms'] as List<dynamic>?)
              ?.map((e) => RoomOut.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <RoomOut>[],
    );

Map<String, dynamic> _$$ApartmentImplToJson(_$ApartmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'name': instance.name,
      'address': instance.address,
      'developer': instance.developer,
      'created_at': instance.createdAt.toIso8601String(),
      'rooms': instance.rooms,
    };
