import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/friend_list_provider.dart';

class FriendsPage extends ConsumerWidget {
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final friendsAsync = ref.watch(friendListProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Friends')),
      body: friendsAsync.when(
        data: (friends) => ListView.separated(
          itemCount: friends.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (ctx, i) => ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text(friends[i].name),
            subtitle: Text('id: ${friends[i].id}'),
            trailing: IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              onPressed: () {},
            ),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Erreur: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed('/home/friends/add'),
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
