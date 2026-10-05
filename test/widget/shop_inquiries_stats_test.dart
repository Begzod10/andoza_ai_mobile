import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tamir_uy_mobile_flutter/l10n/app_localizations.dart';
import 'package:tamir_uy_mobile_flutter/models/business_profile.dart';
import 'package:tamir_uy_mobile_flutter/providers/business_provider.dart';
import 'package:tamir_uy_mobile_flutter/repositories/business_repository.dart';
import 'package:tamir_uy_mobile_flutter/screens/business/shop_inquiries_screen.dart';
import 'package:tamir_uy_mobile_flutter/screens/business/shop_stats_screen.dart';

class _FakeRepo implements BusinessRepository {
  final calls = <String>[];

  ShopInquiry get _item => ShopInquiry(
    id: 'q1',
    status: LeadStatus.fresh,
    createdAt: DateTime(2026, 10, 5),
    clientName: 'Vali',
    clientPhone: '+998909998877',
    message: 'Narxi qancha?',
    productName: 'Divan Milano',
    roomName: 'Mehmonxona',
  );

  @override
  Future<List<ShopInquiry>> fetchInquiries() async => [_item];

  @override
  Future<ShopInquiry> setInquiryStatus(String id, LeadStatus status) async {
    calls.add('$id ${status.wire}');
    return _item;
  }

  @override
  Future<SellerStats> fetchStats() async => const SellerStats(
    productsTotal: 12,
    productsApproved: 9,
    productsPending: 2,
    productsRejected: 1,
    visible: 8,
    inquiriesTotal: 5,
    inquiriesNew: 3,
    placementsTotal: 41,
    topProducts: [TopProduct(id: 'p1', name: 'Divan Milano', placements: 17)],
  );

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnimplementedError('${invocation.memberName}');
}

Widget _app(_FakeRepo repo, Widget home) => ProviderScope(
  overrides: [businessRepositoryProvider.overrideWithValue(repo)],
  child: MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    locale: const Locale('uz'),
    home: home,
  ),
);

void main() {
  testWidgets(
    'inquiry inbox shows client, product and message, and can be closed',
    (tester) async {
      final repo = _FakeRepo();
      await tester.pumpWidget(_app(repo, const ShopInquiriesScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Mijoz murojaatlari'), findsOneWidget);
      expect(find.text('Vali'), findsOneWidget);
      expect(find.text('Yangi'), findsOneWidget);
      expect(find.text('Mahsulot: Divan Milano'), findsOneWidget);
      expect(find.text('Narxi qancha?'), findsOneWidget);

      await tester.tap(find.text('Yopish'));
      await tester.pumpAndSettle();
      expect(repo.calls, ['q1 closed']);
    },
  );

  testWidgets('stats screen shows the numbers and top products', (
    tester,
  ) async {
    await tester.pumpWidget(_app(_FakeRepo(), const ShopStatsScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Do\'kon statistikasi'), findsOneWidget);
    expect(find.text('12'), findsOneWidget);
    expect(find.text('41'), findsOneWidget);
    expect(find.text('Divan Milano'), findsOneWidget);
    expect(find.text('17'), findsOneWidget);
  });
}
