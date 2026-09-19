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

  /// Fallback for any condition value the backend/storage adds that this client
  /// predates. Deserialization maps unknown strings here instead of throwing.
  unknown,
}

/// Baseline condition of room surfaces (walls, floor, ceiling).
/// Used to compute delta (difference) between current and target finish states.
@freezed
abstract class RoomCondition with _$RoomCondition {
  const factory RoomCondition({
    @JsonKey(unknownEnumValue: SurfaceCondition.unknown)
    required SurfaceCondition wall,
    @JsonKey(unknownEnumValue: SurfaceCondition.unknown) SurfaceCondition? floor,
    @JsonKey(unknownEnumValue: SurfaceCondition.unknown)
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

  /// Fallback for any stage the backend/storage adds that this client predates.
  /// Deserialization maps unknown strings here instead of throwing. Kept last so
  /// existing index-based ordering of the canonical 8 stages is unaffected, and
  /// filtered out of [deriveStageStates] so it never appears in stage-line UI.
  unknown,
}

/// How a single [RenovationStage] should render in any stage-line or
/// progress-bar UI. [excluded] stages were already done before the app
/// started and are never priced — this is the delta mechanic. The other
/// three describe stages actually tracked through the app.
enum StageDisplayState { excluded, completed, inProgress, upcoming }

/// The canonical 8 construction stages, in order, EXCLUDING
/// [RenovationStage.unknown] (a deserialization-only fallback). Iterate this
/// — never `RenovationStage.values` — anywhere you price stages or size a
/// stage stepper, so the unknown fallback never leaks into real stage logic.
final List<RenovationStage> kRenovationStages = RenovationStage.values
    .where((s) => s != RenovationStage.unknown)
    .toList(growable: false);

/// Selectable surface conditions, EXCLUDING [SurfaceCondition.unknown]
/// (deserialization-only fallback). Use for condition-picker UIs.
final List<SurfaceCondition> kSurfaceConditions = SurfaceCondition.values
    .where((c) => c != SurfaceCondition.unknown)
    .toList(growable: false);

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
  // Only the canonical 8 stages render; [RenovationStage.unknown] is a
  // deserialization fallback and is never part of the stage line.
  return RenovationStage.values
      .where((stage) => stage != RenovationStage.unknown)
      .map((stage) {
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
    case SurfaceCondition.unknown:
      // Unknown/raw baseline: exclude nothing (price every stage).
      break;
  }
  if (condition.floor == SurfaceCondition.puttied) {
    excluded.add(RenovationStage.pol);
  }
  return excluded;
}

/// A single furniture item placed in a room with position, rotation, and color.
@freezed
abstract class FurniturePlacement with _$FurniturePlacement {
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

  /// Fallback for any stage the backend/storage adds that this client predates.
  /// Deserialization maps unknown strings here instead of throwing.
  unknown,
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

  /// Fallback for any material type the backend/storage adds that this client
  /// predates. Deserialization maps unknown strings here instead of throwing.
  unknown,
}

/// A single material choice applied to a surface (e.g. one wall or the
/// floor), including its priced area.
@freezed
abstract class MaterialSelection with _$MaterialSelection {
  const factory MaterialSelection({
    required String materialId,
    @JsonKey(unknownEnumValue: MaterialType.unknown)
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
abstract class DesignSelection with _$DesignSelection {
  const factory DesignSelection({
    required String id,
    required String roomId,
    @JsonKey(unknownEnumValue: DesignStage.unknown) required DesignStage stage,
    @Default(<String, MaterialSelection>{})
    Map<String, MaterialSelection> selections,
    RoomCondition? roomCondition,
    @Default(<FurniturePlacement>[]) List<FurniturePlacement> furniture,
    @JsonKey(unknownEnumValue: RenovationStage.unknown)
    @Default(RenovationStage.suvoq)
    RenovationStage renovationStage,
  }) = _DesignSelection;

  factory DesignSelection.fromJson(Map<String, dynamic> json) =>
      _$DesignSelectionFromJson(json);
}
