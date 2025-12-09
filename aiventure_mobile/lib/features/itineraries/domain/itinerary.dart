class Place {
  final String id;
  final String name;
  final double? lat;
  final double? lng;

  Place({required this.id, required this.name, this.lat, this.lng});
}

class Itinerary {
  final String id;
  final String title;
  final List<Place> places;

  Itinerary({required this.id, required this.title, required this.places});

  factory Itinerary.fromJson(Map<String, dynamic> json) {
    final places = (json['places'] as List? ?? [])
        .map((e) => Place(id: e['id'].toString(), name: e['name']))
        .toList();
    return Itinerary(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      places: places,
    );
  }
}
