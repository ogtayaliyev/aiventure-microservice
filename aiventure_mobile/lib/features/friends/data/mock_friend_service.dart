import 'dart:async';

import '../../../core/network/api_client.dart';

/// Service Mock pour la gestion des amis sans backend
/// Simule les opérations de récupération, ajout et suppression d'amis avec des données fictives
class MockFriendService {
  final ApiClient api;

  MockFriendService(this.api);

  /// Récupère la liste des amis (données mock)
  /// Retourne une liste de 2 amis fictifs après un délai de 300ms
  Future<List<Map<String, String>>> fetchFriends() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [
      {'id': '1', 'name': 'Alice'},
      {'id': '2', 'name': 'Bob'},
    ];
  }

  /// Simule l'ajout d'un ami par son email
  /// Retourne après un délai de 300ms sans effectuer d'action réelle
  Future<void> addFriend(String email) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return;
  }

  /// Simule la suppression d'un ami par son ID
  /// Retourne après un délai de 200ms sans effectuer d'action réelle
  Future<void> removeFriend(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return;
  }
}
