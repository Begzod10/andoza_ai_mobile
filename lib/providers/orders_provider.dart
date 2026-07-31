import 'package:riverpod/riverpod.dart';
import '../models/shop_model.dart';

/// Session-local order history — real (not fabricated) entries appended
/// by s6_checkout_screen.dart each time a checkout completes, so E6
/// ("Buyurtmalarim") has genuine content instead of a permanently-empty
/// list. No backend `/orders` endpoint exists, same rationale as
/// cart_provider.dart.
class OrdersNotifier extends StateNotifier<List<ShopOrder>> {
  OrdersNotifier() : super(const []);

  void add(ShopOrder order) => state = [order, ...state];
}

final ordersProvider = StateNotifierProvider<OrdersNotifier, List<ShopOrder>>(
  (ref) => OrdersNotifier(),
);
