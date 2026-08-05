import '../models/api/api.dart';
import '../services/api_client.dart';

/// Backend-aligned access to apartments (project containers) and the rooms
/// inside them. Paths are relative to the `/api/v1` base.
///
/// This replaces the older `room_repository.dart`, which targeted a
/// `/api/v1/rooms` endpoint that doesn't exist on the backend (rooms are always
/// nested under an apartment) and double-prefixed the base path.
class ApartmentRepository {
  ApartmentRepository(this._client);

  final ApiClient _client;

  // --- Apartments ---------------------------------------------------------

  /// All of the current user's apartments, each with its (non-deleted) rooms.
  Future<List<Apartment>> listApartments() {
    return _client.get<List<Apartment>>(
      '/apartments',
      fromJson: (json) => (json as List<dynamic>)
          .map((e) => Apartment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Creates a new apartment (project container). Returns it without rooms.
  Future<Apartment> createApartment({
    required String name,
    String? address,
    String? developer,
  }) {
    return _client.post<Apartment>(
      '/apartments',
      data: {
        'name': name,
        'address': ?address,
        'developer': ?developer,
      },
      fromJson: (json) => Apartment.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<Apartment> getApartment(String apartmentId) {
    return _client.get<Apartment>(
      '/apartments/$apartmentId',
      fromJson: (json) => Apartment.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<void> deleteApartment(String apartmentId) {
    return _client.delete('/apartments/$apartmentId');
  }

  // --- Rooms --------------------------------------------------------------

  /// Creates a room inside [apartmentId]. The server computes floor area,
  /// perimeter, net wall area and opening count from the geometry.
  Future<RoomOut> createRoom(String apartmentId, RoomCreate body) {
    return _client.post<RoomOut>(
      '/apartments/$apartmentId/rooms',
      data: body.toJson(),
      fromJson: (json) => RoomOut.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<List<RoomOut>> listRooms(String apartmentId) {
    return _client.get<List<RoomOut>>(
      '/apartments/$apartmentId/rooms',
      fromJson: (json) => (json as List<dynamic>)
          .map((e) => RoomOut.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Future<RoomOut> getRoom(String roomId) {
    return _client.get<RoomOut>(
      '/rooms/$roomId',
      fromJson: (json) => RoomOut.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Partial room update (name, ceiling, geometry, or the design blobs
  /// `surfaces`/`furniture_layout`/`state`). Only the provided keys are sent.
  Future<RoomOut> updateRoom(
    String roomId, {
    String? name,
    double? ceilingH,
    Map<String, dynamic>? geometry,
    Map<String, dynamic>? surfaces,
    List<dynamic>? furnitureLayout,
    Map<String, dynamic>? state,
  }) {
    return _client.patch<RoomOut>(
      '/rooms/$roomId',
      data: {
        'name': ?name,
        'ceiling_h': ?ceilingH,
        'geometry': ?geometry,
        'surfaces': ?surfaces,
        'furniture_layout': ?furnitureLayout,
        'state': ?state,
      },
      fromJson: (json) => RoomOut.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<void> deleteRoom(String roomId) {
    return _client.delete('/rooms/$roomId');
  }
}
