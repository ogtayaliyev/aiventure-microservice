import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../domain/user.dart';
import 'i_auth_service.dart';

/// Repository pour gérer l'authentification des utilisateurs
///
/// Responsable de :
/// - La connexion et l'inscription des utilisateurs
/// - La sauvegarde sécurisée des tokens JWT
/// - La récupération du profil utilisateur
class AuthRepository {
  final IAuthService service;
  final FlutterSecureStorage storage;

  AuthRepository({required this.service, required this.storage});

  /// Connecte un utilisateur avec son email et mot de passe
  ///
  /// Sauvegarde automatiquement le JWT et refresh token dans le stockage sécurisé
  /// Retourne l'utilisateur connecté
  Future<User> login(String email, String password) async {
    final resp = await service.login(email, password);
    final data = resp.data as Map<String, dynamic>;
    final token = data['token'] as String?;
    final refresh = data['refreshToken'] as String?;

    // Sauvegarde des tokens de manière sécurisée
    if (token != null) await storage.write(key: 'jwt', value: token);
    if (refresh != null) {
      await storage.write(key: 'refresh_token', value: refresh);
    }

    return User.fromJson(data['user'] as Map<String, dynamic>);
  }

  /// Inscrit un nouvel utilisateur
  ///
  /// Sauvegarde automatiquement le JWT et refresh token dans le stockage sécurisé
  /// Retourne l'utilisateur créé
  Future<User> register(String email, String password, String name) async {
    final resp = await service.register(email, password, name);
    final data = resp.data as Map<String, dynamic>;
    final token = data['token'] as String?;
    final refresh = data['refreshToken'] as String?;

    // Sauvegarde des tokens de manière sécurisée
    if (token != null) await storage.write(key: 'jwt', value: token);
    if (refresh != null) {
      await storage.write(key: 'refresh_token', value: refresh);
    }

    return User.fromJson(data['user'] as Map<String, dynamic>);
  }

  /// Récupère le profil de l'utilisateur connecté
  Future<User> me() async {
    final resp = await service.profile();
    return User.fromJson(resp.data as Map<String, dynamic>);
  }
}
