import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/permissions/permission_provider.dart';
import '../providers/memory_list_provider.dart';

class MemoriesPage extends ConsumerWidget {
  const MemoriesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memoriesAsync = ref.watch(memoryListProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Souvenirs')),
      body: memoriesAsync.when(
        data: (items) => GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
          ),
          itemCount: items.length,
          itemBuilder: (ctx, i) => GestureDetector(
            onTap: () => showDialog(
              context: context,
              builder: (_) =>
                  AlertDialog(content: Image.network(items[i]['url'])),
            ),
            child: Container(
              color: Colors.grey[200],
              child: Image.network(items[i]['url'], fit: BoxFit.cover),
            ),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Erreur: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final granted = await ref
              .read(permissionServiceProvider)
              .requestCamera();
          if (granted) {
            Navigator.of(context).pushNamed('/home/memories/add');
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Permission caméra refusée')),
            );
          }
        },
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
