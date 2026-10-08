import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tamir_uy_mobile_flutter/l10n/app_localizations.dart';
import 'package:tamir_uy_mobile_flutter/models/business_profile.dart';
import 'package:tamir_uy_mobile_flutter/providers/business_provider.dart';
import 'package:tamir_uy_mobile_flutter/repositories/business_repository.dart';
import 'package:tamir_uy_mobile_flutter/screens/business/usta_leads_screen.dart';

class _FakeRepo implements BusinessRepository {
  final calls = <String>[];

  @override
  Future<List<UstaLead>> fetchLeads() async => [
        UstaLead(
          id: 'l1',
          status: LeadStatus.fresh,
          createdAt: DateTime(2026, 10, 5),
          clientName: 'Vali',
          clientPhone: '+998909998877',
          roomName: 'Mehmonxona',
          totalUzs: 5000000,
          linesCount: 4,
          message: 'Ertaga soat 10 da kelsangiz bo\'ladi',
        ),
      ];

  @override
  Future<UstaLead> setLeadStatus(String id, LeadStatus status) async {
    calls.add('$id ${status.wire}');
    return (await fetchLeads()).first;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError('${invocation.memberName}');
}

void main() {
  testWidgets('inbox shows the client and estimate, and a request can be closed', (tester) async {
    final repo = _FakeRepo();
    await tester.pumpWidget(ProviderScope(
      overrides: [businessRepositoryProvider.overrideWithValue(repo)],
      child: const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale('uz'),
        home: UstaLeadsScreen(),
      ),
    ));
    await tester.pumpAndSettle();

    expect(find.text('Vali'), findsOneWidget);
    expect(find.text('Yangi'), findsOneWidget);
    expect(find.text("Smeta: 5 000 000 so'm (4 ta qator)"), findsOneWidget);

    expect(find.text("Mijoz xabari: Ertaga soat 10 da kelsangiz bo'ladi"), findsOneWidget);

    await tester.tap(find.text('Yopish'));
    await tester.pumpAndSettle();
    expect(repo.calls, ['l1 closed']);
  });
}
