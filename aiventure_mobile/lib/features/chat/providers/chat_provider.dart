import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../data/chat_service.dart';
import '../data/mock_chat_service.dart';

final chatServiceProvider = Provider((ref) {
  final api = ref.watch(apiClientProvider);
  final useMock = ref.watch(useMockBackendProvider);
  if (useMock) return MockChatService(api);
  return ChatService(api);
});
