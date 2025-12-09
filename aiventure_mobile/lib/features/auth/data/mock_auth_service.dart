import 'package:dio/dio.dart';

import '../../../core/network/api_client.dart';
import 'i_auth_service.dart';

/// Service d'authentification Mock pour le développement sans backend
/// Simule les réponses de l'API avec des données fictives et des délais réalistes
class MockAuthService implements IAuthService {
  final ApiClient api;

  MockAuthService(this.api);

  /// Simule une connexion utilisateur avec un délai de 400ms
  /// Retourne toujours un token mock et un utilisateur fictif
  Future<Response> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return Response(
      requestOptions: RequestOptions(path: '/auth/login'),
      data: {
        'token': 'mock-jwt-token',
        'refreshToken': 'mock-refresh-token',
        'user': {'id': 'u1', 'email': email, 'name': 'Mock User'},
      },
      statusCode: 200,
    );
  }

  /// Simule l'inscription d'un nouvel utilisateur avec un délai de 400ms
  /// Retourne toujours un token mock et crée un utilisateur fictif avec le nom fourni
  Future<Response> register(String email, String password, String name) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return Response(
      requestOptions: RequestOptions(path: '/auth/register'),
      data: {
        'token': 'mock-jwt-token',
        'refreshToken': 'mock-refresh-token',
        'user': {'id': 'u1', 'email': email, 'name': name},
      },
      statusCode: 201,
    );
  }

  /// Simule la récupération du profil utilisateur avec un délai de 200ms
  /// Retourne toujours un utilisateur mock prédéfini
  Future<Response> profile() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return Response(
      requestOptions: RequestOptions(path: '/auth/me'),
      data: {'id': 'u1', 'email': 'mock@user.com', 'name': 'Mock User'},
      statusCode: 200,
    );
  }

  /// Simule le rafraîchissement du token JWT avec un délai de 300ms
  /// Retourne toujours un nouveau token mock
  Future<Response> refresh(String refreshToken) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return Response(
      requestOptions: RequestOptions(path: '/auth/refresh'),
      data: {
        'token': 'mock-jwt-token-2',
        'refreshToken': 'mock-refresh-token-2',
      },
      statusCode: 200,
    );
  }
}
