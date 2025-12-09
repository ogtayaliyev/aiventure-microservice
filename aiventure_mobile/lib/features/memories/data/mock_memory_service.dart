import '../../../core/network/api_client.dart';

/// Service Mock pour la gestion des souvenirs (photos de voyage) sans backend
/// Simule les opérations de récupération et upload de photos avec des données fictives
class MockMemoryService {
  final ApiClient api;

  MockMemoryService(this.api);

  /// Récupère la liste des souvenirs (photos) - données mock
  /// Génère 6 photos fictives avec URL placeholder, date et localisation
  Future<List<Map<String, dynamic>>> list() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.generate(
      6,
      (i) => {
        'id': 'm$i',
        'url': 'https://placehold.co/200x200?text=Photo+$i',
        'date': DateTime.now().subtract(Duration(days: i)).toIso8601String(),
        'location': i % 2 == 0 ? 'Paris' : 'Lyon',
      },
    );
  }

  /// Simule l'upload d'une nouvelle photo de souvenir
  /// Retourne après un délai de 500ms sans effectuer d'action réelle
  Future<void> upload(dynamic fileData) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
