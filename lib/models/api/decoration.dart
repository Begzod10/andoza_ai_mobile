import 'package:freezed_annotation/freezed_annotation.dart';

part 'decoration.freezed.dart';
part 'decoration.g.dart';

/// Wall decoration (`app/schemas/decoration.py::WallsDecoration`). [finish] is
/// `paint` or `wallpaper`; [color] is a `#RRGGBB` hex or null.
@freezed
class WallsDecoration with _$WallsDecoration {
  const factory WallsDecoration({
    @JsonKey(name: 'material_id') String? materialId,
    @Default('paint') String finish,
    String? color,
  }) = _WallsDecoration;

  factory WallsDecoration.fromJson(Map<String, dynamic> json) =>
      _$WallsDecorationFromJson(json);
}

/// Floor decoration — just a material reference.
@freezed
class FloorDecoration with _$FloorDecoration {
  const factory FloorDecoration({
    @JsonKey(name: 'material_id') String? materialId,
  }) = _FloorDecoration;

  factory FloorDecoration.fromJson(Map<String, dynamic> json) =>
      _$FloorDecorationFromJson(json);
}

/// Ceiling decoration — just a material reference.
@freezed
class CeilingDecoration with _$CeilingDecoration {
  const factory CeilingDecoration({
    @JsonKey(name: 'material_id') String? materialId,
  }) = _CeilingDecoration;

  factory CeilingDecoration.fromJson(Map<String, dynamic> json) =>
      _$CeilingDecorationFromJson(json);
}

/// A furniture placement inside the decoration blob (position + rotation).
@freezed
class DecorationFurniture with _$DecorationFurniture {
  const factory DecorationFurniture({
    @JsonKey(name: 'furniture_id') required String furnitureId,
    required double x,
    required double y,
    @Default(0.0) double rotation,
  }) = _DecorationFurniture;

  factory DecorationFurniture.fromJson(Map<String, dynamic> json) =>
      _$DecorationFurnitureFromJson(json);
}

/// The full decoration state for a room (`GET/PUT /rooms/{id}/decoration`).
@freezed
class Decoration with _$Decoration {
  const factory Decoration({
    @JsonKey(name: 'room_id') required String roomId,
    @Default(WallsDecoration()) WallsDecoration walls,
    @Default(FloorDecoration()) FloorDecoration floor,
    @Default(CeilingDecoration()) CeilingDecoration ceiling,
    @Default(<DecorationFurniture>[]) List<DecorationFurniture> furniture,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _Decoration;

  factory Decoration.fromJson(Map<String, dynamic> json) =>
      _$DecorationFromJson(json);
}
