import '../services/api_client.dart';

/// A single priced line within an [EstimateStage].
class EstimateLineItem {
  const EstimateLineItem({
    required this.id,
    required this.description,
    required this.quantity,
    required this.unit,
    required this.unitPrice,
    required this.totalPrice,
  });

  factory EstimateLineItem.fromJson(Map<String, dynamic> json) {
    return EstimateLineItem(
      id: json['id'] as String,
      description: json['description'] as String,
      quantity: (json['quantity'] as num).toInt(),
      unit: json['unit'] as String,
      unitPrice: (json['unit_price'] as num).toDouble(),
      totalPrice: (json['total_price'] as num).toDouble(),
    );
  }

  final String id;
  final String description;
  final int quantity;
  final String unit;
  final double unitPrice;
  final double totalPrice;

  Map<String, dynamic> toJson() => {
    'id': id,
    'description': description,
    'quantity': quantity,
    'unit': unit,
    'unit_price': unitPrice,
    'total_price': totalPrice,
  };
}

/// A phase of work (e.g. "Demolition", "Electrical") within an [Estimate].
class EstimateStage {
  const EstimateStage({
    required this.id,
    required this.name,
    required this.order,
    required this.cost,
    this.lineItems = const [],
  });

  factory EstimateStage.fromJson(Map<String, dynamic> json) {
    final items = json['line_items'] as List<dynamic>? ?? const [];
    return EstimateStage(
      id: json['id'] as String,
      name: json['name'] as String,
      order: (json['order'] as num).toInt(),
      cost: (json['cost'] as num).toDouble(),
      lineItems: items
          .map((e) => EstimateLineItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  final String id;
  final String name;
  final int order;
  final double cost;
  final List<EstimateLineItem> lineItems;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'order': order,
    'cost': cost,
    'line_items': lineItems.map((e) => e.toJson()).toList(),
  };
}

/// A repair/renovation cost estimate for a room, made up of ordered stages.
class Estimate {
  const Estimate({
    required this.id,
    required this.roomId,
    required this.totalCost,
    required this.status,
    this.userId,
    this.stages = const [],
    this.createdAt,
    this.updatedAt,
  });

  factory Estimate.fromJson(Map<String, dynamic> json) {
    final stages = json['stages'] as List<dynamic>? ?? const [];
    return Estimate(
      id: json['id'] as String,
      roomId: json['room_id'] as String,
      userId: json['user_id'] as String?,
      totalCost: (json['total_cost'] as num).toDouble(),
      status: json['status'] as String? ?? 'draft',
      stages: stages
          .map((e) => EstimateStage.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  final String id;
  final String roomId;
  final String? userId;
  final double totalCost;
  final String status;
  final List<EstimateStage> stages;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Map<String, dynamic> toJson() => {
    'id': id,
    'room_id': roomId,
    if (userId != null) 'user_id': userId,
    'total_cost': totalCost,
    'status': status,
    'stages': stages.map((e) => e.toJson()).toList(),
  };
}

abstract interface class EstimateRepository {
  Future<Estimate> getById(String id);
  Future<List<Estimate>> getByRoomId(String roomId);
  Future<Estimate> create(Estimate estimate);
  Future<Estimate> update(Estimate estimate);
  Future<void> delete(String id);

  /// Triggers server-side recomputation of the estimate for [roomId]
  /// (e.g. after LiDAR room measurements or material choices change).
  Future<Estimate> computeEstimate(String roomId);

  /// Returns every estimate ever generated for [userId], most recent first.
  Future<List<Estimate>> getEstimateHistory(String userId);
}

class EstimateRepositoryImpl implements EstimateRepository {
  EstimateRepositoryImpl(this._apiClient);

  final ApiClient _apiClient;

  // ApiClient is configured with AppConfig.apiUrl, which already includes
  // the `/api/v1` prefix, so paths here are relative to that base.
  static const _basePath = '/estimates';

  @override
  Future<Estimate> getById(String id) async {
    try {
      return await _apiClient.get<Estimate>(
        '$_basePath/$id',
        fromJson: (json) => Estimate.fromJson(json as Map<String, dynamic>),
      );
    } on ApiException catch (e) {
      throw EstimateException(e.message);
    }
  }

  @override
  Future<List<Estimate>> getByRoomId(String roomId) async {
    try {
      return await _apiClient.get<List<Estimate>>(
        _basePath,
        queryParameters: {'room_id': roomId},
        fromJson: (json) => (json as List<dynamic>)
            .map((e) => Estimate.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } on ApiException catch (e) {
      throw EstimateException(e.message);
    }
  }

  @override
  Future<Estimate> create(Estimate estimate) async {
    try {
      return await _apiClient.post<Estimate>(
        _basePath,
        data: estimate.toJson(),
        fromJson: (json) => Estimate.fromJson(json as Map<String, dynamic>),
      );
    } on ApiException catch (e) {
      throw EstimateException(e.message);
    }
  }

  @override
  Future<Estimate> update(Estimate estimate) async {
    try {
      return await _apiClient.put<Estimate>(
        '$_basePath/${estimate.id}',
        data: estimate.toJson(),
        fromJson: (json) => Estimate.fromJson(json as Map<String, dynamic>),
      );
    } on ApiException catch (e) {
      throw EstimateException(e.message);
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await _apiClient.delete('$_basePath/$id');
    } on ApiException catch (e) {
      throw EstimateException(e.message);
    }
  }

  @override
  Future<Estimate> computeEstimate(String roomId) async {
    try {
      return await _apiClient.post<Estimate>(
        '$_basePath/compute',
        data: {'room_id': roomId},
        fromJson: (json) => Estimate.fromJson(json as Map<String, dynamic>),
      );
    } on ApiException catch (e) {
      throw EstimateException(e.message);
    }
  }

  @override
  Future<List<Estimate>> getEstimateHistory(String userId) async {
    try {
      return await _apiClient.get<List<Estimate>>(
        '$_basePath/history',
        queryParameters: {'user_id': userId},
        fromJson: (json) => (json as List<dynamic>)
            .map((e) => Estimate.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } on ApiException catch (e) {
      throw EstimateException(e.message);
    }
  }
}

class EstimateException implements Exception {
  EstimateException(this.message);
  final String message;

  @override
  String toString() => message;
}
