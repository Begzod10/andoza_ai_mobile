import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _prefsKeyLocale = 'app_locale';

/// The three languages the app ships with. Order here drives the language
/// picker's display order.
const supportedAppLocales = [
  Locale('uz'),
  Locale('ru'),
  Locale('en'),
];

/// The user's selected app language. Null means "follow system" until the
/// first load completes; [LocaleNotifier] then resolves and persists a
/// concrete locale so the app always has an explicit choice after that.
final localeProvider = NotifierProvider<LocaleNotifier, Locale>(
  LocaleNotifier.new,
);

class LocaleNotifier extends Notifier<Locale> {
  @override
  Locale build() {
    // Default to Uzbek until the persisted preference (if any) loads.
    _loadPersisted();
    return supportedAppLocales.first;
  }

  Future<void> _loadPersisted() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_prefsKeyLocale);
    final match = supportedAppLocales.where((l) => l.languageCode == code);
    if (match.isNotEmpty) {
      state = match.first;
    }
  }

  Future<void> setLocale(Locale locale) async {
    state = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKeyLocale, locale.languageCode);
  }
}
