import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalDbServices {
  static final LocalDbServices _instance = LocalDbServices.internal();
  LocalDbServices.internal();

  factory LocalDbServices() => _instance;

  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<bool> isFirstTimeUSer() async {
    String? value = await _storage.read(key: 'isFirstTime');

    if (value == null) {
      await _storage.write(key: 'isFirstTime', value: 'false');
      return true;
    }

    return false;
  }
}
