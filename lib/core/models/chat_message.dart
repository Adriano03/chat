class ChatMessage {
  // Dados mensagens;
  final String id;
  final String text;
  final DateTime createdAt;
  // Dados usuário;
  final String userId;
  final String userName;
  final String userImageUrl;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.createdAt,
    required this.userId,
    required this.userName,
    required this.userImageUrl,
  });
}
