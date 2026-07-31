import '../services/api_client.dart';

/// A repair master/contractor that can be discovered and booked.
class Master {
  const Master({
    required this.id,
    required this.name,
    this.avatar,
    this.specialty,
    this.rating,
    this.reviewCount = 0,
    this.latitude,
    this.longitude,
    this.distanceKm,
    this.isAvailable = true,
  });

  factory Master.fromJson(Map<String, dynamic> json) {
    return Master(
      id: json['id'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String?,
      specialty: json['specialty'] as String?,
      rating: json['rating'] != null
          ? (json['rating'] as num).toDouble()
          : null,
      reviewCount: (json['review_count'] as num?)?.toInt() ?? 0,
      latitude: json['latitude'] != null
          ? (json['latitude'] as num).toDouble()
          : null,
      longitude: json['longitude'] != null
          ? (json['longitude'] as num).toDouble()
          : null,
      distanceKm: json['distance_km'] != null
          ? (json['distance_km'] as num).toDouble()
          : null,
      isAvailable: json['is_available'] as bool? ?? true,
    );
  }

  final String id;
  final String name;
  final String? avatar;
  final String? specialty;
  final double? rating;
  final int reviewCount;
  final double? latitude;
  final double? longitude;

  /// Distance from the searched location in kilometers. Only populated by
  /// [MastersRepository.searchByLocation].
  final double? distanceKm;
  final bool isAvailable;
}

/// A user-submitted review of a [Master].
class MasterReview {
  const MasterReview({
    required this.id,
    required this.masterId,
    required this.userId,
    required this.rating,
    this.userName,
    this.comment,
    this.createdAt,
  });

  factory MasterReview.fromJson(Map<String, dynamic> json) {
    return MasterReview(
      id: json['id'] as String,
      masterId: json['master_id'] as String,
      userId: json['user_id'] as String,
      userName: json['user_name'] as String?,
      rating: (json['rating'] as num).toInt(),
      comment: json['comment'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }

  final String id;
  final String masterId;
  final String userId;
  final String? userName;
  final int rating;
  final String? comment;
  final DateTime? createdAt;

  Map<String, dynamic> toJson() => {
    'master_id': masterId,
    'rating': rating,
    if (comment != null) 'comment': comment,
  };
}

abstract interface class MastersRepository {
  /// Geospatial search for masters within [radiusKm] of ([lat], [lng]),
  /// ordered by distance.
  Future<List<Master>> searchByLocation({
    required double lat,
    required double lng,
    double radiusKm = 10,
  });

  Future<Master> getById(String id);
  Future<List<MasterReview>> getReviews(String masterId);

  /// Shares an existing estimate with a master (e.g. to request a quote).
  Future<void> sendEstimate({
    required String masterId,
    required String estimateId,
  });

  /// Returns masters with open availability on all of [dates].
  Future<List<Master>> getAvailable(List<DateTime> dates);

  Future<MasterReview> createReview({
    required String masterId,
    required MasterReview review,
  });
}

class MastersRepositoryImpl implements MastersRepository {
  MastersRepositoryImpl(this._apiClient);

  final ApiClient _apiClient;

  // ApiClient is configured with AppConfig.apiUrl, which already includes
  // the `/api/v1` prefix, so paths here are relative to that base.
  static const _basePath = '/masters';

  @override
  Future<List<Master>> searchByLocation({
    required double lat,
    required double lng,
    double radiusKm = 10,
  }) async {
    try {
      return await _apiClient.get<List<Master>>(
        '$_basePath/search',
        queryParameters: {'lat': lat, 'lng': lng, 'radius_km': radiusKm},
        fromJson: (json) => (json as List<dynamic>)
            .map((e) => Master.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } on ApiException catch (e) {
      throw MastersException(e.message);
    }
  }

  @override
  Future<Master> getById(String id) async {
    try {
      return await _apiClient.get<Master>(
        '$_basePath/$id',
        fromJson: (json) => Master.fromJson(json as Map<String, dynamic>),
      );
    } on ApiException catch (e) {
      throw MastersException(e.message);
    }
  }

  @override
  Future<List<MasterReview>> getReviews(String masterId) async {
    try {
      return await _apiClient.get<List<MasterReview>>(
        '$_basePath/$masterId/reviews',
        fromJson: (json) => (json as List<dynamic>)
            .map((e) => MasterReview.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } on ApiException catch (e) {
      throw MastersException(e.message);
    }
  }

  @override
  Future<void> sendEstimate({
    required String masterId,
    required String estimateId,
  }) async {
    try {
      await _apiClient.post<void>(
        '$_basePath/$masterId/estimates',
        data: {'estimate_id': estimateId},
        fromJson: (_) {},
      );
    } on ApiException catch (e) {
      throw MastersException(e.message);
    }
  }

  @override
  Future<List<Master>> getAvailable(List<DateTime> dates) async {
    try {
      final isoDates = dates.map((d) => d.toIso8601String()).join(',');
      return await _apiClient.get<List<Master>>(
        '$_basePath/available',
        queryParameters: {'dates': isoDates},
        fromJson: (json) => (json as List<dynamic>)
            .map((e) => Master.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } on ApiException catch (e) {
      throw MastersException(e.message);
    }
  }

  @override
  Future<MasterReview> createReview({
    required String masterId,
    required MasterReview review,
  }) async {
    try {
      return await _apiClient.post<MasterReview>(
        '$_basePath/$masterId/reviews',
        data: review.toJson(),
        fromJson: (json) => MasterReview.fromJson(json as Map<String, dynamic>),
      );
    } on ApiException catch (e) {
      throw MastersException(e.message);
    }
  }
}

class MastersException implements Exception {
  MastersException(this.message);
  final String message;

  @override
  String toString() => message;
}
