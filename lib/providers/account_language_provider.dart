import 'dart:ui' show Locale;

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_provider.dart';
import 'locale_provider.dart';

/// Keep-alive: saves the language the user picked in the app on their account
/// (`PATCH /auth/me`), so the web Studio, emails and the server side follow
/// it. Runs when the language changes while signed in, and on sign-in. The
/// phone's language is not saved until the user picks one themselves.
final accountLanguageSyncProvider = Provider<void>((ref) {
  void save() {
    if (ref.read(authStateProvider) is! AuthAuthenticated) return;
    if (!ref.read(localeProvider.notifier).chosen) return;
    final language = ref.read(localeProvider).languageCode;
    ref
        .read(apiClientProvider)
        .patch<void>('/auth/me', data: {'language': language}, fromJson: (_) {})
        .catchError((Object e) => debugPrint('Account language save failed: $e'));
  }

  ref.listen<Locale>(localeProvider, (prev, next) {
    if (prev?.languageCode != next.languageCode) save();
  });
  ref.listen<AuthState>(authStateProvider, (prev, next) {
    if (next is AuthAuthenticated && prev is! AuthAuthenticated) save();
  });
});
