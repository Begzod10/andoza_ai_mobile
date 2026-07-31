// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoomDimensionsImpl _$$RoomDimensionsImplFromJson(Map<String, dynamic> json) =>
    _$RoomDimensionsImpl(
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      length: (json['length'] as num).toDouble(),
    );

Map<String, dynamic> _$$RoomDimensionsImplToJson(
  _$RoomDimensionsImpl instance,
) => <String, dynamic>{
  'width': instance.width,
  'height': instance.height,
  'length': instance.length,
};

_$WallMeasurementsImpl _$$WallMeasurementsImplFromJson(
  Map<String, dynamic> json,
) => _$WallMeasurementsImpl(
  height: (json['height'] as num).toDouble(),
  length: (json['length'] as num).toDouble(),
);

Map<String, dynamic> _$$WallMeasurementsImplToJson(
  _$WallMeasurementsImpl instance,
) => <String, dynamic>{'height': instance.height, 'length': instance.length};

_$WallImpl _$$WallImplFromJson(Map<String, dynamic> json) => _$WallImpl(
  id: json['id'] as String,
  type: $enumDecode(_$WallTypeEnumMap, json['type']),
  measurements: WallMeasurements.fromJson(
    json['measurements'] as Map<String, dynamic>,
  ),
  texture: json['texture'] as String?,
);

Map<String, dynamic> _$$WallImplToJson(_$WallImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$WallTypeEnumMap[instance.type]!,
      'measurements': instance.measurements,
      'texture': instance.texture,
    };

const _$WallTypeEnumMap = {
  WallType.wallA: 'WALL_A',
  WallType.wallB: 'WALL_B',
  WallType.wallC: 'WALL_C',
  WallType.wallD: 'WALL_D',
};

_$DoorImpl _$$DoorImplFromJson(Map<String, dynamic> json) => _$DoorImpl(
  id: json['id'] as String,
  wallId: json['wallId'] as String,
  position: (json['position'] as num).toDouble(),
  width: (json['width'] as num).toDouble(),
  height: (json['height'] as num).toDouble(),
  type: $enumDecode(_$OpeningTypeEnumMap, json['type']),
);

Map<String, dynamic> _$$DoorImplToJson(_$DoorImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'wallId': instance.wallId,
      'position': instance.position,
      'width': instance.width,
      'height': instance.height,
      'type': _$OpeningTypeEnumMap[instance.type]!,
    };

const _$OpeningTypeEnumMap = {
  OpeningType.single: 'SINGLE',
  OpeningType.dual: 'DOUBLE',
  OpeningType.sliding: 'SLIDING',
};

_$WindowImpl _$$WindowImplFromJson(Map<String, dynamic> json) => _$WindowImpl(
  id: json['id'] as String,
  wallId: json['wallId'] as String,
  position: (json['position'] as num).toDouble(),
  width: (json['width'] as num).toDouble(),
  height: (json['height'] as num).toDouble(),
  type: $enumDecode(_$OpeningTypeEnumMap, json['type']),
);

Map<String, dynamic> _$$WindowImplToJson(_$WindowImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'wallId': instance.wallId,
      'position': instance.position,
      'width': instance.width,
      'height': instance.height,
      'type': _$OpeningTypeEnumMap[instance.type]!,
    };

_$RoomImpl _$$RoomImplFromJson(Map<String, dynamic> json) => _$RoomImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  dimensions: RoomDimensions.fromJson(
    json['dimensions'] as Map<String, dynamic>,
  ),
  walls:
      (json['walls'] as List<dynamic>?)
          ?.map((e) => Wall.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <Wall>[],
  doors:
      (json['doors'] as List<dynamic>?)
          ?.map((e) => Door.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <Door>[],
  windows:
      (json['windows'] as List<dynamic>?)
          ?.map((e) => Window.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <Window>[],
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$RoomImplToJson(_$RoomImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'dimensions': instance.dimensions,
      'walls': instance.walls,
      'doors': instance.doors,
      'windows': instance.windows,
      'createdAt': instance.createdAt.toIso8601String(),
    };
