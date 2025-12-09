import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../domain/friend.dart';

final friendListProvider = FutureProvider<List<Friend>>((ref) async {
  final service = ref.watch(friendServiceProvider);
  // service may be MockFriendService or FriendService
  final res = await (service as dynamic).fetchFriends();
  return (res as List)
      .map((e) => Friend.fromJson(Map<String, dynamic>.from(e)))
      .toList();
});
