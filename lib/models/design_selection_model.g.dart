// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'design_selection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoomConditionImpl _$$RoomConditionImplFromJson(Map<String, dynamic> json) =>
    _$RoomConditionImpl(
      wall: $enumDecode(_$SurfaceConditionEnumMap, json['wall']),
      floor: $enumDecodeNullable(_$SurfaceConditionEnumMap, json['floor']),
      ceiling: $enumDecodeNullable(_$SurfaceConditionEnumMap, json['ceiling']),
    );

Map<String, dynamic> _$$RoomConditionImplToJson(_$RoomConditionImpl instance) =>
    <String, dynamic>{
      'wall': _$SurfaceConditionEnumMap[instance.wall]!,
      'floor': _$SurfaceConditionEnumMap[instance.floor],
      'ceiling': _$SurfaceConditionEnumMap[instance.ceiling],
    };

const _$SurfaceConditionEnumMap = {
  SurfaceCondition.raw: 'KOROBKA',
  SurfaceCondition.plastered: 'SUVOQ',
  SurfaceCondition.puttied: 'SHPAKLOVKA',
};

_$FurniturePlacementImpl _$$FurniturePlacementImplFromJson(
  Map<String, dynamic> json,
) => _$FurniturePlacementImpl(
  id: json['id'] as String,
  itemId: json['itemId'] as String,
  name: json['name'] as String,
  position: const OffsetConverter().fromJson(
    json['position'] as Map<String, dynamic>,
  ),
  rotationDegrees: (json['rotationDegrees'] as num?)?.toDouble() ?? 0,
  selectedColor: json['selectedColor'] as String,
);

Map<String, dynamic> _$$FurniturePlacementImplToJson(
  _$FurniturePlacementImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'itemId': instance.itemId,
  'name': instance.name,
  'position': const OffsetConverter().toJson(instance.position),
  'rotationDegrees': instance.rotationDegrees,
  'selectedColor': instance.selectedColor,
};

_$MaterialSelectionImpl _$$MaterialSelectionImplFromJson(
  Map<String, dynamic> json,
) => _$MaterialSelectionImpl(
  materialId: json['materialId'] as String,
  material: $enumDecode(_$MaterialTypeEnumMap, json['material']),
  color: json['color'] as String,
  price: (json['price'] as num).toDouble(),
  area: (json['area'] as num).toDouble(),
);

Map<String, dynamic> _$$MaterialSelectionImplToJson(
  _$MaterialSelectionImpl instance,
) => <String, dynamic>{
  'materialId': instance.materialId,
  'material': _$MaterialTypeEnumMap[instance.material]!,
  'color': instance.color,
  'price': instance.price,
  'area': instance.area,
};

const _$MaterialTypeEnumMap = {
  MaterialType.paint: 'PAINT',
  MaterialType.wallpaper: 'WALLPAPER',
  MaterialType.floorTile: 'FLOOR_TILE',
  MaterialType.wood: 'WOOD',
  MaterialType.carpet: 'CARPET',
};

_$DesignSelectionImpl _$$DesignSelectionImplFromJson(
  Map<String, dynamic> json,
) => _$DesignSelectionImpl(
  id: json['id'] as String,
  roomId: json['roomId'] as String,
  stage: $enumDecode(_$DesignStageEnumMap, json['stage']),
  selections:
      (json['selections'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, MaterialSelection.fromJson(e as Map<String, dynamic>)),
      ) ??
      const <String, MaterialSelection>{},
  roomCondition: json['roomCondition'] == null
      ? null
      : RoomCondition.fromJson(json['roomCondition'] as Map<String, dynamic>),
  furniture:
      (json['furniture'] as List<dynamic>?)
          ?.map((e) => FurniturePlacement.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <FurniturePlacement>[],
);

Map<String, dynamic> _$$DesignSelectionImplToJson(
  _$DesignSelectionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'roomId': instance.roomId,
  'stage': _$DesignStageEnumMap[instance.stage]!,
  'selections': instance.selections,
  'roomCondition': instance.roomCondition,
  'furniture': instance.furniture,
};

const _$DesignStageEnumMap = {
  DesignStage.floor: 'FLOOR',
  DesignStage.paint: 'PAINT',
  DesignStage.furniture: 'FURNITURE',
  DesignStage.completed: 'COMPLETED',
};
