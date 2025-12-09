import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/permissions/permission_provider.dart';
import '../providers/itinerary_list_provider.dart';

class ItinerariesPage extends ConsumerWidget {
  const ItinerariesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(itineraryListProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Itinéraires IA')),
      body: listAsync.when(
        data: (items) => ListView.separated(
          itemCount: items.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (ctx, i) => ListTile(
            title: Text(items[i]['title'] ?? ''),
            subtitle: Text('${(items[i]['places'] as List).length} lieux'),
            onTap: () async {
              final granted = await ref
                  .read(permissionServiceProvider)
                  .requestLocation();
              if (granted) {
                Navigator.of(
                  context,
                ).pushNamed('/home/itineraries/${items[i]['id']}');
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Permission localisation refusée'),
                  ),
                );
              }
            },
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Erreur: $e')),
      ),
    );
  }
}
