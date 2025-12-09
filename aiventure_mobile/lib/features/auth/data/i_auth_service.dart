import 'package:dio/dio.dart';

/// Interface définissant le contrat du service d'authentification
/// Cette abstraction permet de basculer facilement entre le service réel et le service mock
abstract class IAuthService {
  /// Connecte un utilisateur avec son email et mot de passe
  Future<Response> login(String email, String password);

  /// Inscrit un nouvel utilisateur avec email, mot de passe et nom
  Future<Response> register(String email, String password, String name);

  /// Récupère le profil de l'utilisateur connecté
  Future<Response> profile();

  /// Rafraîchit le token JWT avec le refresh token
  Future<Response> refresh(String refreshToken);
}
