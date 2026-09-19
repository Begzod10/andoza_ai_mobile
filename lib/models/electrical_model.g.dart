// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'electrical_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ElectricalDevice _$ElectricalDeviceFromJson(Map<String, dynamic> json) =>
    _ElectricalDevice(
      id: json['id'] as String,
      type: $enumDecode(
        _$DeviceTypeEnumMap,
        json['type'],
        unknownValue: DeviceType.unknown,
      ),
      position: const OffsetConverter().fromJson(
        json['position'] as Map<String, dynamic>,
      ),
      wallId: json['wallId'] as String,
      amps: (json['amps'] as num?)?.toDouble(),
      heightCm: (json['heightCm'] as num?)?.toDouble() ?? 100,
      gangCount: (json['gangCount'] as num?)?.toInt() ?? 1,
      colorOption: json['colorOption'] as String?,
      colorTemp: $enumDecodeNullable(
        _$ColorTempEnumMap,
        json['colorTemp'],
        unknownValue: ColorTemp.unknown,
      ),
    );

Map<String, dynamic> _$ElectricalDeviceToJson(_ElectricalDevice instance) =>
    <String, dynamic>{
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
  DeviceType.unknown: 'unknown',
};

const _$ColorTempEnumMap = {
  ColorTemp.warm: 'WARM',
  ColorTemp.neutral: 'NEUTRAL',
  ColorTemp.cold: 'COLD',
  ColorTemp.rgb: 'RGB',
  ColorTemp.unknown: 'unknown',
};

_WireSegment _$WireSegmentFromJson(Map<String, dynamic> json) => _WireSegment(
  id: json['id'] as String,
  from: const OffsetConverter().fromJson(json['from'] as Map<String, dynamic>),
  to: const OffsetConverter().fromJson(json['to'] as Map<String, dynamic>),
  gauge: (json['gauge'] as num).toInt(),
);

Map<String, dynamic> _$WireSegmentToJson(_WireSegment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'from': const OffsetConverter().toJson(instance.from),
      'to': const OffsetConverter().toJson(instance.to),
      'gauge': instance.gauge,
    };

_PipeSegment _$PipeSegmentFromJson(Map<String, dynamic> json) => _PipeSegment(
  id: json['id'] as String,
  from: const OffsetConverter().fromJson(json['from'] as Map<String, dynamic>),
  to: const OffsetConverter().fromJson(json['to'] as Map<String, dynamic>),
  type: $enumDecode(
    _$PipeTypeEnumMap,
    json['type'],
    unknownValue: PipeType.unknown,
  ),
);

Map<String, dynamic> _$PipeSegmentToJson(_PipeSegment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'from': const OffsetConverter().toJson(instance.from),
      'to': const OffsetConverter().toJson(instance.to),
      'type': _$PipeTypeEnumMap[instance.type]!,
    };

const _$PipeTypeEnumMap = {
  PipeType.hot: 'HOT',
  PipeType.cold: 'COLD',
  PipeType.unknown: 'unknown',
};

_JunctionBox _$JunctionBoxFromJson(Map<String, dynamic> json) => _JunctionBox(
  id: json['id'] as String,
  position: const OffsetConverter().fromJson(
    json['position'] as Map<String, dynamic>,
  ),
  capacity: (json['capacity'] as num).toInt(),
  connections: (json['connections'] as num).toInt(),
);

Map<String, dynamic> _$JunctionBoxToJson(_JunctionBox instance) =>
    <String, dynamic>{
      'id': instance.id,
      'position': const OffsetConverter().toJson(instance.position),
      'capacity': instance.capacity,
      'connections': instance.connections,
    };

_ElectricalLayout _$ElectricalLayoutFromJson(Map<String, dynamic> json) =>
    _ElectricalLayout(
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

Map<String, dynamic> _$ElectricalLayoutToJson(_ElectricalLayout instance) =>
    <String, dynamic>{
      'id': instance.id,
      'roomId': instance.roomId,
      'devices': instance.devices,
      'wires': instance.wires,
      'junctionBoxes': instance.junctionBoxes,
      'pipes': instance.pipes,
    };
