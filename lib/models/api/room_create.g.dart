// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WallElementCreateImpl _$$WallElementCreateImplFromJson(
  Map<String, dynamic> json,
) => _$WallElementCreateImpl(
  type: $enumDecode(_$WallElementTypeEnumMap, json['type']),
  width: (json['width'] as num).toDouble(),
  height: (json['height'] as num).toDouble(),
  sillHeight: (json['sill_height'] as num?)?.toDouble() ?? 0.0,
  position: (json['position'] as num?)?.toDouble() ?? 0.5,
);

Map<String, dynamic> _$$WallElementCreateImplToJson(
  _$WallElementCreateImpl instance,
) => <String, dynamic>{
  'type': _$WallElementTypeEnumMap[instance.type]!,
  'width': instance.width,
  'height': instance.height,
  'sill_height': instance.sillHeight,
  'position': instance.position,
};

const _$WallElementTypeEnumMap = {
  WallElementType.eshik: 'eshik',
  WallElementType.deraza: 'deraza',
  WallElementType.balkon: 'balkon',
};

_$WallCreateImpl _$$WallCreateImplFromJson(Map<String, dynamic> json) =>
    _$WallCreateImpl(
      id: json['id'] as String,
      length: (json['length'] as num).toDouble(),
      elements:
          (json['elements'] as List<dynamic>?)
              ?.map(
                (e) => WallElementCreate.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <WallElementCreate>[],
    );

Map<String, dynamic> _$$WallCreateImplToJson(_$WallCreateImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'length': instance.length,
      'elements': instance.elements,
    };

_$RoomGeometryCreateImpl _$$RoomGeometryCreateImplFromJson(
  Map<String, dynamic> json,
) => _$RoomGeometryCreateImpl(
  walls: (json['walls'] as List<dynamic>)
      .map((e) => WallCreate.fromJson(e as Map<String, dynamic>))
      .toList(),
  vertices: (json['vertices'] as List<dynamic>?)
      ?.map(
        (e) => (e as List<dynamic>).map((e) => (e as num).toDouble()).toList(),
      )
      .toList(),
);

Map<String, dynamic> _$$RoomGeometryCreateImplToJson(
  _$RoomGeometryCreateImpl instance,
) => <String, dynamic>{
  'walls': instance.walls,
  if (instance.vertices case final value?) 'vertices': value,
};

_$RoomCreateImpl _$$RoomCreateImplFromJson(Map<String, dynamic> json) =>
    _$RoomCreateImpl(
      name: json['name'] as String,
      ceilingH: (json['ceiling_h'] as num).toDouble(),
      geometry: RoomGeometryCreate.fromJson(
        json['geometry'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$$RoomCreateImplToJson(_$RoomCreateImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'ceiling_h': instance.ceilingH,
      'geometry': instance.geometry,
    };
