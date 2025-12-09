import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../data/memory_service.dart';
import '../data/mock_memory_service.dart';

final memoryServiceProvider = Provider((ref) {
  final api = ref.watch(apiClientProvider);
  final useMock = ref.watch(useMockBackendProvider);
  if (useMock) return MockMemoryService(api);
  return MemoryService(api);
});
