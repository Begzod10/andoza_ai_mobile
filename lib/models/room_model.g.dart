// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RoomDimensions _$RoomDimensionsFromJson(Map<String, dynamic> json) =>
    _RoomDimensions(
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      length: (json['length'] as num).toDouble(),
    );

Map<String, dynamic> _$RoomDimensionsToJson(_RoomDimensions instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
      'length': instance.length,
    };

_WallMeasurements _$WallMeasurementsFromJson(Map<String, dynamic> json) =>
    _WallMeasurements(
      height: (json['height'] as num).toDouble(),
      length: (json['length'] as num).toDouble(),
    );

Map<String, dynamic> _$WallMeasurementsToJson(_WallMeasurements instance) =>
    <String, dynamic>{'height': instance.height, 'length': instance.length};

_Wall _$WallFromJson(Map<String, dynamic> json) => _Wall(
  id: json['id'] as String,
  type: $enumDecode(
    _$WallTypeEnumMap,
    json['type'],
    unknownValue: WallType.unknown,
  ),
  measurements: WallMeasurements.fromJson(
    json['measurements'] as Map<String, dynamic>,
  ),
  texture: json['texture'] as String?,
);

Map<String, dynamic> _$WallToJson(_Wall instance) => <String, dynamic>{
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
  WallType.unknown: 'unknown',
};

_Door _$DoorFromJson(Map<String, dynamic> json) => _Door(
  id: json['id'] as String,
  wallId: json['wallId'] as String,
  position: (json['position'] as num).toDouble(),
  width: (json['width'] as num).toDouble(),
  height: (json['height'] as num).toDouble(),
  type: $enumDecode(
    _$OpeningTypeEnumMap,
    json['type'],
    unknownValue: OpeningType.unknown,
  ),
);

Map<String, dynamic> _$DoorToJson(_Door instance) => <String, dynamic>{
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
  OpeningType.unknown: 'unknown',
};

_Window _$WindowFromJson(Map<String, dynamic> json) => _Window(
  id: json['id'] as String,
  wallId: json['wallId'] as String,
  position: (json['position'] as num).toDouble(),
  width: (json['width'] as num).toDouble(),
  height: (json['height'] as num).toDouble(),
  type: $enumDecode(
    _$OpeningTypeEnumMap,
    json['type'],
    unknownValue: OpeningType.unknown,
  ),
);

Map<String, dynamic> _$WindowToJson(_Window instance) => <String, dynamic>{
  'id': instance.id,
  'wallId': instance.wallId,
  'position': instance.position,
  'width': instance.width,
  'height': instance.height,
  'type': _$OpeningTypeEnumMap[instance.type]!,
};

_Room _$RoomFromJson(Map<String, dynamic> json) => _Room(
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

Map<String, dynamic> _$RoomToJson(_Room instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'dimensions': instance.dimensions,
  'walls': instance.walls,
  'doors': instance.doors,
  'windows': instance.windows,
  'createdAt': instance.createdAt.toIso8601String(),
};
