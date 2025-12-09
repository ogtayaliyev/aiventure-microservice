import '../../../core/network/api_client.dart';

class ChatService {
  final ApiClient api;
  ChatService(this.api);

  Future sendMessage(String message) =>
      api.post('/ai/chat', data: {'message': message});
}
