// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'design_selection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RoomCondition _$RoomConditionFromJson(Map<String, dynamic> json) =>
    _RoomCondition(
      wall: $enumDecode(
        _$SurfaceConditionEnumMap,
        json['wall'],
        unknownValue: SurfaceCondition.unknown,
      ),
      floor: $enumDecodeNullable(
        _$SurfaceConditionEnumMap,
        json['floor'],
        unknownValue: SurfaceCondition.unknown,
      ),
      ceiling: $enumDecodeNullable(
        _$SurfaceConditionEnumMap,
        json['ceiling'],
        unknownValue: SurfaceCondition.unknown,
      ),
    );

Map<String, dynamic> _$RoomConditionToJson(_RoomCondition instance) =>
    <String, dynamic>{
      'wall': _$SurfaceConditionEnumMap[instance.wall]!,
      'floor': _$SurfaceConditionEnumMap[instance.floor],
      'ceiling': _$SurfaceConditionEnumMap[instance.ceiling],
    };

const _$SurfaceConditionEnumMap = {
  SurfaceCondition.raw: 'KOROBKA',
  SurfaceCondition.plastered: 'SUVOQ',
  SurfaceCondition.puttied: 'SHPAKLOVKA',
  SurfaceCondition.unknown: 'unknown',
};

_FurniturePlacement _$FurniturePlacementFromJson(Map<String, dynamic> json) =>
    _FurniturePlacement(
      id: json['id'] as String,
      itemId: json['itemId'] as String,
      name: json['name'] as String,
      position: const OffsetConverter().fromJson(
        json['position'] as Map<String, dynamic>,
      ),
      rotationDegrees: (json['rotationDegrees'] as num?)?.toDouble() ?? 0,
      selectedColor: json['selectedColor'] as String,
    );

Map<String, dynamic> _$FurniturePlacementToJson(_FurniturePlacement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'itemId': instance.itemId,
      'name': instance.name,
      'position': const OffsetConverter().toJson(instance.position),
      'rotationDegrees': instance.rotationDegrees,
      'selectedColor': instance.selectedColor,
    };

_MaterialSelection _$MaterialSelectionFromJson(Map<String, dynamic> json) =>
    _MaterialSelection(
      materialId: json['materialId'] as String,
      material: $enumDecode(
        _$MaterialTypeEnumMap,
        json['material'],
        unknownValue: MaterialType.unknown,
      ),
      color: json['color'] as String,
      price: (json['price'] as num).toDouble(),
      area: (json['area'] as num).toDouble(),
    );

Map<String, dynamic> _$MaterialSelectionToJson(_MaterialSelection instance) =>
    <String, dynamic>{
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
  MaterialType.unknown: 'unknown',
};

_DesignSelection _$DesignSelectionFromJson(
  Map<String, dynamic> json,
) => _DesignSelection(
  id: json['id'] as String,
  roomId: json['roomId'] as String,
  stage: $enumDecode(
    _$DesignStageEnumMap,
    json['stage'],
    unknownValue: DesignStage.unknown,
  ),
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
  renovationStage:
      $enumDecodeNullable(
        _$RenovationStageEnumMap,
        json['renovationStage'],
        unknownValue: RenovationStage.unknown,
      ) ??
      RenovationStage.suvoq,
);

Map<String, dynamic> _$DesignSelectionToJson(_DesignSelection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'roomId': instance.roomId,
      'stage': _$DesignStageEnumMap[instance.stage]!,
      'selections': instance.selections,
      'roomCondition': instance.roomCondition,
      'furniture': instance.furniture,
      'renovationStage': _$RenovationStageEnumMap[instance.renovationStage]!,
    };

const _$DesignStageEnumMap = {
  DesignStage.floor: 'FLOOR',
  DesignStage.paint: 'PAINT',
  DesignStage.furniture: 'FURNITURE',
  DesignStage.completed: 'COMPLETED',
  DesignStage.unknown: 'unknown',
};

const _$RenovationStageEnumMap = {
  RenovationStage.suvoq: 'SUVOQ',
  RenovationStage.shpaklovka: 'SHPAKLOVKA',
  RenovationStage.boyoqOboi: 'BOYOQ_OBOI',
  RenovationStage.pol: 'POL',
  RenovationStage.mebel: 'MEBEL',
  RenovationStage.elektr: 'ELEKTR',
  RenovationStage.yoruglik: 'YORUGLIK',
  RenovationStage.santexnika: 'SANTEXNIKA',
  RenovationStage.unknown: 'unknown',
};
