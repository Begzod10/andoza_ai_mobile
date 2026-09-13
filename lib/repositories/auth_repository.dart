import '../models/user_model.dart';
import '../services/api_client.dart';
import '../services/secure_storage.dart';

abstract interface class AuthRepository {
  Future<AuthResponse> login(String email, String password);
  Future<void> requestOtp(String phone);
  Future<AuthResponse> verifyOtp(String phone, String code);
  Future<AuthResponse> register(String username, String password, String? name);
  Future<void> logout();
  Future<User?> getCurrentUser();
  Future<void> restoreToken();
  String? get token;
}

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._apiClient, this._storage);

  final ApiClient _apiClient;
  final SecureStorageService _storage;
  String? _cachedToken;

  @override
  Future<AuthResponse> login(String email, String password) async {
    try {
      final response = await _apiClient.post<Map<String, dynamic>>(
        '/auth/login',
        data: {'username': email, 'password': password},
        fromJson: (json) => json as Map<String, dynamic>,
      );

      final authResponse = AuthResponse.fromJson(response);
      await _persistSession(authResponse);
      return authResponse;
    } on ApiException catch (e) {
      throw AuthException(e.message);
    }
  }

  /// Persist an authenticated session (access + refresh tokens) so silent
  /// refresh-on-401 works. Shared by login / OTP verify / register.
  Future<void> _persistSession(AuthResponse authResponse) async {
    _cachedToken = authResponse.token;
    await _storage.saveToken(authResponse.token);
    await _storage.saveUserId(authResponse.user.id);
    _apiClient.setAuthToken(authResponse.token);
    final refreshToken = authResponse.refreshToken;
    if (refreshToken != null && refreshToken.isNotEmpty) {
      await _storage.saveRefreshToken(refreshToken);
      _apiClient.setRefreshToken(refreshToken);
    }
  }

  @override
  Future<void> requestOtp(String phone) async {
    try {
      await _apiClient.post<void>(
        '/auth/otp/request',
        data: {'phone': phone},
        fromJson: (_) {},
      );
    } on ApiException catch (e) {
      throw AuthException(e.message);
    }
  }

  @override
  Future<AuthResponse> verifyOtp(String phone, String code) async {
    try {
      final response = await _apiClient.post<Map<String, dynamic>>(
        '/auth/otp/verify',
        data: {'phone': phone, 'code': code},
        fromJson: (json) => json as Map<String, dynamic>,
      );
      final authResponse = AuthResponse.fromJson(response);
      await _persistSession(authResponse);
      return authResponse;
    } on ApiException catch (e) {
      throw AuthException(e.message);
    }
  }

  @override
  Future<AuthResponse> register(String username, String password, String? name) async {
    try {
      final data = <String, dynamic>{'username': username, 'password': password};
      if (name != null && name.isNotEmpty) data['name'] = name;
      final response = await _apiClient.post<Map<String, dynamic>>(
        '/auth/register',
        data: data,
        fromJson: (json) => json as Map<String, dynamic>,
      );
      final authResponse = AuthResponse.fromJson(response);
      await _persistSession(authResponse);
      return authResponse;
    } on ApiException catch (e) {
      throw AuthException(e.message);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _apiClient.post<void>('/auth/logout', data: {}, fromJson: (_) {});
    } on ApiException {
      // Ignore logout errors
    } finally {
      _cachedToken = null;
      await _storage.clear();
      _apiClient.clearAuthToken();
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    if (_cachedToken == null) return null;

    try {
      return await _apiClient.get<User>(
        '/auth/me',
        fromJson: (json) => User.fromJson(json as Map<String, dynamic>),
      );
    } on ApiException {
      return null;
    }
  }

  @override
  Future<void> restoreToken() async {
    final token = await _storage.getToken();
    if (token != null) {
      _cachedToken = token;
      _apiClient.setAuthToken(token);
    }
    // Also restore the refresh token so an expired access token can be
    // refreshed on the first 401 after an app restart.
    final refreshToken = await _storage.getRefreshToken();
    if (refreshToken != null) {
      _apiClient.setRefreshToken(refreshToken);
    }
  }

  bool get isAuthenticated => _cachedToken != null;

  @override
  String? get token => _cachedToken;
}

class AuthException implements Exception {
  AuthException(this.message);
  final String message;

  @override
  String toString() => message;
}
