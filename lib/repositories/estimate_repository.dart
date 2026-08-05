import '../models/api/api.dart';
import '../services/api_client.dart';

/// Backend-aligned smeta (estimate) access for a room. Paths are relative to
/// the `/api/v1` base.
///
/// Endpoints (see `app/routers/estimate.py`):
///   POST /rooms/{id}/estimate/preview  → live, unpersisted
///   POST /rooms/{id}/estimate          → compute + persist a snapshot
///   GET  /rooms/{id}/estimates         → paginated history (summaries)
///   GET  /estimates/{id}               → a single persisted estimate
///   GET  /rooms/{id}/estimate.pdf      → ReportLab PDF (bytes)
class EstimateRepository {
  EstimateRepository(this._client);

  final ApiClient _client;

  /// Live smeta preview — computed but not stored. Use while the user is still
  /// configuring the room.
  Future<Estimate> preview(String roomId) {
    return _client.post<Estimate>(
      '/rooms/$roomId/estimate/preview',
      data: const <String, dynamic>{},
      fromJson: (json) => Estimate.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Computes and persists an immutable smeta snapshot.
  Future<Estimate> create(String roomId) {
    return _client.post<Estimate>(
      '/rooms/$roomId/estimate',
      data: const <String, dynamic>{},
      fromJson: (json) => Estimate.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Paginated estimate history (newest first), summary rows only.
  Future<PaginatedEstimates> history(
    String roomId, {
    int limit = 20,
    int offset = 0,
  }) {
    return _client.get<PaginatedEstimates>(
      '/rooms/$roomId/estimates',
      queryParameters: {'limit': limit, 'offset': offset},
      fromJson: (json) =>
          PaginatedEstimates.fromJson(json as Map<String, dynamic>),
    );
  }

  /// A single persisted estimate by id (not room-scoped on the server).
  Future<Estimate> getById(String estimateId) {
    return _client.get<Estimate>(
      '/estimates/$estimateId',
      fromJson: (json) => Estimate.fromJson(json as Map<String, dynamic>),
    );
  }

  /// The latest smeta rendered as a PDF, returned as raw bytes ready to write
  /// to a file and share.
  Future<List<int>> downloadPdf(String roomId) {
    // Uses the slash alias (`/estimate/pdf`) rather than `estimate.pdf` to
    // avoid any client/proxy mangling of the literal dot in the path.
    return _client.getBytes('/rooms/$roomId/estimate/pdf');
  }
}
