import 'package:freezed_annotation/freezed_annotation.dart';

part 'room_state.freezed.dart';
part 'room_state.g.dart';

/// A room's construction stage. Ordered raw → finished.
///
/// Mirrors `RoomStateValue` (`app/schemas/room_state.py`) and drives the delta
/// pricing (already-completed stages are excluded from what the user pays).
enum RoomStateValue {
  /// Raw korobka — bare concrete shell.
  @JsonValue('xom')
  xom,

  /// Plastered.
  @JsonValue('suvoq')
  suvoq,

  /// Primed + puttied.
  @JsonValue('shpaklovka')
  shpaklovka,

  /// Fully finished.
  @JsonValue('tayyor')
  tayyor,
}

/// Per-room construction state (`GET/POST/PATCH /rooms/{id}/state`).
///
/// Mirrors `app/schemas/room_state.py::RoomStateOut`. Surface-level states are
/// optional and fall back to [currentState] when null.
@freezed
class RoomState with _$RoomState {
  const factory RoomState({
    @JsonKey(name: 'room_id') required String roomId,
    @JsonKey(name: 'current_state') required RoomStateValue currentState,
    @JsonKey(name: 'floor_state') RoomStateValue? floorState,
    @JsonKey(name: 'ceiling_state') RoomStateValue? ceilingState,
    @JsonKey(name: 'walls_state') RoomStateValue? wallsState,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _RoomState;

  factory RoomState.fromJson(Map<String, dynamic> json) =>
      _$RoomStateFromJson(json);
}
