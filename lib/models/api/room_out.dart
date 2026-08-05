import 'package:freezed_annotation/freezed_annotation.dart';

part 'room_out.freezed.dart';
part 'room_out.g.dart';

/// The backend's room representation (`RoomOut` in `app/schemas/room.py`).
///
/// This is deliberately separate from the app's client-side [Room]
/// (`lib/models/room_model.dart`): the backend keeps geometry/surfaces/state as
/// opaque JSON blobs plus server-computed metrics (floor area, perimeter, …),
/// whereas the client model is a typed capture structure. Repositories map
/// between the two.
@freezed
class RoomOut with _$RoomOut {
  const factory RoomOut({
    required String id,
    @JsonKey(name: 'apartment_id') required String apartmentId,
    required String name,
    @JsonKey(name: 'ceiling_h') double? ceilingH,
    Map<String, dynamic>? geometry,
    Map<String, dynamic>? surfaces,
    @JsonKey(name: 'furniture_layout') List<dynamic>? furnitureLayout,
    Map<String, dynamic>? state,
    @JsonKey(name: 'floor_area') double? floorArea,
    @JsonKey(name: 'net_wall_area') double? netWallArea,
    double? perimeter,
    @JsonKey(name: 'openings_count') @Default(0) int openingsCount,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _RoomOut;

  factory RoomOut.fromJson(Map<String, dynamic> json) =>
      _$RoomOutFromJson(json);
}
