import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfo {
  static String? _deviceId;

  static Future<String> get deviceId async {
    if (_deviceId != null) return _deviceId!;
    final plugin = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final info = await plugin.androidInfo;
      _deviceId = info.id; // ANDROID ID
    } else if (Platform.isIOS) {
      final info = await plugin.iosInfo;
      _deviceId = info.identifierForVendor; // iOS ID
    }

    return _deviceId!;
  }
}
