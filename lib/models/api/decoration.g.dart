// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'decoration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WallsDecorationImpl _$$WallsDecorationImplFromJson(
  Map<String, dynamic> json,
) => _$WallsDecorationImpl(
  materialId: json['material_id'] as String?,
  finish: json['finish'] as String? ?? 'paint',
  color: json['color'] as String?,
);

Map<String, dynamic> _$$WallsDecorationImplToJson(
  _$WallsDecorationImpl instance,
) => <String, dynamic>{
  'material_id': instance.materialId,
  'finish': instance.finish,
  'color': instance.color,
};

_$FloorDecorationImpl _$$FloorDecorationImplFromJson(
  Map<String, dynamic> json,
) => _$FloorDecorationImpl(materialId: json['material_id'] as String?);

Map<String, dynamic> _$$FloorDecorationImplToJson(
  _$FloorDecorationImpl instance,
) => <String, dynamic>{'material_id': instance.materialId};

_$CeilingDecorationImpl _$$CeilingDecorationImplFromJson(
  Map<String, dynamic> json,
) => _$CeilingDecorationImpl(materialId: json['material_id'] as String?);

Map<String, dynamic> _$$CeilingDecorationImplToJson(
  _$CeilingDecorationImpl instance,
) => <String, dynamic>{'material_id': instance.materialId};

_$DecorationFurnitureImpl _$$DecorationFurnitureImplFromJson(
  Map<String, dynamic> json,
) => _$DecorationFurnitureImpl(
  furnitureId: json['furniture_id'] as String,
  x: (json['x'] as num).toDouble(),
  y: (json['y'] as num).toDouble(),
  rotation: (json['rotation'] as num?)?.toDouble() ?? 0.0,
);

Map<String, dynamic> _$$DecorationFurnitureImplToJson(
  _$DecorationFurnitureImpl instance,
) => <String, dynamic>{
  'furniture_id': instance.furnitureId,
  'x': instance.x,
  'y': instance.y,
  'rotation': instance.rotation,
};

_$DecorationImpl _$$DecorationImplFromJson(Map<String, dynamic> json) =>
    _$DecorationImpl(
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
              ?.map(
                (e) => DecorationFurniture.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <DecorationFurniture>[],
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$DecorationImplToJson(_$DecorationImpl instance) =>
    <String, dynamic>{
      'room_id': instance.roomId,
      'walls': instance.walls,
      'floor': instance.floor,
      'ceiling': instance.ceiling,
      'furniture': instance.furniture,
      'updated_at': instance.updatedAt.toIso8601String(),
    };
