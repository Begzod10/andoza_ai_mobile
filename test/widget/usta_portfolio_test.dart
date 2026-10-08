import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tamir_uy_mobile_flutter/l10n/app_localizations.dart';
import 'package:tamir_uy_mobile_flutter/models/business_profile.dart';
import 'package:tamir_uy_mobile_flutter/providers/business_provider.dart';
import 'package:tamir_uy_mobile_flutter/repositories/business_repository.dart';
import 'package:tamir_uy_mobile_flutter/screens/business/usta_portfolio_screen.dart';

class _FakeRepo implements BusinessRepository {
  _FakeRepo(this.items);
  List<PortfolioItem> items;
  final deleted = <String>[];

  @override
  Future<List<PortfolioItem>> fetchPortfolio() async => List.of(items);

  @override
  Future<void> deletePortfolioItem(String id) async {
    deleted.add(id);
    items = items.where((i) => i.id != id).toList();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError('${invocation.memberName}');
}

Widget _app(_FakeRepo repo) => ProviderScope(
      overrides: [businessRepositoryProvider.overrideWithValue(repo)],
      child: const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale('uz'),
        home: UstaPortfolioScreen(),
      ),
    );

void main() {
  testWidgets('shows photos and deletes one after confirmation', (tester) async {
    final repo = _FakeRepo([
      const PortfolioItem(id: 'p1', imageUrl: 'http://x.local/1.jpg', caption: 'Hammom'),
      const PortfolioItem(id: 'p2', imageUrl: 'http://x.local/2.jpg'),
    ]);
    await tester.pumpWidget(_app(repo));
    await tester.pumpAndSettle();

    expect(find.text('Hammom'), findsOneWidget);
    expect(find.byIcon(Icons.delete_outline), findsNWidgets(2));

    await tester.tap(find.byIcon(Icons.delete_outline).first);
    await tester.pumpAndSettle();
    expect(find.text("Rasm o'chirilsin? Buni qaytarib bo'lmaydi."), findsOneWidget);
    await tester.tap(find.text("O'chirish").last);
    await tester.pumpAndSettle();

    expect(repo.deleted, ['p1']);
    expect(find.byIcon(Icons.delete_outline), findsOneWidget);
  });

  testWidgets('empty state', (tester) async {
    await tester.pumpWidget(_app(_FakeRepo([])));
    await tester.pumpAndSettle();
    expect(find.text("Hali ish rasmlari yo'q. Bajargan ishlaringizni qo'shing."), findsOneWidget);
  });
}
