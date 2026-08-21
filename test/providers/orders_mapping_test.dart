import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:tamir_uy_mobile_flutter/models/api/api.dart';
import 'package:tamir_uy_mobile_flutter/models/shop_model.dart';
import 'package:tamir_uy_mobile_flutter/providers/orders_provider.dart';
import 'package:tamir_uy_mobile_flutter/repositories/orders_repository.dart';
import 'package:tamir_uy_mobile_flutter/services/api_client.dart';

/// A repository that returns a fixed order list without any HTTP. It extends
/// the real [OrdersRepository] (passing a throwaway client that is never
/// exercised) and overrides only [listOrders].
class _FakeOrdersRepository extends OrdersRepository {
  _FakeOrdersRepository(this._orders) : super(ApiClient(baseUrl: 'http://x'));

  final List<ServerOrder> _orders;

  @override
  Future<List<ServerOrder>> listOrders() async => _orders;
}

ServerOrder _serverOrder({
  required String id,
  OrderStatus status = OrderStatus.accepted,
  int total = 100000,
  String dealerName = 'Qurilish Bozori',
  List<ServerOrderLine> lines = const [],
}) =>
    ServerOrder(
      id: id,
      userId: 'user-1',
      dealerName: dealerName,
      totalUzs: total,
      status: status,
      createdAt: DateTime(2026, 6, 1),
      lines: lines,
    );

ShopOrder _localOrder(String id) => ShopOrder(
      id: id,
      lines: const [],
      total: 50000,
      currentStep: OrderStep.accepted,
      dealerName: 'Local dealer',
      createdAt: DateTime(2026, 7, 1),
    );

Future<ProviderContainer> _container(
  List<ServerOrder> server, {
  List<ShopOrder> local = const [],
}) async {
  final container = ProviderContainer(
    overrides: [
      ordersRepositoryProvider
          .overrideWithValue(_FakeOrdersRepository(server)),
    ],
  );
  addTearDown(container.dispose);
  for (final o in local) {
    container.read(ordersProvider.notifier).add(o);
  }
  return container;
}

void main() {
  group('serverOrdersProvider — ServerOrder → ShopOrder mapping', () {
    test('maps id, total, dealer, createdAt and lines', () async {
      final container = await _container([
        _serverOrder(
          id: 'o1',
          total: 495000,
          dealerName: 'UzMall',
          lines: const [
            ServerOrderLine(
              id: 'l1',
              productName: 'Tikkurila Euro 3',
              unit: 'litr',
              unitPriceUzs: 45000,
              quantity: 11,
            ),
          ],
        ),
      ]);
      final orders = await container.read(serverOrdersProvider.future);
      final o = orders.single;
      expect(o.id, 'o1');
      expect(o.total, 495000);
      expect(o.dealerName, 'UzMall');
      expect(o.createdAt, DateTime(2026, 6, 1));
      final line = o.lines.single;
      expect(line.product.name, 'Tikkurila Euro 3');
      expect(line.product.unit, 'litr');
      expect(line.product.pricePerUnit, 45000);
      expect(line.quantity, 11.0);
    });

    test('status maps onto the matching OrderStep', () async {
      final container = await _container([
        _serverOrder(id: 'a', status: OrderStatus.accepted),
        _serverOrder(id: 'g', status: OrderStatus.gathering),
        _serverOrder(id: 'w', status: OrderStatus.onTheWay),
        _serverOrder(id: 'd', status: OrderStatus.delivered),
      ]);
      final orders = await container.read(serverOrdersProvider.future);
      final byId = {for (final o in orders) o.id: o.currentStep};
      expect(byId['a'], OrderStep.accepted);
      expect(byId['g'], OrderStep.gathering);
      expect(byId['w'], OrderStep.onTheWay);
      expect(byId['d'], OrderStep.delivered);
    });
  });

  group('serverOrdersProvider — local/server dedup', () {
    test('a local optimistic order not on the server is kept (after server)',
        () async {
      final container = await _container(
        [_serverOrder(id: 'srv-1')],
        local: [_localOrder('local-1')],
      );
      final orders = await container.read(serverOrdersProvider.future);
      expect(orders.map((o) => o.id), ['srv-1', 'local-1']);
    });

    test('a local order whose id now exists on the server is dropped',
        () async {
      final container = await _container(
        [_serverOrder(id: 'dup')],
        local: [_localOrder('dup')],
      );
      final orders = await container.read(serverOrdersProvider.future);
      expect(orders, hasLength(1));
      // Server wins: the kept order carries the server dealer name.
      expect(orders.single.dealerName, 'Qurilish Bozori');
    });
  });
}
