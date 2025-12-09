import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';

final memoryListProvider = FutureProvider<List<Map<String, dynamic>>>((
  ref,
) async {
  final service = ref.watch(memoryServiceProvider);
  final res = await (service as dynamic).list();
  return List<Map<String, dynamic>>.from(res as List);
});
