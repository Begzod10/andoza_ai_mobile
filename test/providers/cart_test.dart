import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:tamir_uy_mobile_flutter/models/shop_model.dart';
import 'package:tamir_uy_mobile_flutter/providers/cart_provider.dart';

/// Cart is money-critical: it drives the S5 cart-total math and S6 checkout.
/// These tests lock in the delivery-fee tiers, the materials/grand-total sums,
/// per-dealer grouping, and the add/updateQuantity/remove aggregation rules
/// with real numbers so a regression in the pricing math can't slip through.

Product _product({
  required String id,
  String name = 'Mahsulot',
  ShopCategory category = ShopCategory.boyoq,
  int pricePerUnit = 10000,
  bool official = true,
}) =>
    Product(
      id: id,
      name: name,
      brand: 'Brand',
      category: category,
      pricePerUnit: pricePerUnit,
      unit: 'kg',
      isOfficialDealer: official,
    );

Dealer _dealer({
  required String id,
  String name = 'Dealer',
  bool official = true,
  int pricePerUnit = 10000,
  int deliveryDays = 2,
}) =>
    Dealer(
      id: id,
      name: name,
      isOfficial: official,
      district: 'Chilonzor',
      deliveryDays: deliveryDays,
      pricePerUnit: pricePerUnit,
    );

void main() {
  group('deliveryFeeFor — official vs non-official tiers', () {
    test('an official dealer is charged the 15000 tier', () {
      expect(deliveryFeeFor(_dealer(id: 'd1', official: true)), 15000);
    });

    test('a non-official dealer is charged the 25000 tier', () {
      expect(deliveryFeeFor(_dealer(id: 'd2', official: false)), 25000);
    });

    test('the two tiers are distinct (official is the cheaper one)', () {
      final official = deliveryFeeFor(_dealer(id: 'a', official: true));
      final nonOfficial = deliveryFeeFor(_dealer(id: 'b', official: false));
      expect(official, lessThan(nonOfficial));
    });
  });

  group('cartMaterialsTotal — line-total subtotal', () {
    test('sums lineTotal (dealer price * quantity) across lines', () {
      final lines = [
        CartLine(
          product: _product(id: 'p1'),
          dealer: _dealer(id: 'd1', pricePerUnit: 12000),
          quantity: 3,
        ),
        CartLine(
          product: _product(id: 'p2'),
          dealer: _dealer(id: 'd1', pricePerUnit: 5000),
          quantity: 2,
        ),
      ];
      // 12000*3 + 5000*2 = 36000 + 10000 = 46000
      expect(cartMaterialsTotal(lines), 46000);
    });

    test('a fractional quantity rounds per line, then sums', () {
      final lines = [
        CartLine(
          product: _product(id: 'p1'),
          dealer: _dealer(id: 'd1', pricePerUnit: 10000),
          quantity: 2.5,
        ),
      ];
      // 10000 * 2.5 = 25000
      expect(cartMaterialsTotal(lines), 25000);
    });

    test('an empty cart totals zero', () {
      expect(cartMaterialsTotal(const []), 0);
    });
  });

  group('grand total — materials subtotal + per-dealer delivery fees', () {
    test('single dealer: grand total == subtotal + one delivery fee', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final notifier = container.read(cartProvider.notifier);

      final dealer = _dealer(id: 'd1', official: true, pricePerUnit: 8000);
      notifier.add(_product(id: 'p1'), dealer, quantity: 4); // 32000

      final grouped = container.read(cartByDealerProvider);
      final subtotal = cartMaterialsTotal(container.read(cartProvider));
      final deliveryTotal =
          grouped.keys.fold<int>(0, (s, d) => s + deliveryFeeFor(d));
      final grand = subtotal + deliveryTotal;

      expect(subtotal, 32000);
      expect(deliveryTotal, 15000); // one official dealer
      expect(grand, 47000);
    });

    test('two dealers: each dealer block adds its own delivery fee', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final notifier = container.read(cartProvider.notifier);

      final official = _dealer(id: 'd1', official: true, pricePerUnit: 10000);
      final nonOfficial =
          _dealer(id: 'd2', official: false, pricePerUnit: 20000);
      notifier.add(_product(id: 'p1'), official, quantity: 2); // 20000
      notifier.add(_product(id: 'p2'), nonOfficial, quantity: 1); // 20000

      final grouped = container.read(cartByDealerProvider);
      final subtotal = cartMaterialsTotal(container.read(cartProvider));
      final deliveryTotal =
          grouped.keys.fold<int>(0, (s, d) => s + deliveryFeeFor(d));

      expect(grouped.length, 2);
      expect(subtotal, 40000);
      expect(deliveryTotal, 15000 + 25000); // 40000
      expect(subtotal + deliveryTotal, 80000);
    });
  });

  group('cartByDealerProvider — grouping by dealer', () {
    test('lines from the same dealer land in one group', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final notifier = container.read(cartProvider.notifier);

      final dealer = _dealer(id: 'd1');
      notifier.add(_product(id: 'p1'), dealer);
      notifier.add(_product(id: 'p2'), dealer);

      final grouped = container.read(cartByDealerProvider);
      expect(grouped.length, 1);
      expect(grouped[dealer]!.length, 2);
    });
  });

  group('CartNotifier — add / updateQuantity / remove', () {
    test('adding the same product+dealer aggregates quantity, not lines', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final notifier = container.read(cartProvider.notifier);

      final dealer = _dealer(id: 'd1', pricePerUnit: 5000);
      notifier.add(_product(id: 'p1'), dealer, quantity: 2);
      notifier.add(_product(id: 'p1'), dealer, quantity: 3);

      final lines = container.read(cartProvider);
      expect(lines.length, 1);
      expect(lines.single.quantity, 5);
      // Total recomputes: 5000 * 5 = 25000
      expect(cartMaterialsTotal(lines), 25000);
    });

    test('same product from a different dealer is a distinct line', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final notifier = container.read(cartProvider.notifier);

      notifier.add(_product(id: 'p1'), _dealer(id: 'd1'));
      notifier.add(_product(id: 'p1'), _dealer(id: 'd2'));

      expect(container.read(cartProvider).length, 2);
    });

    test('updateQuantity sets the exact quantity and recomputes total', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final notifier = container.read(cartProvider.notifier);

      final dealer = _dealer(id: 'd1', pricePerUnit: 7000);
      notifier.add(_product(id: 'p1'), dealer, quantity: 1);
      notifier.updateQuantity('p1', 'd1', 4);

      final lines = container.read(cartProvider);
      expect(lines.single.quantity, 4);
      expect(cartMaterialsTotal(lines), 28000);
    });

    test('updateQuantity to zero removes the line', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final notifier = container.read(cartProvider.notifier);

      notifier.add(_product(id: 'p1'), _dealer(id: 'd1'));
      notifier.updateQuantity('p1', 'd1', 0);

      expect(container.read(cartProvider), isEmpty);
    });

    test('remove drops the matching line and empties the group', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final notifier = container.read(cartProvider.notifier);

      final dealer = _dealer(id: 'd1');
      notifier.add(_product(id: 'p1'), dealer);
      expect(container.read(cartLineCountProvider), 1);

      notifier.remove('p1', 'd1');

      expect(container.read(cartProvider), isEmpty);
      expect(container.read(cartLineCountProvider), 0);
      expect(container.read(cartByDealerProvider), isEmpty);
    });

    test('cartLineCountProvider counts distinct lines, not units', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final notifier = container.read(cartProvider.notifier);

      final dealer = _dealer(id: 'd1');
      notifier.add(_product(id: 'p1'), dealer, quantity: 10);
      notifier.add(_product(id: 'p2'), dealer, quantity: 1);

      expect(container.read(cartLineCountProvider), 2);
    });
  });
}
