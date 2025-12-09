import '../../../core/network/api_client.dart';

class MockChatService {
  final ApiClient api;
  MockChatService(this.api);

  Future<Map<String, dynamic>> sendMessage(String message) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return {
      'id': 'm1',
      'text': 'Réponse IA (mock) à: $message',
      'timestamp': DateTime.now().toIso8601String(),
    };
  }
}
