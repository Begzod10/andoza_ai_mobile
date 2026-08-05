import '../models/api/api.dart';
import '../services/api_client.dart';

/// Read access to the backend catalog: materials, furniture, partner stores,
/// and the craftsmen (ustalar) directory. Endpoints are mounted under
/// `/api/v1`, so paths here are relative to that base (see [ApiClient]).
///
/// The backend caches these responses for 10 minutes; callers can layer their
/// own provider-level caching on top (Riverpod keeps the future alive while
/// watched).
class CatalogRepository {
  CatalogRepository(this._client);

  final ApiClient _client;

  /// Paginated active materials, optionally filtered by [category] (e.g.
  /// `boyoq`, `oboy`, `laminat`, `plitka`, `eshik`, `deraza`, `gips`) and/or a
  /// specific [storeId].
  Future<PaginatedMaterials> getMaterials({
    String? category,
    String? storeId,
    int page = 1,
    int perPage = 20,
  }) {
    return _client.get<PaginatedMaterials>(
      '/materials',
      queryParameters: _params({
        'category': category,
        'store': storeId,
        'page': page,
        'per_page': perPage,
      }),
      fromJson: (json) =>
          PaginatedMaterials.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Paginated furniture / 3D-model catalog, optionally filtered by [category].
  Future<PaginatedFurniture> getFurniture({
    String? category,
    int page = 1,
    int perPage = 20,
  }) {
    return _client.get<PaginatedFurniture>(
      '/furniture',
      queryParameters: _params({
        'category': category,
        'page': page,
        'per_page': perPage,
      }),
      fromJson: (json) =>
          PaginatedFurniture.fromJson(json as Map<String, dynamic>),
    );
  }

  /// All active partner stores (ordered by tier then name on the server).
  Future<List<Store>> getStores() {
    return _client.get<List<Store>>(
      '/stores',
      fromJson: (json) => (json as List<dynamic>)
          .map((e) => Store.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// The craftsmen directory, optionally filtered by [category] and/or
  /// [district]. Ordered by rating (desc) on the server.
  Future<List<Usta>> getUstalar({String? category, String? district}) {
    return _client.get<List<Usta>>(
      '/ustalar',
      queryParameters: _params({'category': category, 'district': district}),
      fromJson: (json) => (json as List<dynamic>)
          .map((e) => Usta.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Drops null-valued entries so dio doesn't send `?category=null`.
  Map<String, dynamic> _params(Map<String, dynamic> raw) {
    final out = <String, dynamic>{};
    raw.forEach((k, v) {
      if (v != null) out[k] = v;
    });
    return out;
  }
}
