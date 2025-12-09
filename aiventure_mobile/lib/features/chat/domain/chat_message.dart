class ChatMessage {
  final String id;
  final String text;
  final bool fromUser;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.text,
    required this.fromUser,
    required this.timestamp,
  });
}
