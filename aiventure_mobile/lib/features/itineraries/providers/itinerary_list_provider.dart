import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';

final itineraryListProvider = FutureProvider<List<Map<String, dynamic>>>((
  ref,
) async {
  final service = ref.watch(itineraryServiceProvider);
  final res = await (service as dynamic).listItineraries();
  return List<Map<String, dynamic>>.from(res as List);
});
