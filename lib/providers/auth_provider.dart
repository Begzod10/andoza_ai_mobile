import 'package:riverpod/riverpod.dart';
import '../config/app_config.dart';
import '../models/user_model.dart';
import '../repositories/auth_repository.dart';
import '../services/api_client.dart';
import '../services/secure_storage.dart';

// Secure Storage provider
final secureStorageProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService();
});

// API Client provider
// Explicit variable type: the onUnauthorized callback references
// authStateProvider, which transitively depends on this provider, so an
// explicit type is needed to break the top-level inference cycle.
final Provider<ApiClient> apiClientProvider = Provider<ApiClient>((ref) {
  final storage = ref.watch(secureStorageProvider);
  return ApiClient(
    baseUrl: AppConfig.apiUrl,
    // Drop to /login from one place when a request 401s with no usable refresh
    // token. Read lazily (not at build time) to avoid a circular provider
    // dependency — apiClient is a transitive dependency of authStateProvider.
    // ApiClient already excludes auth-path 401s (a failed login) from this.
    onUnauthorized: () {
      ref.read(authStateProvider.notifier).handleUnauthorized();
    },
    // Persist the rotated tokens after a silent refresh so a later app restart
    // restores a still-valid refresh token (the backend rotates it each time).
    onTokensRefreshed: (accessToken, refreshToken) async {
      await storage.saveToken(accessToken);
      if (refreshToken != null && refreshToken.isNotEmpty) {
        await storage.saveRefreshToken(refreshToken);
      }
    },
    // Drop the now-dead persisted tokens when a refresh fails.
    onTokensCleared: () async {
      await storage.deleteToken();
      await storage.deleteRefreshToken();
    },
  );
});

// Repository provider
final Provider<AuthRepository> authRepositoryProvider =
    Provider<AuthRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  final storage = ref.watch(secureStorageProvider);
  return AuthRepositoryImpl(apiClient, storage);
});

// Auth state provider
final StateNotifierProvider<AuthNotifier, AuthState> authStateProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthNotifier(repository);
});

// Current user provider
final currentUserProvider = FutureProvider.autoDispose<User?>((ref) async {
  final authState = ref.watch(authStateProvider);
  if (authState is! AuthAuthenticated) return null;
  final repository = ref.watch(authRepositoryProvider);
  return repository.getCurrentUser();
});

// Auth notifier for managing auth state
class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(this._repository) : super(const AuthInitial());

  final AuthRepository _repository;

  Future<void> login(String email, String password) async {
    state = const AuthLoading();
    try {
      final response = await _repository.login(email, password);
      state = AuthAuthenticated(user: response.user, token: response.token);
    } catch (e) {
      // Catch Error too (not just Exception): a malformed response can throw a
      // TypeError/CastError during parsing, which would otherwise leave the
      // state stuck in AuthLoading and hang the login button forever.
      state = AuthError(message: e.toString());
    }
  }

  /// Flip to authenticated from an already-completed auth call (OTP verify /
  /// register / password login done directly against the repository). The
  /// repository has persisted the tokens; this just drives the router redirect.
  void setSession(AuthResponse response) {
    state = AuthAuthenticated(user: response.user, token: response.token);
  }

  /// Called from the API layer when a request comes back 401 with no usable
  /// refresh token (the persisted tokens have already been wiped). Flipping to
  /// unauthenticated here lets the router redirect drop the user to /login from
  /// a single place. No-op unless currently authenticated, so it can't clobber
  /// an in-flight login's AuthLoading/AuthError.
  void handleUnauthorized() {
    if (state is AuthAuthenticated) {
      state = const AuthInitial();
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    state = const AuthInitial();
  }

  Future<void> checkAuth() async {
    try {
      final user = await _repository.getCurrentUser();
      if (user != null) {
        state = AuthAuthenticated(user: user, token: _repository.token ?? '');
      }
    } catch (_) {
      state = const AuthInitial();
    }
  }

  Future<void> restoreToken() async {
    try {
      await _repository.restoreToken();
      await checkAuth();
    } catch (_) {
      state = const AuthInitial();
    }
  }
}

sealed class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthAuthenticated extends AuthState {
  const AuthAuthenticated({required this.user, required this.token});

  final User user;
  final String token;
}

class AuthError extends AuthState {
  const AuthError({required this.message});

  final String message;
}
