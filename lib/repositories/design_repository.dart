import 'package:dio/dio.dart';
import '../models/design_selection_model.dart';
import '../services/api_client.dart';

/// Exception for design repository operations
class DesignException implements Exception {
  DesignException(this.message);
  final String message;

  @override
  String toString() => 'DesignException: $message';
}

/// Abstract interface for design selection data operations
abstract interface class DesignRepository {
  Future<DesignSelection> create(DesignSelection selection);
  Future<DesignSelection> getById(String id);
  Future<DesignSelection> getByRoomId(String roomId);
  Future<DesignSelection> update(DesignSelection selection);
  Future<void> delete(String id);
}

/// Implementation of DesignRepository using API
class DesignRepositoryImpl implements DesignRepository {
  const DesignRepositoryImpl(this._apiClient);

  final ApiClient _apiClient;
  static const String _basePath = '/api/v1/designs';

  @override
  Future<DesignSelection> create(DesignSelection selection) async {
    try {
      return await _apiClient.post(
        _basePath,
        data: selection.toJson(),
        fromJson: (json) =>
            DesignSelection.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      throw DesignException('Failed to create design selection: ${e.message}');
    }
  }

  @override
  Future<DesignSelection> getById(String id) async {
    try {
      return await _apiClient.get(
        '$_basePath/$id',
        fromJson: (json) =>
            DesignSelection.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      throw DesignException('Failed to fetch design selection: ${e.message}');
    }
  }

  @override
  Future<DesignSelection> getByRoomId(String roomId) async {
    try {
      return await _apiClient.get(
        '$_basePath/room/$roomId',
        fromJson: (json) =>
            DesignSelection.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      throw DesignException('Failed to fetch room design: ${e.message}');
    }
  }

  @override
  Future<DesignSelection> update(DesignSelection selection) async {
    try {
      return await _apiClient.put(
        '$_basePath/${selection.id}',
        data: selection.toJson(),
        fromJson: (json) =>
            DesignSelection.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      throw DesignException('Failed to update design selection: ${e.message}');
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await _apiClient.delete('$_basePath/$id');
    } on DioException catch (e) {
      throw DesignException('Failed to delete design selection: ${e.message}');
    }
  }
}
