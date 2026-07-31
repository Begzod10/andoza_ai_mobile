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

/// Canonical 8-stage renovation timeline. Index order is load-bearing:
/// Mebel (furniture) always comes before Elektr, per the product's hard
/// rule that electrical is placed last, since socket/switch positions
/// depend on where furniture ends up.
enum RenovationStage {
  @JsonValue('SUVOQ')
  suvoq,
  @JsonValue('SHPAKLOVKA')
  shpaklovka,
  @JsonValue('BOYOQ_OBOI')
  boyoqOboi,
  @JsonValue('POL')
  pol,
  @JsonValue('MEBEL')
  mebel,
  @JsonValue('ELEKTR')
  elektr,
  @JsonValue('YORUGLIK')
  yoruglik,
  @JsonValue('SANTEXNIKA')
  santexnika,
}

/// How a single [RenovationStage] should render in any stage-line or
/// progress-bar UI. [excluded] stages were already done before the app
/// started and are never priced — this is the delta mechanic. The other
/// three describe stages actually tracked through the app.
enum StageDisplayState { excluded, completed, inProgress, upcoming }

/// Derives the display state of every [RenovationStage] from the room's
/// starting [condition] and how far the user has progressed
/// ([currentStage]). Stages already satisfied by the room's pre-existing
/// condition are [StageDisplayState.excluded] regardless of [currentStage]
/// and must never be priced by any consumer of this function.
List<StageDisplayState> deriveStageStates({
  required RoomCondition condition,
  required RenovationStage currentStage,
}) {
  final excluded = _excludedStages(condition);
  return RenovationStage.values.map((stage) {
    if (excluded.contains(stage)) return StageDisplayState.excluded;
    if (stage.index < currentStage.index) return StageDisplayState.completed;
    if (stage.index == currentStage.index) return StageDisplayState.inProgress;
    return StageDisplayState.upcoming;
  }).toList();
}

/// Wall-finish progression is linear — shpaklovka implies suvoq is already
/// done too. Floor is independent: an existing covering excludes only the
/// Pol stage. Furniture/electrical/lighting/plumbing (Mebel, Elektr,
/// Yorug'lik, Santexnika) have no pre-existing baseline in the spec — they
/// are always counted, never excluded.
Set<RenovationStage> _excludedStages(RoomCondition condition) {
  final excluded = <RenovationStage>{};
  switch (condition.wall) {
    case SurfaceCondition.puttied:
      excluded.addAll([RenovationStage.suvoq, RenovationStage.shpaklovka]);
    case SurfaceCondition.plastered:
      excluded.add(RenovationStage.suvoq);
    case SurfaceCondition.raw:
      break;
  }
  if (condition.floor == SurfaceCondition.puttied) {
    excluded.add(RenovationStage.pol);
  }
  return excluded;
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
    @Default(RenovationStage.suvoq) RenovationStage renovationStage,
  }) = _DesignSelection;

  factory DesignSelection.fromJson(Map<String, dynamic> json) =>
      _$DesignSelectionFromJson(json);
}
