import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStore {
  static const String ACCESS_TOKEN_KEY = "accessToken";
  static const String REFRESH_TOKEN_KEY = "refreshToken";

  final FlutterSecureStorage _storage;

  String _refreshToken;
  String _accessToken;

  TokenStore(this._storage);

  Future<void> flushTokens() async {
    await _storage.delete(key: ACCESS_TOKEN_KEY);
    await _storage.delete(key: REFRESH_TOKEN_KEY);

    _refreshToken = null;
    _accessToken = null;
  }

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);
    await _storage.write(key: REFRESH_TOKEN_KEY, value: refreshToken);

    _accessToken = accessToken;
    _refreshToken = refreshToken;
  }

  Future<String> getAccessToken() async {
    return _accessToken ?? await _storage.read(key: ACCESS_TOKEN_KEY);
  }

  Future<String> getRefreshToken() async {
    return _refreshToken ?? await _storage.read(key: REFRESH_TOKEN_KEY);
  }
}
