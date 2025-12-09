import '../../../core/network/api_client.dart';

/// Service réel pour la gestion des amis via l'API backend
/// Gère les requêtes HTTP pour récupérer, ajouter et supprimer des amis
class FriendService {
  final ApiClient api;

  FriendService(this.api);

  /// Récupère la liste des amis depuis l'API
  Future fetchFriends() => api.get('/friends');

  /// Ajoute un nouvel ami en envoyant son email à l'API
  Future addFriend(String email) =>
      api.post('/friends', data: {'email': email});

  /// Supprime un ami par son ID
  Future removeFriend(String id) => api.delete('/friends/$id');
}
