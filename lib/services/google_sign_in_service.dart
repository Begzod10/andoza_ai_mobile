import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../config/app_config.dart';

/// Thin wrapper over the `google_sign_in` plugin so the login screen only
/// sees "give me an ID token" and tests can swap it via
/// [googleSignInServiceProvider] without touching platform channels.
class GoogleSignInService {
  GoogleSignInService({GoogleSignIn? signIn})
      : _signIn = signIn ?? GoogleSignIn.instance;

  final GoogleSignIn _signIn;
  Future<void>? _init;

  /// Whether the button should be offered on this platform. iOS needs its own
  /// OAuth client id (plus the reversed-client-id URL scheme in
  /// ios/Runner/Info.plist); if that id is configured empty, the native SDK
  /// cannot start, so the option is hidden there instead of crashing.
  static bool get isAvailable =>
      isAvailableFor(defaultTargetPlatform, AppConfig.googleIosClientId);

  @visibleForTesting
  static bool isAvailableFor(TargetPlatform platform, String iosClientId) =>
      platform != TargetPlatform.iOS || iosClientId.isNotEmpty;

  Future<void> _ensureInitialized() => _init ??= _signIn.initialize(
        // serverClientId = the web client: the ID token's audience, which the
        // backend verifies. Required on Android to get an ID token at all.
        serverClientId: AppConfig.googleServerClientId,
        clientId: defaultTargetPlatform == TargetPlatform.iOS &&
                AppConfig.googleIosClientId.isNotEmpty
            ? AppConfig.googleIosClientId
            : null,
      );

  /// Runs the interactive Google sign-in and returns the ID token, or `null`
  /// when the user dismisses the account picker. Other failures throw.
  Future<String?> getIdToken() async {
    try {
      await _ensureInitialized();
    } catch (_) {
      // Let a later tap retry initialisation instead of caching the failure.
      _init = null;
      rethrow;
    }
    try {
      final account = await _signIn.authenticate();
      final idToken = account.authentication.idToken;
      // No ID token means a misconfigured client id, not a cancel — surface it
      // as a failure rather than silently doing nothing.
      if (idToken == null || idToken.isEmpty) {
        throw StateError('Google sign-in returned no ID token');
      }
      return idToken;
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) return null;
      rethrow;
    }
  }
}

final googleSignInServiceProvider =
    Provider<GoogleSignInService>((ref) => GoogleSignInService());
