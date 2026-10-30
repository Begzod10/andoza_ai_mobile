import 'dart:ui' show PlatformDispatcher;

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

/// The supported language matching [system] (the phone's first language),
/// else Uzbek.
Locale appLocaleFor(Locale system) => supportedAppLocales.firstWhere(
      (l) => l.languageCode == system.languageCode,
      orElse: () => supportedAppLocales.first,
    );

/// The app language: the one the user picked, else the phone's when the app
/// has it, else Uzbek.
final localeProvider = NotifierProvider<LocaleNotifier, Locale>(
  LocaleNotifier.new,
);

class LocaleNotifier extends Notifier<Locale> {
  /// True once the user has picked a language, now or in an earlier session.
  /// Until then the app follows the phone, and that is not saved anywhere.
  bool chosen = false;

  @override
  Locale build() {
    // The phone's language until the persisted choice (if any) loads.
    _loadPersisted();
    return appLocaleFor(PlatformDispatcher.instance.locale);
  }

  Future<void> _loadPersisted() async {
    final SharedPreferences prefs;
    try {
      prefs = await SharedPreferences.getInstance();
    } catch (_) {
      return; // No storage (e.g. a plain Dart test): stay on the phone's.
    }
    final code = prefs.getString(_prefsKeyLocale);
    final match = supportedAppLocales.where((l) => l.languageCode == code);
    if (match.isNotEmpty && !chosen) {
      chosen = true;
      state = match.first;
    }
  }

  Future<void> setLocale(Locale locale) async {
    chosen = true;
    state = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKeyLocale, locale.languageCode);
  }
}
