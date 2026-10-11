import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tamir_uy_mobile_flutter/models/user_model.dart';
import 'package:tamir_uy_mobile_flutter/providers/auth_provider.dart';
import 'package:tamir_uy_mobile_flutter/repositories/auth_repository.dart';
import 'package:tamir_uy_mobile_flutter/screens/auth/login_screen.dart';
import 'package:tamir_uy_mobile_flutter/services/api_client.dart';
import 'package:tamir_uy_mobile_flutter/services/google_sign_in_service.dart';
import 'package:tamir_uy_mobile_flutter/utils/error_mapper.dart';

import '../support/localized_pump.dart';

class _FakeGoogle implements GoogleSignInService {
  _FakeGoogle(this.token);
  final String? token;
  int calls = 0;

  @override
  Future<String?> getIdToken() async {
    calls++;
    return token;
  }
}

class _FakeRepo implements AuthRepository {
  _FakeRepo({this.error});
  final Object? error;
  final googleTokens = <String>[];

  @override
  Future<AuthResponse> loginWithGoogle(String idToken) async {
    googleTokens.add(idToken);
    if (error != null) throw error!;
    return const AuthResponse(token: 'acc', user: User(id: 'u1'));
  }

  @override
  dynamic noSuchMethod(Invocation i) => null;
}

const _googleLabel = 'Google bilan kirish';

void main() {
  Future<ProviderContainer> pump(
    WidgetTester tester,
    _FakeGoogle google,
    _FakeRepo repo,
  ) async {
    await tester.pumpWidget(ProviderScope(
      overrides: [
        googleSignInServiceProvider.overrideWithValue(google),
        authRepositoryProvider.overrideWithValue(repo),
      ],
      child: wrapLocalized(const LoginScreen(), withProviderScope: false),
    ));
    await tester.pumpAndSettle();
    return ProviderScope.containerOf(tester.element(find.byType(LoginScreen)));
  }

  Future<void> tapGoogle(WidgetTester tester) async {
    final button = find.widgetWithText(OutlinedButton, _googleLabel);
    await tester.ensureVisible(button);
    await tester.pumpAndSettle();
    await tester.tap(button);
    await tester.pumpAndSettle();
  }

  testWidgets('Google button with an "yoki" divider is shown on Android',
      (tester) async {
    await pump(tester, _FakeGoogle(null), _FakeRepo());
    expect(find.widgetWithText(OutlinedButton, _googleLabel), findsOneWidget);
    expect(find.text('yoki'), findsOneWidget);

    // …and on the register view too.
    final register = find.text("Ro'yxatdan o'tish");
    await tester.ensureVisible(register);
    await tester.pumpAndSettle();
    await tester.tap(register);
    await tester.pumpAndSettle();
    expect(find.widgetWithText(OutlinedButton, _googleLabel), findsOneWidget);
  });

  testWidgets('shown on iOS now that the iOS client id is configured',
      (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    try {
      await pump(tester, _FakeGoogle(null), _FakeRepo());
      expect(find.widgetWithText(OutlinedButton, _googleLabel), findsOneWidget);
    } finally {
      debugDefaultTargetPlatformOverride = null;
    }
  });

  test('hidden on iOS only when the iOS client id is empty', () {
    expect(GoogleSignInService.isAvailableFor(TargetPlatform.iOS, ''), isFalse);
    expect(GoogleSignInService.isAvailableFor(TargetPlatform.iOS, 'x'), isTrue);
    expect(
        GoogleSignInService.isAvailableFor(TargetPlatform.android, ''), isTrue);
  });

  testWidgets('cancelling the picker makes no API call and no error',
      (tester) async {
    final google = _FakeGoogle(null);
    final repo = _FakeRepo();
    final container = await pump(tester, google, repo);

    await tapGoogle(tester);

    expect(google.calls, 1);
    expect(repo.googleTokens, isEmpty);
    expect(container.read(authStateProvider), isA<AuthInitial>());
    expect(find.text("Google orqali kirib bo'lmadi. Qayta urinib ko'ring."),
        findsNothing);
  });

  testWidgets('a token is exchanged and the session is set', (tester) async {
    final repo = _FakeRepo();
    final container = await pump(tester, _FakeGoogle('id-tok'), repo);

    await tapGoogle(tester);

    expect(repo.googleTokens, ['id-tok']);
    final state = container.read(authStateProvider);
    expect(state, isA<AuthAuthenticated>());
    expect((state as AuthAuthenticated).token, 'acc');
  });

  testWidgets('a rejected token (401) shows the Google failure text',
      (tester) async {
    final repo = _FakeRepo(
        error: AuthException('Google tokeni yaroqsiz', statusCode: 401));
    final container = await pump(tester, _FakeGoogle('bad'), repo);

    await tapGoogle(tester);

    expect(find.text("Google orqali kirib bo'lmadi. Qayta urinib ko'ring."),
        findsOneWidget);
    expect(container.read(authStateProvider), isNot(isA<AuthAuthenticated>()));
    // Busy state cleared: the button is enabled again.
    final button = tester.widget<OutlinedButton>(
        find.widgetWithText(OutlinedButton, _googleLabel));
    expect(button.onPressed, isNotNull);
  });

  testWidgets('a server failure (503) uses the shared error mapping',
      (tester) async {
    final repo =
        _FakeRepo(error: AuthException('not configured', statusCode: 503));
    await pump(tester, _FakeGoogle('tok'), repo);

    await tapGoogle(tester);

    expect(
      find.text(mapErrorToMessage(
          ApiException(message: 'not configured', statusCode: 503))),
      findsOneWidget,
    );
  });
}
