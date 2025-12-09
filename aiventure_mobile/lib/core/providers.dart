import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../features/friends/data/mock_friend_service.dart';
import '../features/itineraries/data/mock_itinerary_service.dart';
import '../features/memories/data/mock_memory_service.dart';
import 'network/api_client.dart';
import 'network/auth_interceptor.dart';

/// URL de base de l'API backend
final baseUrlProvider = Provider<String>((ref) => 'https://api.example.com');

/// Mode développement : utilise les services Mock au lieu de l'API réelle
/// Mettre à `false` pour utiliser l'API réelle en production
final useMockBackendProvider = Provider<bool>((ref) => true);

/// Provider pour le stockage sécurisé (tokens, credentials, etc.)
final secureStorageProvider = Provider<FlutterSecureStorage>(
  (ref) => const FlutterSecureStorage(),
);

/// Provider du client API avec configuration Dio
///
/// En mode Mock : retourne un client basique
/// En mode Production : configure Dio avec intercepteurs d'authentification
final apiClientProvider = Provider<ApiClient>((ref) {
  final useMock = ref.watch(useMockBackendProvider);
  final base = ref.watch(baseUrlProvider);

  if (useMock) {
    // Retourne un client API basique, les services seront remplacés par des mocks
    return ApiClient(baseUrl: base);
  }

  // Configuration du client API pour la production
  final storage = ref.watch(secureStorageProvider);
  final dio = Dio(
    BaseOptions(
      baseUrl: base,
      connectTimeout: const Duration(milliseconds: 15000),
      receiveTimeout: const Duration(milliseconds: 15000),
    ),
  );

  // Ajout de l'intercepteur d'authentification JWT
  dio.interceptors.add(AuthInterceptor(storage: storage, baseUrl: base));
  return ApiClient.fromDio(dio);
});

/// Provider du service de gestion des amis
/// Retourne un MockFriendService en mode développement ou le vrai service en production
final friendServiceProvider = Provider((ref) {
  final useMock = ref.watch(useMockBackendProvider);
  final api = ref.watch(apiClientProvider);
  if (useMock) {
    return MockFriendService(api);
  }
  // Retourne le vrai service quand implémenté
  return MockFriendService(api);
});

/// Provider du service de gestion des itinéraires de voyage
/// Retourne un MockItineraryService en mode développement ou le vrai service en production
final itineraryServiceProvider = Provider((ref) {
  final useMock = ref.watch(useMockBackendProvider);
  final api = ref.watch(apiClientProvider);
  if (useMock) {
    return MockItineraryService(api);
  }
  // Retourne le vrai service quand implémenté
  return MockItineraryService(api);
});

final memoryServiceProvider = Provider((ref) {
  final useMock = ref.watch(useMockBackendProvider);
  final api = ref.watch(apiClientProvider);
  if (useMock) {
    return MockMemoryService(api);
  }
  // Return real service when implemented
  return MockMemoryService(api);
});
