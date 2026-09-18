import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tamir_uy_mobile_flutter/l10n/app_localizations.dart';

/// Shared test harness for the l10n migration.
///
/// Wraps [child] in a [MaterialApp] configured with the app's
/// [AppLocalizations] delegates so `AppLocalizations.of(context)` resolves in
/// widget tests exactly as it does in `main.dart`. The Uzbek delegate loads
/// synchronously, so a single `await tester.pump()` / `pumpAndSettle()` after
/// pumping is enough for localized text to appear.
///
/// [withProviderScope] wraps the result in a [ProviderScope] (default). Tests
/// that need their own scope with provider overrides should pass
/// `withProviderScope: false` and supply their own [ProviderScope] around the
/// returned widget.
Widget wrapLocalized(Widget child, {bool withProviderScope = true}) {
  final app = MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    locale: const Locale('uz'),
    home: child,
  );
  return withProviderScope ? ProviderScope(child: app) : app;
}

/// Convenience: pump [child] through the localization delegates.
Future<void> pumpLocalized(
  WidgetTester tester,
  Widget child, {
  bool withProviderScope = true,
}) {
  return tester.pumpWidget(
    wrapLocalized(child, withProviderScope: withProviderScope),
  );
}
