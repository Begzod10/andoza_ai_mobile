import '../models/api/api.dart';
import '../services/api_client.dart';

/// Read/replace a room's decoration selections (walls/floor/ceiling/furniture)
/// via `GET`/`PUT /rooms/{id}/decoration`. Paths are relative to `/api/v1`.
class DecorationRepository {
  DecorationRepository(this._client);

  final ApiClient _client;

  Future<Decoration> getDecoration(String roomId) {
    return _client.get<Decoration>(
      '/rooms/$roomId/decoration',
      fromJson: (json) => Decoration.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Replaces the whole decoration selection in one call. Any field left null
  /// clears that surface's material.
  Future<Decoration> saveDecoration(
    String roomId, {
    WallsDecoration walls = const WallsDecoration(),
    FloorDecoration floor = const FloorDecoration(),
    CeilingDecoration ceiling = const CeilingDecoration(),
    List<DecorationFurniture> furniture = const [],
  }) {
    return _client.put<Decoration>(
      '/rooms/$roomId/decoration',
      data: {
        'walls': {
          'material_id': walls.materialId,
          'finish': walls.finish,
          'color': walls.color,
        },
        'floor': {'material_id': floor.materialId},
        'ceiling': {'material_id': ceiling.materialId},
        'furniture': [
          for (final f in furniture)
            {
              'furniture_id': f.furnitureId,
              'x': f.x,
              'y': f.y,
              'rotation': f.rotation,
            },
        ],
      },
      fromJson: (json) => Decoration.fromJson(json as Map<String, dynamic>),
    );
  }
}
