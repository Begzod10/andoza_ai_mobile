import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:tamir_uy_mobile_flutter/models/user_model.dart';
import 'package:tamir_uy_mobile_flutter/providers/auth_provider.dart';
import 'package:tamir_uy_mobile_flutter/repositories/auth_repository.dart';

/// A fully in-memory AuthRepository: no ApiClient, no network. Each method is
/// scripted per-test so we can exercise the AuthNotifier state machine (login
/// success, the null-phone parsing regression, the error path, and the
/// handleUnauthorized guard) without touching real HTTP.
class _FakeAuthRepository implements AuthRepository {
  // ignore_for_file: prefer_initializing_formals
  _FakeAuthRepository({AuthResponse? loginResult, Object? loginError})
      : _loginResult = loginResult,
        _loginError = loginError;

  final AuthResponse? _loginResult;
  final Object? _loginError;

  @override
  String? token;

  @override
  Future<AuthResponse> login(String email, String password) async {
    if (_loginError != null) throw _loginError;
    return _loginResult!;
  }

  @override
  Future<void> requestOtp(String phone) async {}

  @override
  Future<AuthResponse> verifyOtp(String phone, String code) async =>
      _loginResult!;

  @override
  Future<AuthResponse> register(
          String username, String password, String? name) async =>
      _loginResult!;

  @override
  Future<void> logout() async {}

  @override
  Future<User?> getCurrentUser() async => _loginResult?.user;

  @override
  Future<void> restoreToken() async {}
}

/// Builds a container with the auth repository swapped for a fake.
ProviderContainer _container(AuthRepository repo) {
  final container = ProviderContainer(
    overrides: [authRepositoryProvider.overrideWithValue(repo)],
  );
  addTearDown(container.dispose);
  return container;
}

AuthResponse _response({String? phone, String token = 'tok-123'}) =>
    AuthResponse(
      token: token,
      refreshToken: 'refresh-abc',
      tokenType: 'bearer',
      user: User(id: 'u1', username: 'rimefara', name: 'Test User', phone: phone),
    );

void main() {
  group('AuthNotifier.login — success', () {
    test('successful login moves state to AuthAuthenticated with the user', () async {
      final container = _container(
        _FakeAuthRepository(loginResult: _response(phone: '998901234567')),
      );
      final notifier = container.read(authStateProvider.notifier);

      await notifier.login('rimefara', '12345678');

      final state = container.read(authStateProvider);
      expect(state, isA<AuthAuthenticated>());
      final authed = state as AuthAuthenticated;
      expect(authed.user.id, 'u1');
      expect(authed.user.username, 'rimefara');
      expect(authed.token, 'tok-123');
    });
  });

  group('AuthNotifier — null-phone regression (prior CastError)', () {
    test('a User with phone == null parses without crashing', () {
      // The original production crash was a CastError on json[phone] as String.
      // With phone nullable, parsing a phone-less (username/password) account
      // must succeed.
      final user = User.fromJson({
        'id': 'u1',
        'username': 'rimefara',
        'name': 'Test User',
        'phone': null,
      });
      expect(user.phone, isNull);
      expect(user.username, 'rimefara');
    });

    test('login with a phone==null user still reaches Authenticated cleanly',
        () async {
      final container = _container(
        _FakeAuthRepository(loginResult: _response(phone: null)),
      );
      final notifier = container.read(authStateProvider.notifier);

      await notifier.login('rimefara', '12345678');

      final state = container.read(authStateProvider);
      expect(state, isA<AuthAuthenticated>());
      expect((state as AuthAuthenticated).user.phone, isNull);
    });

    test('setSession with a phone==null user reaches Authenticated cleanly', () {
      final container = _container(_FakeAuthRepository());
      final notifier = container.read(authStateProvider.notifier);

      notifier.setSession(_response(phone: null));

      final state = container.read(authStateProvider);
      expect(state, isA<AuthAuthenticated>());
      expect((state as AuthAuthenticated).user.phone, isNull);
    });
  });

  group('AuthNotifier.login — failure path', () {
    test('repository throwing lands in AuthError (not stuck AuthLoading)',
        () async {
      final container = _container(
        _FakeAuthRepository(loginError: AuthException('Invalid credentials')),
      );
      final notifier = container.read(authStateProvider.notifier);

      await notifier.login('rimefara', 'wrong');

      final state = container.read(authStateProvider);
      expect(state, isA<AuthError>());
      expect((state as AuthError).message, contains('Invalid credentials'));
    });

    test('even a raw Error (e.g. a parse CastError) becomes AuthError', () async {
      // Guards the "catch Error too" behaviour: a malformed response must not
      // leave the login button spinning in AuthLoading forever.
      final container = _container(
        _FakeAuthRepository(loginError: TypeError()),
      );
      final notifier = container.read(authStateProvider.notifier);

      await notifier.login('rimefara', '12345678');

      expect(container.read(authStateProvider), isA<AuthError>());
    });
  });

  group('AuthNotifier.handleUnauthorized', () {
    test('when Authenticated, flips to an unauthenticated state', () async {
      final container = _container(
        _FakeAuthRepository(loginResult: _response(phone: '998901234567')),
      );
      final notifier = container.read(authStateProvider.notifier);
      await notifier.login('rimefara', '12345678');
      expect(container.read(authStateProvider), isA<AuthAuthenticated>());

      notifier.handleUnauthorized();

      expect(container.read(authStateProvider), isNot(isA<AuthAuthenticated>()));
      expect(container.read(authStateProvider), isA<AuthInitial>());
    });

    test('does not clobber a mid-login AuthLoading state', () {
      final container = _container(_FakeAuthRepository());
      final notifier = container.read(authStateProvider.notifier);
      // Kick off a login that never completes to leave state in AuthLoading.
      // ignore: unawaited_futures
      notifier.login('rimefara', '12345678');
      expect(container.read(authStateProvider), isA<AuthLoading>());

      notifier.handleUnauthorized();

      // Still loading — the in-flight login was not overwritten.
      expect(container.read(authStateProvider), isA<AuthLoading>());
    });

    test('is a no-op from AuthInitial', () {
      final container = _container(_FakeAuthRepository());
      final notifier = container.read(authStateProvider.notifier);
      expect(container.read(authStateProvider), isA<AuthInitial>());

      notifier.handleUnauthorized();

      expect(container.read(authStateProvider), isA<AuthInitial>());
    });
  });
}
