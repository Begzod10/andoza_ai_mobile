import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tamir_uy_mobile_flutter/l10n/app_localizations.dart';
import 'package:tamir_uy_mobile_flutter/models/business_profile.dart';
import 'package:tamir_uy_mobile_flutter/providers/business_provider.dart';
import 'package:tamir_uy_mobile_flutter/repositories/business_repository.dart';
import 'package:tamir_uy_mobile_flutter/screens/business/shop_products_screen.dart';

class _FakeRepo implements BusinessRepository {
  final calls = <String>[];
  List<ShopProduct> items = const [
    ShopProduct(
        id: 'a', name: 'Divan Milano', category: 'divan', priceUzs: 4500000,
        status: ModerationStatus.approved, isActive: true),
    ShopProduct(
        id: 'b', name: 'Stol', category: 'stol',
        status: ModerationStatus.rejected, isActive: false, moderationNote: 'Sifatsiz'),
  ];

  @override
  Future<List<ShopProduct>> fetchProducts() async => items;

  @override
  Future<ShopProduct> updateProduct(String id, {String? name, int? priceUzs, bool? isActive}) async {
    calls.add('update $id active=$isActive');
    return items.first;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError('${invocation.memberName}');
}

void main() {
  testWidgets('lists products with status; only approved ones have a visibility switch', (tester) async {
    final repo = _FakeRepo();
    await tester.pumpWidget(ProviderScope(
      overrides: [businessRepositoryProvider.overrideWithValue(repo)],
      child: const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale('uz'),
        home: ShopProductsScreen(),
      ),
    ));
    await tester.pumpAndSettle();

    expect(find.text('Divan Milano'), findsOneWidget);
    expect(find.text('4 500 000 so\'m'), findsOneWidget);
    expect(find.text('Tasdiqlangan'), findsOneWidget);
    expect(find.byType(Switch), findsOneWidget);

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();
    expect(repo.calls, ['update a active=false']);
  });
}
