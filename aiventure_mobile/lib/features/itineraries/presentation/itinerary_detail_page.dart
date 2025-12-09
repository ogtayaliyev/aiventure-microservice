import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/itinerary_list_provider.dart';

class ItineraryDetailPage extends ConsumerWidget {
  final String id;
  const ItineraryDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(itineraryListProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Itinéraire')),
      body: listAsync.when(
        data: (items) {
          final item = items.firstWhere(
            (e) => e['id'] == id,
            orElse: () => items.first,
          );
          final places = item['places'] as List;
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: places.length,
            itemBuilder: (ctx, i) => ListTile(
              title: Text(places[i]['name'] ?? ''),
              subtitle: Text('Lat: ${places[i]['lat'] ?? '-'}'),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Erreur: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.person_add),
        onPressed: () => ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Ajouter un ami (mock)'))),
      ),
    );
  }
}
