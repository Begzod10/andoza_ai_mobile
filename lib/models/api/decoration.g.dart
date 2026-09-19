// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'decoration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WallsDecoration _$WallsDecorationFromJson(Map<String, dynamic> json) =>
    _WallsDecoration(
      materialId: json['material_id'] as String?,
      finish: json['finish'] as String? ?? 'paint',
      color: json['color'] as String?,
    );

Map<String, dynamic> _$WallsDecorationToJson(_WallsDecoration instance) =>
    <String, dynamic>{
      'material_id': instance.materialId,
      'finish': instance.finish,
      'color': instance.color,
    };

_FloorDecoration _$FloorDecorationFromJson(Map<String, dynamic> json) =>
    _FloorDecoration(materialId: json['material_id'] as String?);

Map<String, dynamic> _$FloorDecorationToJson(_FloorDecoration instance) =>
    <String, dynamic>{'material_id': instance.materialId};

_CeilingDecoration _$CeilingDecorationFromJson(Map<String, dynamic> json) =>
    _CeilingDecoration(materialId: json['material_id'] as String?);

Map<String, dynamic> _$CeilingDecorationToJson(_CeilingDecoration instance) =>
    <String, dynamic>{'material_id': instance.materialId};

_DecorationFurniture _$DecorationFurnitureFromJson(Map<String, dynamic> json) =>
    _DecorationFurniture(
      furnitureId: json['furniture_id'] as String,
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      rotation: (json['rotation'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$DecorationFurnitureToJson(
  _DecorationFurniture instance,
) => <String, dynamic>{
  'furniture_id': instance.furnitureId,
  'x': instance.x,
  'y': instance.y,
  'rotation': instance.rotation,
};

_Decoration _$DecorationFromJson(Map<String, dynamic> json) => _Decoration(
  roomId: json['room_id'] as String,
  walls: json['walls'] == null
      ? const WallsDecoration()
      : WallsDecoration.fromJson(json['walls'] as Map<String, dynamic>),
  floor: json['floor'] == null
      ? const FloorDecoration()
      : FloorDecoration.fromJson(json['floor'] as Map<String, dynamic>),
  ceiling: json['ceiling'] == null
      ? const CeilingDecoration()
      : CeilingDecoration.fromJson(json['ceiling'] as Map<String, dynamic>),
  furniture:
      (json['furniture'] as List<dynamic>?)
          ?.map((e) => DecorationFurniture.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <DecorationFurniture>[],
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$DecorationToJson(_Decoration instance) =>
    <String, dynamic>{
      'room_id': instance.roomId,
      'walls': instance.walls,
      'floor': instance.floor,
      'ceiling': instance.ceiling,
      'furniture': instance.furniture,
      'updated_at': instance.updatedAt.toIso8601String(),
    };
