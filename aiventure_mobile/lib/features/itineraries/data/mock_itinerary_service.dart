import '../../../core/network/api_client.dart';

/// Service Mock pour la gestion des itinéraires de voyage sans backend
/// Simule les opérations de récupération et sauvegarde d'itinéraires avec des données fictives
class MockItineraryService {
  final ApiClient api;

  MockItineraryService(this.api);

  /// Récupère la liste de tous les itinéraires (données mock)
  /// Retourne un itinéraire "Paris Weekend" avec 2 lieux (Louvre, Tour Eiffel)
  Future<List<Map<String, dynamic>>> listItineraries() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [
      {
        'id': '1',
        'title': 'Paris Weekend',
        'places': [
          {'id': 'p1', 'name': 'Louvre', 'lat': 48.8606, 'lng': 2.3376},
          {'id': 'p2', 'name': 'Eiffel Tower', 'lat': 48.8584, 'lng': 2.2945},
        ],
      },
    ];
  }

  /// Récupère un itinéraire spécifique par son ID
  /// Recherche dans la liste des itinéraires mock
  Future<Map<String, dynamic>> getItinerary(String id) async {
    final list = await listItineraries();
    return list.firstWhere((e) => e['id'] == id, orElse: () => list.first);
  }

  /// Simule la sauvegarde d'un nouvel itinéraire
  /// Retourne après un délai de 300ms sans effectuer d'action réelle
  Future<void> saveItinerary(Map<String, dynamic> data) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }
}
