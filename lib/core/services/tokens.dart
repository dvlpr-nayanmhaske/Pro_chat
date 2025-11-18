import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Tokens {
  static String? _refreshToken;
  static String? _accessToken;

  static Future<String?> get refreshToken async {
    if (_refreshToken != null) {
      return _refreshToken;
    }

    final storage = FlutterSecureStorage();
    _refreshToken = await storage.read(key: "refreshToken");

    return _refreshToken;
  }

  static String? get accessToken => _accessToken;

  static storeToken({refreshToken, accessToken}) async {
    _refreshToken = refreshToken;
    _accessToken = accessToken;
    final storage = FlutterSecureStorage(); 
    await storage.write(key: "refreshToken", value: refreshToken);
  }

  static clearToken({refreshToken, accessToken}) async {
    _refreshToken = null;
    _accessToken = null;
    final storage = FlutterSecureStorage();
    await storage.delete(key: "refreshToken");
  }
}
