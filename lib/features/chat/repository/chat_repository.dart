import 'package:commet_chat/core/services/api_client.dart';
import 'package:commet_chat/features/chat/models/message.dart';
import 'package:commet_chat/features/chat/models/user_details.dart';

class ChatRepository {
  final ApiClient apiClient;

  ChatRepository({required this.apiClient});

  getMessages(conversationId) async {
    try {
      final response = await apiClient.dio.get("/message/$conversationId");
      if (response.statusCode == 200) {
        final List messages = response.data['data'];
        return messages.map((e) => Message.fromJson(e)).toList();
      }
    } catch (e) {
      rethrow;
    }
  }

  sendMessage({
    required String conversationId,
    required String text,
    required String receiverId,
  }) async {
    try {
      final payload = {
        "conversationId": conversationId,
        "text": text,
        "image": "",
        "receiverId": receiverId,
      };

      await apiClient.dio.post("/message/send", data: payload);
    } catch (e) {
      rethrow;
    }
  }

  getUserDetails(conversationId) async {
    try {
      final response = await apiClient.dio.get(
        "/message/userDetails/$conversationId",
      );
      if (response.statusCode == 200) {
        final data = response.data['data'];
        return UserDetails.fromJson(data);
      }
    } catch (e) {
      rethrow;
    }
  }

  markAsSeen(conversationId) async {
    try {
      final response = await apiClient.dio.get("/message/see/$conversationId");
    } catch (e) {
      rethrow;
    }
  }
}
