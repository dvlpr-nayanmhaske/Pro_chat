import 'package:commet_chat/core/services/api_client.dart';
import 'package:commet_chat/features/conversations/models/conversation.dart';

class ConversationsRepository {
  final ApiClient apiClient;

  ConversationsRepository({required this.apiClient});

  getConversations() async {
    try {
      final response = await apiClient.dio.get('/conversation/');
      if (response.statusCode == 200) {
        final List conversations = response.data['data']['conversations'];
        return conversations.map((e) => Conversation.fromJson(e)).toList();
      }
    } catch (e) {
      rethrow;
    }
  }
}
