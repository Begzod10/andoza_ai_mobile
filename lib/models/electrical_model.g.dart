// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'electrical_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ElectricalDeviceImpl _$$ElectricalDeviceImplFromJson(
  Map<String, dynamic> json,
) => _$ElectricalDeviceImpl(
  id: json['id'] as String,
  type: $enumDecode(_$DeviceTypeEnumMap, json['type']),
  position: const OffsetConverter().fromJson(
    json['position'] as Map<String, dynamic>,
  ),
  wallId: json['wallId'] as String,
  amps: (json['amps'] as num?)?.toDouble(),
  heightCm: (json['heightCm'] as num?)?.toDouble() ?? 100,
  gangCount: (json['gangCount'] as num?)?.toInt() ?? 1,
  colorOption: json['colorOption'] as String?,
  colorTemp: $enumDecodeNullable(_$ColorTempEnumMap, json['colorTemp']),
);

Map<String, dynamic> _$$ElectricalDeviceImplToJson(
  _$ElectricalDeviceImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': _$DeviceTypeEnumMap[instance.type]!,
  'position': const OffsetConverter().toJson(instance.position),
  'wallId': instance.wallId,
  'amps': instance.amps,
  'heightCm': instance.heightCm,
  'gangCount': instance.gangCount,
  'colorOption': instance.colorOption,
  'colorTemp': _$ColorTempEnumMap[instance.colorTemp],
};

const _$DeviceTypeEnumMap = {
  DeviceType.outlet: 'OUTLET',
  DeviceType.lightSwitch: 'SWITCH',
  DeviceType.light: 'LIGHT',
  DeviceType.breaker: 'BREAKER',
};

const _$ColorTempEnumMap = {
  ColorTemp.warm: 'WARM',
  ColorTemp.neutral: 'NEUTRAL',
  ColorTemp.cold: 'COLD',
  ColorTemp.rgb: 'RGB',
};

_$WireSegmentImpl _$$WireSegmentImplFromJson(Map<String, dynamic> json) =>
    _$WireSegmentImpl(
      id: json['id'] as String,
      from: const OffsetConverter().fromJson(
        json['from'] as Map<String, dynamic>,
      ),
      to: const OffsetConverter().fromJson(json['to'] as Map<String, dynamic>),
      gauge: (json['gauge'] as num).toInt(),
    );

Map<String, dynamic> _$$WireSegmentImplToJson(_$WireSegmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'from': const OffsetConverter().toJson(instance.from),
      'to': const OffsetConverter().toJson(instance.to),
      'gauge': instance.gauge,
    };

_$PipeSegmentImpl _$$PipeSegmentImplFromJson(Map<String, dynamic> json) =>
    _$PipeSegmentImpl(
      id: json['id'] as String,
      from: const OffsetConverter().fromJson(
        json['from'] as Map<String, dynamic>,
      ),
      to: const OffsetConverter().fromJson(json['to'] as Map<String, dynamic>),
      type: $enumDecode(_$PipeTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$$PipeSegmentImplToJson(_$PipeSegmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'from': const OffsetConverter().toJson(instance.from),
      'to': const OffsetConverter().toJson(instance.to),
      'type': _$PipeTypeEnumMap[instance.type]!,
    };

const _$PipeTypeEnumMap = {PipeType.hot: 'HOT', PipeType.cold: 'COLD'};

_$JunctionBoxImpl _$$JunctionBoxImplFromJson(Map<String, dynamic> json) =>
    _$JunctionBoxImpl(
      id: json['id'] as String,
      position: const OffsetConverter().fromJson(
        json['position'] as Map<String, dynamic>,
      ),
      capacity: (json['capacity'] as num).toInt(),
      connections: (json['connections'] as num).toInt(),
    );

Map<String, dynamic> _$$JunctionBoxImplToJson(_$JunctionBoxImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'position': const OffsetConverter().toJson(instance.position),
      'capacity': instance.capacity,
      'connections': instance.connections,
    };

_$ElectricalLayoutImpl _$$ElectricalLayoutImplFromJson(
  Map<String, dynamic> json,
) => _$ElectricalLayoutImpl(
  id: json['id'] as String,
  roomId: json['roomId'] as String,
  devices:
      (json['devices'] as List<dynamic>?)
          ?.map((e) => ElectricalDevice.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ElectricalDevice>[],
  wires:
      (json['wires'] as List<dynamic>?)
          ?.map((e) => WireSegment.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <WireSegment>[],
  junctionBoxes:
      (json['junctionBoxes'] as List<dynamic>?)
          ?.map((e) => JunctionBox.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <JunctionBox>[],
  pipes:
      (json['pipes'] as List<dynamic>?)
          ?.map((e) => PipeSegment.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <PipeSegment>[],
);

Map<String, dynamic> _$$ElectricalLayoutImplToJson(
  _$ElectricalLayoutImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'roomId': instance.roomId,
  'devices': instance.devices,
  'wires': instance.wires,
  'junctionBoxes': instance.junctionBoxes,
  'pipes': instance.pipes,
};
