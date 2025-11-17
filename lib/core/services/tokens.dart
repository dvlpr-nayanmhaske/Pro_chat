class Tokens {
  static String? _refreshToken;
  static String? _accessToken;

  static String? get refreshToken => _refreshToken;
  static String? get accessToken => _accessToken;

  static storeToken({refreshToken, accessToken}) {}
  static clearToken({refreshToken, accessToken}) {}
}
