import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  SecureStorageService();

  static const _authTokenKey = 'auth_token';
  static const _userIdKey = 'user_id';

  final _storage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await _storage.write(key: _authTokenKey, value: token);
  }

  Future<String?> getToken() async {
    return _storage.read(key: _authTokenKey);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: _authTokenKey);
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
