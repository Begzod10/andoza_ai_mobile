import 'package:dio/dio.dart';
import '../models/room_model.dart';
import '../services/api_client.dart';

/// Exception for room repository operations
class RoomException implements Exception {
  RoomException(this.message);
  final String message;

  @override
  String toString() => 'RoomException: $message';
}

/// Abstract interface for room data operations
abstract interface class RoomRepository {
  Future<Room> create(Room room);
  Future<Room> getById(String id);
  Future<Room> update(Room room);
  Future<void> delete(String id);
}

/// Implementation of RoomRepository using API
class RoomRepositoryImpl implements RoomRepository {
  const RoomRepositoryImpl(this._apiClient);

  final ApiClient _apiClient;
  static const String _basePath = '/api/v1/rooms';

  @override
  Future<Room> create(Room room) async {
    try {
      return await _apiClient.post(
        _basePath,
        data: room.toJson(),
        fromJson: (json) => Room.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      throw RoomException('Failed to create room: ${e.message}');
    }
  }

  @override
  Future<Room> getById(String id) async {
    try {
      return await _apiClient.get(
        '$_basePath/$id',
        fromJson: (json) => Room.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      throw RoomException('Failed to fetch room: ${e.message}');
    }
  }

  @override
  Future<Room> update(Room room) async {
    try {
      return await _apiClient.put(
        '$_basePath/${room.id}',
        data: room.toJson(),
        fromJson: (json) => Room.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      throw RoomException('Failed to update room: ${e.message}');
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await _apiClient.delete('$_basePath/$id');
    } on DioException catch (e) {
      throw RoomException('Failed to delete room: ${e.message}');
    }
  }
}
