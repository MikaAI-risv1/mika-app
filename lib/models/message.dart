class Message {
  final String text;
  final bool isUserMessage;
  final DateTime timestamp;
  final String? imageUrl;

  Message({
    required this.text,
    required this.isUserMessage,
    required this.timestamp,
    this.imageUrl,
  });
}
