import '../models/api/api.dart';
import '../services/api_client.dart';

/// Read/replace a room's electrical plan via `GET`/`PUT
/// /rooms/{id}/electrical`, plus single-device CRUD. Paths are relative to
/// `/api/v1`.
class ElectricalRepository {
  ElectricalRepository(this._client);

  final ApiClient _client;

  Future<ElectricalPlan> getPlan(String roomId) {
    return _client.get<ElectricalPlan>(
      '/rooms/$roomId/electrical',
      fromJson: (json) => ElectricalPlan.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Replaces the entire electrical plan (all devices + total wiring length).
  Future<ElectricalPlan> savePlan(
    String roomId, {
    required List<ElectricalDeviceCreate> devices,
    double? wiringMeters,
  }) {
    return _client.put<ElectricalPlan>(
      '/rooms/$roomId/electrical',
      data: {
        'devices': [
          for (final d in devices)
            {
              'type': _deviceTypeWire(d.type),
              'variant': d.variant,
              'wall_index': d.wallIndex,
              'x': d.x,
              'y': d.y,
              'count': d.count,
            },
        ],
        'wiring_meters': wiringMeters,
      },
      fromJson: (json) => ElectricalPlan.fromJson(json as Map<String, dynamic>),
    );
  }

  /// The backend Literal value for a device type.
  String _deviceTypeWire(ElectricalDeviceType t) => switch (t) {
        ElectricalDeviceType.socket => 'socket',
        ElectricalDeviceType.switch_ => 'switch',
        ElectricalDeviceType.light => 'light',
        ElectricalDeviceType.panel => 'panel',
        ElectricalDeviceType.box => 'box',
      };
}
