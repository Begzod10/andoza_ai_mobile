// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_out.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoomOutImpl _$$RoomOutImplFromJson(Map<String, dynamic> json) =>
    _$RoomOutImpl(
      id: json['id'] as String,
      apartmentId: json['apartment_id'] as String,
      name: json['name'] as String,
      ceilingH: (json['ceiling_h'] as num?)?.toDouble(),
      geometry: json['geometry'] as Map<String, dynamic>?,
      surfaces: json['surfaces'] as Map<String, dynamic>?,
      furnitureLayout: json['furniture_layout'] as List<dynamic>?,
      state: json['state'] as Map<String, dynamic>?,
      floorArea: (json['floor_area'] as num?)?.toDouble(),
      netWallArea: (json['net_wall_area'] as num?)?.toDouble(),
      perimeter: (json['perimeter'] as num?)?.toDouble(),
      openingsCount: (json['openings_count'] as num?)?.toInt() ?? 0,
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$RoomOutImplToJson(_$RoomOutImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'apartment_id': instance.apartmentId,
      'name': instance.name,
      'ceiling_h': instance.ceilingH,
      'geometry': instance.geometry,
      'surfaces': instance.surfaces,
      'furniture_layout': instance.furnitureLayout,
      'state': instance.state,
      'floor_area': instance.floorArea,
      'net_wall_area': instance.netWallArea,
      'perimeter': instance.perimeter,
      'openings_count': instance.openingsCount,
      'updated_at': instance.updatedAt.toIso8601String(),
    };
