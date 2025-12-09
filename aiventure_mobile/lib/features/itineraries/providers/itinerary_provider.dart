import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../data/itinerary_service.dart';
import '../data/mock_itinerary_service.dart';

final itineraryServiceProvider = Provider((ref) {
  final api = ref.watch(apiClientProvider);
  final useMock = ref.watch(useMockBackendProvider);
  if (useMock) return MockItineraryService(api);
  return ItineraryService(api);
});
