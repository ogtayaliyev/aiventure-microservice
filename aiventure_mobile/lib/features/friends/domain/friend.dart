class Friend {
  final String id;
  final String name;
  final String? avatarUrl;

  Friend({required this.id, required this.name, this.avatarUrl});

  factory Friend.fromJson(Map<String, dynamic> json) => Friend(
    id: json['id'].toString(),
    name: json['name'] ?? '',
    avatarUrl: json['avatarUrl'],
  );
}
