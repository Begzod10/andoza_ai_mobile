import '../models/api/api.dart';
import '../services/api_client.dart';

/// Access to a room's construction-progress state and the delta calculation
/// (`/rooms/{id}/state` and `/rooms/{id}/delta`). Paths are relative to the
/// `/api/v1` base.
class RoomStateRepository {
  RoomStateRepository(this._client);

  final ApiClient _client;

  /// Current construction state (the server auto-creates a default `xom` row
  /// if the room has none yet, so this never 404s for an owned room).
  Future<RoomState> getState(String roomId) {
    return _client.get<RoomState>(
      '/rooms/$roomId/state',
      fromJson: (json) => RoomState.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Creates or fully replaces the room's state.
  Future<RoomState> setState(
    String roomId, {
    required RoomStateValue currentState,
    RoomStateValue? floorState,
    RoomStateValue? ceilingState,
    RoomStateValue? wallsState,
  }) {
    return _client.post<RoomState>(
      '/rooms/$roomId/state',
      data: {
        'current_state': _wire(currentState),
        'floor_state': ?_wireOrNull(floorState),
        'ceiling_state': ?_wireOrNull(ceilingState),
        'walls_state': ?_wireOrNull(wallsState),
      },
      fromJson: (json) => RoomState.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Partially updates the room's state (only the provided surfaces).
  Future<RoomState> patchState(
    String roomId, {
    RoomStateValue? currentState,
    RoomStateValue? floorState,
    RoomStateValue? ceilingState,
    RoomStateValue? wallsState,
  }) {
    return _client.patch<RoomState>(
      '/rooms/$roomId/state',
      data: {
        'current_state': ?_wireOrNull(currentState),
        'floor_state': ?_wireOrNull(floorState),
        'ceiling_state': ?_wireOrNull(ceilingState),
        'walls_state': ?_wireOrNull(wallsState),
      },
      fromJson: (json) => RoomState.fromJson(json as Map<String, dynamic>),
    );
  }

  /// The authoritative delta: material/cost difference between the room's
  /// current stage and a fully-finished room (feeds the "tejaldingiz" banner).
  Future<DeltaResponse> getDelta(String roomId) {
    return _client.get<DeltaResponse>(
      '/rooms/$roomId/delta',
      fromJson: (json) => DeltaResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  /// The wire value for a [RoomStateValue] (matches the backend Literal).
  String _wire(RoomStateValue v) => switch (v) {
        RoomStateValue.xom => 'xom',
        RoomStateValue.suvoq => 'suvoq',
        RoomStateValue.shpaklovka => 'shpaklovka',
        RoomStateValue.tayyor => 'tayyor',
      };

  /// Null-tolerant [_wire] for optional fields.
  String? _wireOrNull(RoomStateValue? v) => v == null ? null : _wire(v);
}
