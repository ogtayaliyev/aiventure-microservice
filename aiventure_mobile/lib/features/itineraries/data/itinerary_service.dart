import '../../../core/network/api_client.dart';

/// Service réel pour la gestion des itinéraires via l'API backend
/// Gère les requêtes HTTP pour récupérer et sauvegarder des itinéraires de voyage
class ItineraryService {
  final ApiClient api;

  ItineraryService(this.api);

  /// Récupère la liste de tous les itinéraires depuis l'API
  Future listItineraries() => api.get('/itineraries');

  /// Récupère un itinéraire spécifique par son ID
  Future getItinerary(String id) => api.get('/itineraries/$id');

  /// Sauvegarde un nouvel itinéraire ou met à jour un existant
  Future saveItinerary(Map<String, dynamic> data) =>
      api.post('/itineraries', data: data);
}
