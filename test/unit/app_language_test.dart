import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' show Locale;

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tamir_uy_mobile_flutter/models/user_model.dart';
import 'package:tamir_uy_mobile_flutter/providers/account_language_provider.dart';
import 'package:tamir_uy_mobile_flutter/providers/auth_provider.dart';
import 'package:tamir_uy_mobile_flutter/providers/locale_provider.dart';
import 'package:tamir_uy_mobile_flutter/repositories/auth_repository.dart';
import 'package:tamir_uy_mobile_flutter/repositories/push_repository.dart';
import 'package:tamir_uy_mobile_flutter/services/api_client.dart';
import 'package:tamir_uy_mobile_flutter/services/push_service.dart';

/// Records every request and answers 200 with an empty JSON object.
class _RecordingAdapter implements HttpClientAdapter {
  final requests = <RequestOptions>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    return ResponseBody.fromString(
      jsonEncode(<String, Object>{}),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

class _NoRepo implements AuthRepository {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Messaging implements MessagingClient {
  @override
  Future<String?> getToken() async => 'tok-1';
  @override
  Stream<String> get onTokenRefresh => const Stream.empty();
  @override
  Future<void> deleteToken() async {}
}

class _PushRepo implements PushRepository {
  final registered = <String>[];
  @override
  Future<void> register(String token, String platform, String locale) async =>
      registered.add(locale);
  @override
  Future<void> unregister(String token) async {}
}

const _session = AuthResponse(token: 't', user: User(id: 'u1'));

Future<void> _settle() => Future<void>.delayed(const Duration(milliseconds: 10));

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late _RecordingAdapter adapter;
  late _PushRepo pushRepo;

  ProviderContainer container() {
    adapter = _RecordingAdapter();
    pushRepo = _PushRepo();
    final c = ProviderContainer(overrides: [
      apiClientProvider.overrideWith((ref) {
        final client = ApiClient(
          baseUrl: 'http://test.local/api/v1',
          language: () => ref.read(localeProvider).languageCode,
        );
        client.httpDioForTest.httpClientAdapter = adapter;
        return client;
      }),
      authRepositoryProvider.overrideWithValue(_NoRepo()),
      pushServiceProvider.overrideWithValue(
        PushService(_Messaging(), pushRepo, locale: () => 'x', platform: 'ios'),
      ),
    ]);
    addTearDown(c.dispose);
    return c;
  }

  List<Object?> accountSaves() => adapter.requests
      .where((r) => r.method == 'PATCH' && r.path == '/auth/me')
      .map((r) => r.data)
      .toList();

  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('the phone language is used when the app has it, else Uzbek', () {
    expect(appLocaleFor(const Locale('ru', 'RU')), const Locale('ru'));
    expect(appLocaleFor(const Locale('en', 'US')), const Locale('en'));
    expect(appLocaleFor(const Locale('de')), const Locale('uz'));
  });

  test('every request carries the current language as Accept-Language', () async {
    final c = container();
    final api = c.read(apiClientProvider);
    await c.read(localeProvider.notifier).setLocale(const Locale('ru'));
    await api.get<void>('/stores', fromJson: (_) {});
    await c.read(localeProvider.notifier).setLocale(const Locale('en'));
    await api.get<void>('/stores', fromJson: (_) {});
    expect(adapter.requests.map((r) => r.headers['Accept-Language']), ['ru', 'en']);
  });

  test('a language picked while signed in is saved on the account', () async {
    final c = container();
    c.read(accountLanguageSyncProvider);
    c.read(authStateProvider.notifier).setSession(_session);
    await _settle();
    expect(accountSaves(), isEmpty, reason: 'the phone language is not a choice');

    await c.read(localeProvider.notifier).setLocale(const Locale('ru'));
    await _settle();
    expect(accountSaves(), [
      {'language': 'ru'},
    ]);
  });

  test('a language picked before signing in is saved at sign-in', () async {
    SharedPreferences.setMockInitialValues({'app_locale': 'en'});
    final c = container();
    c.read(accountLanguageSyncProvider);
    c.read(localeProvider);
    await _settle(); // the persisted choice loads
    expect(accountSaves(), isEmpty, reason: 'nobody is signed in yet');

    c.read(authStateProvider.notifier).setSession(_session);
    await _settle();
    expect(accountSaves(), [
      {'language': 'en'},
    ]);
  });

  test('a language change registers the push token again', () async {
    final c = container();
    c.read(pushRegistrationProvider);
    c.read(authStateProvider.notifier).setSession(_session);
    await _settle();
    expect(pushRepo.registered, hasLength(1));

    await c.read(localeProvider.notifier).setLocale(const Locale('ru'));
    await _settle();
    expect(pushRepo.registered, hasLength(2));
  });
}
