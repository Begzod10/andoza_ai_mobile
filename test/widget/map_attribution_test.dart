import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tamir_uy_mobile_flutter/l10n/app_localizations.dart';
import 'package:tamir_uy_mobile_flutter/providers/masters_provider.dart';
import 'package:tamir_uy_mobile_flutter/screens/masters/u1_masters_intro_screen.dart';

/// OSM's tile usage policy requires visible attribution on every map that
/// shows tile.openstreetmap.org tiles.
void main() {
  testWidgets('U1 map credits OpenStreetMap contributors', (tester) async {
    await tester.pumpWidget(ProviderScope(
      overrides: [
        mockMastersProvider.overrideWithValue(const []),
        mastersLoadingProvider.overrideWithValue(false),
        mastersLoadErrorProvider.overrideWithValue(null),
      ],
      child: const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale('en'),
        home: U1MastersIntroScreen(),
      ),
    ));
    await tester.pump();

    expect(find.text('© OpenStreetMap contributors'), findsOneWidget);
    expect(
      find.bySemanticsLabel('© OpenStreetMap contributors'),
      findsOneWidget,
    );
  });
}
