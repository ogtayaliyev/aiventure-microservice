import 'package:dio/dio.dart';

import '../../../core/network/api_client.dart';
import 'i_auth_service.dart';

/// Service d'authentification réel qui communique avec l'API backend
/// Implémente toutes les opérations d'authentification via HTTP
class AuthService implements IAuthService {
  final ApiClient api;

  AuthService(this.api);

  /// Envoie une requête de connexion à l'API avec email et mot de passe
  /// Retourne un Response contenant le token JWT et les infos utilisateur
  @override
  Future<Response> login(String email, String password) async {
    return api.post(
      '/auth/login',
      data: {'email': email, 'password': password},
    );
  }

  /// Envoie une requête d'inscription à l'API avec les informations utilisateur
  /// Retourne un Response contenant le token JWT et le nouvel utilisateur créé
  @override
  Future<Response> register(String email, String password, String name) async {
    return api.post(
      '/auth/register',
      data: {'email': email, 'password': password, 'name': name},
    );
  }

  /// Récupère le profil de l'utilisateur connecté depuis l'API
  /// Utilise le token JWT stocké pour authentifier la requête
  @override
  Future<Response> profile() async {
    return api.get('/auth/me');
  }

  /// Rafraîchit le token JWT expiré en utilisant le refresh token
  /// Permet de maintenir l'utilisateur connecté sans redemander ses credentials
  @override
  Future<Response> refresh(String refreshToken) async {
    return api.post('/auth/refresh', data: {'refreshToken': refreshToken});
  }
}
