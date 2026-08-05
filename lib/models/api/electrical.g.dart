// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'electrical.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ElectricalDeviceOutImpl _$$ElectricalDeviceOutImplFromJson(
  Map<String, dynamic> json,
) => _$ElectricalDeviceOutImpl(
  id: json['id'] as String,
  roomId: json['room_id'] as String,
  type: $enumDecode(_$ElectricalDeviceTypeEnumMap, json['type']),
  variant: json['variant'] as String?,
  wallIndex: (json['wall_index'] as num).toInt(),
  x: (json['x'] as num).toDouble(),
  y: (json['y'] as num).toDouble(),
  count: (json['count'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$$ElectricalDeviceOutImplToJson(
  _$ElectricalDeviceOutImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'room_id': instance.roomId,
  'type': _$ElectricalDeviceTypeEnumMap[instance.type]!,
  'variant': instance.variant,
  'wall_index': instance.wallIndex,
  'x': instance.x,
  'y': instance.y,
  'count': instance.count,
};

const _$ElectricalDeviceTypeEnumMap = {
  ElectricalDeviceType.socket: 'socket',
  ElectricalDeviceType.switch_: 'switch',
  ElectricalDeviceType.light: 'light',
  ElectricalDeviceType.panel: 'panel',
  ElectricalDeviceType.box: 'box',
};

_$ElectricalDeviceCreateImpl _$$ElectricalDeviceCreateImplFromJson(
  Map<String, dynamic> json,
) => _$ElectricalDeviceCreateImpl(
  type: $enumDecode(_$ElectricalDeviceTypeEnumMap, json['type']),
  variant: json['variant'] as String?,
  wallIndex: (json['wall_index'] as num).toInt(),
  x: (json['x'] as num).toDouble(),
  y: (json['y'] as num).toDouble(),
  count: (json['count'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$$ElectricalDeviceCreateImplToJson(
  _$ElectricalDeviceCreateImpl instance,
) => <String, dynamic>{
  'type': _$ElectricalDeviceTypeEnumMap[instance.type]!,
  'variant': instance.variant,
  'wall_index': instance.wallIndex,
  'x': instance.x,
  'y': instance.y,
  'count': instance.count,
};

_$ElectricalPlanImpl _$$ElectricalPlanImplFromJson(Map<String, dynamic> json) =>
    _$ElectricalPlanImpl(
      roomId: json['room_id'] as String,
      devices:
          (json['devices'] as List<dynamic>?)
              ?.map(
                (e) => ElectricalDeviceOut.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <ElectricalDeviceOut>[],
      wiringMeters: (json['wiring_meters'] as num?)?.toDouble(),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$ElectricalPlanImplToJson(
  _$ElectricalPlanImpl instance,
) => <String, dynamic>{
  'room_id': instance.roomId,
  'devices': instance.devices,
  'wiring_meters': instance.wiringMeters,
  'updated_at': instance.updatedAt.toIso8601String(),
};
