import 'package:riverpod/riverpod.dart';

import '../models/api/api.dart';
import '../models/shop_model.dart';
import '../repositories/orders_repository.dart';
import 'auth_provider.dart';

/// Session-local order history — optimistic entries appended by
/// s6_checkout_screen.dart the moment a checkout completes, so S7 and E6
/// ("Buyurtmalarim") have content immediately even if the server POST is
/// still in flight or fails. Merged with the authoritative server list by
/// [serverOrdersProvider] (server wins by id).
class OrdersNotifier extends StateNotifier<List<ShopOrder>> {
  OrdersNotifier() : super(const []);

  void add(ShopOrder order) => state = [order, ...state];

  /// Drop a local optimistic order once its server-persisted counterpart is
  /// available, so the merged history in [serverOrdersProvider] doesn't show
  /// the same order twice (local id vs server UUID).
  void remove(String id) =>
      state = state.where((o) => o.id != id).toList();
}

final ordersProvider = StateNotifierProvider<OrdersNotifier, List<ShopOrder>>(
  (ref) => OrdersNotifier(),
);

/// Backend-aligned orders repository (`/orders`).
final ordersRepositoryProvider = Provider<OrdersRepository>((ref) {
  return OrdersRepository(ref.watch(apiClientProvider));
});

/// The merged order history the UI renders: the user's real backend orders
/// ([OrdersRepository.listOrders]) mapped to [ShopOrder]s, plus any local
/// optimistic ([ordersProvider]) orders not yet present on the server. Dedup
/// is by `id` with the server winning, mirroring the Home tab's
/// `projectsProvider` merge. Invalidate this provider to refetch after a
/// checkout POST completes.
final serverOrdersProvider = FutureProvider<List<ShopOrder>>((ref) async {
  final localOrders = ref.watch(ordersProvider);
  final server = await ref.watch(ordersRepositoryProvider).listOrders();
  final serverOrders = server.map(_serverOrderToShopOrder).toList();
  final serverIds = serverOrders.map((o) => o.id).toSet();
  final localOnly =
      localOrders.where((o) => !serverIds.contains(o.id)).toList();
  return [...serverOrders, ...localOnly];
});

/// Maps a backend [ServerOrder] to the UI's [ShopOrder]. Each server line is
/// turned into a minimal [CartLine] — a synthetic [Product] carrying the
/// stored name/unit/price (category defaults to [ShopCategory.boyoq], which
/// the E6/S7 cards don't key off), and a minimal [Dealer] named after the
/// order's dealer.
ShopOrder _serverOrderToShopOrder(ServerOrder o) => ShopOrder(
  id: o.id,
  lines: o.lines.map((l) => _serverLineToCartLine(l, o.dealerName)).toList(),
  total: o.totalUzs,
  currentStep: _statusToStep(o.status),
  dealerName: o.dealerName,
  createdAt: o.createdAt,
);

CartLine _serverLineToCartLine(ServerOrderLine l, String dealerName) {
  final product = Product(
    id: l.materialId ?? l.id,
    name: l.productName,
    brand: dealerName,
    category: ShopCategory.boyoq,
    pricePerUnit: l.unitPriceUzs,
    unit: l.unit,
    isOfficialDealer: false,
  );
  final dealer = Dealer(
    id: dealerName,
    name: dealerName,
    isOfficial: false,
    district: '',
    deliveryDays: 0,
    pricePerUnit: l.unitPriceUzs,
  );
  return CartLine(
    product: product,
    dealer: dealer,
    quantity: l.quantity.toDouble(),
  );
}

OrderStep _statusToStep(OrderStatus status) => switch (status) {
  OrderStatus.accepted => OrderStep.accepted,
  OrderStatus.gathering => OrderStep.gathering,
  OrderStatus.onTheWay => OrderStep.onTheWay,
  OrderStatus.delivered => OrderStep.delivered,
};
