import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../data/friend_service.dart';
import '../data/mock_friend_service.dart';

final friendServiceProvider = Provider((ref) {
  final api = ref.watch(apiClientProvider);
  final useMock = ref.watch(useMockBackendProvider);
  if (useMock) return MockFriendService(api);
  return FriendService(api);
});
