import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../data/auth_repository.dart';
import '../data/auth_service.dart';
import '../data/i_auth_service.dart';
import '../data/mock_auth_service.dart';

/// Provider privé du service d'authentification
/// Retourne MockAuthService en mode développement, AuthService en production
final _authServiceProvider = Provider<IAuthService>((ref) {
  final api = ref.watch(apiClientProvider);
  final useMock = ref.watch(useMockBackendProvider);
  if (useMock) return MockAuthService(api);
  return AuthService(api);
});

/// Provider du repository d'authentification
/// Combine le service d'auth et le stockage sécurisé pour gérer l'authentification complète
final authRepositoryProvider = Provider((ref) {
  final service = ref.watch(_authServiceProvider);
  final storage = ref.watch(secureStorageProvider);
  return AuthRepository(service: service, storage: storage);
});

/// Provider de l'utilisateur actuellement connecté
/// Utilise autoDispose pour nettoyer l'état quand le widget n'est plus utilisé
final authUserProvider = StateProvider.autoDispose((ref) => null);
