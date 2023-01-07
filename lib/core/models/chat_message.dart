class ChatMessage {
  // Dados mensagens;
  final String id;
  final String text;
  final DateTime createdAt;
  // Dados usuário;
  final String userId;
  final String username;
  final String userImageUrl;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.createdAt,
    required this.userId,
    required this.username,
    required this.userImageUrl,
  });
}
