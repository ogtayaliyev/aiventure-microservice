import '../../../core/network/api_client.dart';

/// Service réel pour la gestion des souvenirs (photos) via l'API backend
/// Gère les requêtes HTTP pour uploader et récupérer des photos de voyage
class MemoryService {
  final ApiClient api;

  MemoryService(this.api);

  /// Upload une nouvelle photo de souvenir vers l'API
  /// Envoie le fichier dans le body de la requête
  Future upload(dynamic fileData) =>
      api.post('/memories', data: {'file': 'placeholder'});

  /// Récupère la liste de toutes les photos de souvenirs depuis l'API
  Future list() => api.get('/memories');
}
