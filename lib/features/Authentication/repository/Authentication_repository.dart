import 'package:commet_chat/core/services/api_client.dart';
import 'package:commet_chat/core/services/device_info_service.dart';
import 'package:commet_chat/core/services/logger.dart';
import 'package:commet_chat/core/services/tokens.dart';
import 'package:commet_chat/core/services/user.dart';

class AuthenticationRepository {
  final ApiClient apiClient;

  AuthenticationRepository(this.apiClient);

  sendOtp(phoneNo) async {
    try {
      final response = await apiClient.dio.get("/auth/send-otp/$phoneNo");

      if (response.statusCode == 200) {
        return;
      }

      throw response.data['message'] ?? "INTERNAL SERVER ERROR";
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  validateOtp({required phoneNo, required otp}) async {
    try {
      final payload = {
        "deviceId": await DeviceInfo.deviceId,
        "deviceType": "mobile",
        "number": phoneNo,
        "otp": otp,
      };

      final response = await apiClient.dio.post(
        "/auth/validate-otp",
        data: payload,
      );

      if (response.statusCode == 200) {
        final userData = response.data['data']['user'];
        final refreshToken = response.data['data']['refreshToken'];
        final accessToken = response.data['data']['accessToken'];

        Tokens.storeToken(refreshToken: refreshToken, accessToken: accessToken);
        User().store(userData);

        return;
      }
    } catch (e) {
      rethrow;
    }
  }

  refreshToken() async {
    try {
      final payload = {"refreshToken": await Tokens.refreshToken};
      final response = await apiClient.dio.post(
        "/auth/refresh-token",
        data: payload,
      );

      if (response.statusCode == 200) {
        final refreshToken = response.data['data']['refreshToken'];
        final accessToken = response.data['data']['accessToken'];
        Tokens.storeToken(refreshToken: refreshToken, accessToken: accessToken);
        return;
      }
    } catch (e) {
      rethrow;
    }
  }

  getUserDetails() async {
    try {
      final response = await apiClient.dio.get("/get-user");
      if (response.statusCode == 200) {
        final data = response.data['data'];
        User().store(data);
        return;
      }
    } catch (e) {
      rethrow;
    }
  }
}
