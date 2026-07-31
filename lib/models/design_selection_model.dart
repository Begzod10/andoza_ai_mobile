import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'converters.dart';

part 'design_selection_model.freezed.dart';
part 'design_selection_model.g.dart';

/// Current condition of room surfaces (baseline for delta calculation).
enum SurfaceCondition {
  @JsonValue('KOROBKA')
  raw,
  @JsonValue('SUVOQ')
  plastered,
  @JsonValue('SHPAKLOVKA')
  puttied,
}

/// Baseline condition of room surfaces (walls, floor, ceiling).
/// Used to compute delta (difference) between current and target finish states.
@freezed
class RoomCondition with _$RoomCondition {
  const factory RoomCondition({
    required SurfaceCondition wall,
    SurfaceCondition? floor,
    SurfaceCondition? ceiling,
  }) = _RoomCondition;

  factory RoomCondition.fromJson(Map<String, dynamic> json) =>
      _$RoomConditionFromJson(json);
}

/// A single furniture item placed in a room with position, rotation, and color.
@freezed
class FurniturePlacement with _$FurniturePlacement {
  const factory FurniturePlacement({
    required String id,
    required String itemId,
    required String name,
    @OffsetConverter() required Offset position,
    @Default(0) double rotationDegrees,
    required String selectedColor,
  }) = _FurniturePlacement;

  factory FurniturePlacement.fromJson(Map<String, dynamic> json) =>
      _$FurniturePlacementFromJson(json);
}

/// Workflow stage of the interior design selection process for a room.
enum DesignStage {
  @JsonValue('FLOOR')
  floor,
  @JsonValue('PAINT')
  paint,
  @JsonValue('FURNITURE')
  furniture,
  @JsonValue('COMPLETED')
  completed,
}

/// Category of material a user can select for a room surface.
enum MaterialType {
  @JsonValue('PAINT')
  paint,
  @JsonValue('WALLPAPER')
  wallpaper,
  @JsonValue('FLOOR_TILE')
  floorTile,
  @JsonValue('WOOD')
  wood,
  @JsonValue('CARPET')
  carpet,
}

/// A single material choice applied to a surface (e.g. one wall or the
/// floor), including its priced area.
@freezed
class MaterialSelection with _$MaterialSelection {
  const factory MaterialSelection({
    required String materialId,
    required MaterialType material,
    required String color,
    required double price,
    required double area,
  }) = _MaterialSelection;

  factory MaterialSelection.fromJson(Map<String, dynamic> json) =>
      _$MaterialSelectionFromJson(json);
}

/// The set of design/material selections made for a single room, keyed
/// by an arbitrary surface identifier (e.g. wall id, "floor").
@freezed
class DesignSelection with _$DesignSelection {
  const factory DesignSelection({
    required String id,
    required String roomId,
    required DesignStage stage,
    @Default(<String, MaterialSelection>{})
    Map<String, MaterialSelection> selections,
    RoomCondition? roomCondition,
    @Default(<FurniturePlacement>[]) List<FurniturePlacement> furniture,
  }) = _DesignSelection;

  factory DesignSelection.fromJson(Map<String, dynamic> json) =>
      _$DesignSelectionFromJson(json);
}
