import '../models/api/api.dart';
import '../services/api_client.dart';

/// Backend-aligned access to shop orders. Paths are relative to the
/// `/api/v1` base. Mirrors [ApartmentRepository]'s construction/style.
class OrdersRepository {
  OrdersRepository(this._client);

  final ApiClient _client;

  /// Creates an order for the current user. The server computes the total
  /// from [lines] and returns the persisted [ServerOrder] (201).
  Future<ServerOrder> createOrder({
    required String dealerName,
    required List<OrderLineCreate> lines,
  }) {
    return _client.post<ServerOrder>(
      '/orders',
      data: {
        'dealer_name': dealerName,
        'lines': lines.map((l) => l.toJson()).toList(),
      },
      fromJson: (json) => ServerOrder.fromJson(json as Map<String, dynamic>),
    );
  }

  /// The current user's orders, newest first.
  Future<List<ServerOrder>> listOrders() {
    return _client.get<List<ServerOrder>>(
      '/orders',
      fromJson: (json) => (json as List<dynamic>)
          .map((e) => ServerOrder.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
