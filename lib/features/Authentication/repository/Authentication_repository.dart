import 'package:commet_chat/core/services/api_client.dart';
import 'package:commet_chat/core/services/logger.dart';

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
        "deviceId": "12345",
        "deviceType": "mobile",
        "number": phoneNo,
        "otp": otp,
      };

      final response = await apiClient.dio.post(
        "/auth/validate-otp",
        data: payload,
      );

      if (response.statusCode == 200) {
        return;
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
