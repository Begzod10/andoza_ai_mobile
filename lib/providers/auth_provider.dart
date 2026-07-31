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
final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(baseUrl: AppConfig.apiUrl);
});

// Repository provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  final storage = ref.watch(secureStorageProvider);
  return AuthRepositoryImpl(apiClient, storage);
});

// Auth state provider
final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthNotifier(repository);
});

// Current user provider
final currentUserProvider = FutureProvider<User?>((ref) async {
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
    } on Exception catch (e) {
      state = AuthError(message: e.toString());
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
    } on Exception {
      state = const AuthInitial();
    }
  }

  Future<void> restoreToken() async {
    try {
      await _repository.restoreToken();
      await checkAuth();
    } on Exception {
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
