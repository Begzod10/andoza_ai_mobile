import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  SecureStorageService();

  static const _authTokenKey = 'auth_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _userIdKey = 'user_id';

  // Explicit platform options harden at-rest storage of auth/refresh tokens:
  // - Android: use the EncryptedSharedPreferences implementation rather than
  //   the legacy plaintext-keystore-wrapped SharedPreferences.
  // - iOS: keychain items are only readable after the first unlock and never
  //   leave this device (not synced to iCloud / restored to another device).
  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  Future<void> saveToken(String token) async {
    await _storage.write(key: _authTokenKey, value: token);
  }

  Future<String?> getToken() async {
    return _storage.read(key: _authTokenKey);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: _authTokenKey);
  }

  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: _refreshTokenKey, value: token);
  }

  Future<String?> getRefreshToken() async {
    return _storage.read(key: _refreshTokenKey);
  }

  Future<void> deleteRefreshToken() async {
    await _storage.delete(key: _refreshTokenKey);
  }

  Future<void> saveUserId(String userId) async {
    await _storage.write(key: _userIdKey, value: userId);
  }

  Future<String?> getUserId() async {
    return _storage.read(key: _userIdKey);
  }

  Future<void> clear() async {
    await _storage.deleteAll();
  }
}
