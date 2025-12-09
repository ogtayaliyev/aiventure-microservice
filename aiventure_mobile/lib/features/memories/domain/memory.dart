class Memory {
  final String id;
  final String url;
  final DateTime date;
  final String? location;

  Memory({
    required this.id,
    required this.url,
    required this.date,
    this.location,
  });

  factory Memory.fromJson(Map<String, dynamic> json) => Memory(
    id: json['id'].toString(),
    url: json['url'],
    date: DateTime.parse(json['date']),
    location: json['location'],
  );
}
