import 'package:flutter_test/flutter_test.dart';
import 'package:tamir_uy_mobile_flutter/models/shop_model.dart';
import 'package:tamir_uy_mobile_flutter/providers/shop_provider.dart';

/// Without per-store offers from the server, the shop must only ever show the
/// store that actually listed the product, at its real price — it used to
/// invent "Qurilish Bozori" / "UzMall" with made-up prices that could be ordered.
void main() {
  const product = Product(
    id: 'm1',
    name: 'Laminat',
    brand: 'Leroy Merlin Tashkent',
    category: ShopCategory.laminat,
    pricePerUnit: 118000,
    unit: 'm2',
    isOfficialDealer: true,
    storeId: 'store-1',
  );

  test('fallback offers are just the product\'s own store at its price', () {
    final dealers = dealersForProduct(product);
    expect(dealers, hasLength(1));
    final d = dealers.single;
    expect(d.id, 'store-1');
    expect(d.name, 'Leroy Merlin Tashkent');
    expect(d.pricePerUnit, 118000);
    expect(d.isOfficial, isTrue);
    expect(d.deliveryDays, 0); // unknown — the UI leaves it out
  });

  test('no invented dealers or prices', () {
    final names = dealersForProduct(product).map((d) => d.name);
    expect(names, isNot(contains('Qurilish Bozori')));
    expect(names, isNot(contains('UzMall')));
    expect(bestDealer(dealersForProduct(product)).pricePerUnit, 118000);
  });

  test('a product without a store id still gets a stable dealer id', () {
    const p = Product(
      id: 'm2', name: 'X', brand: 'S', category: ShopCategory.boyoq,
      pricePerUnit: 1, unit: 'kg', isOfficialDealer: false,
    );
    expect(ownStoreDealer(p).id, 'm2');
  });
}
