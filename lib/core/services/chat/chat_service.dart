import 'package:chat/core/models/chat_message.dart';
import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/chat/chat_firebase_service.dart';
// import 'package:chat/core/services/chat/chat_mock_service.dart';

abstract class ChatService {
  //Consultar dados;
  Stream<List<ChatMessage>> messagesStream();
  //Salvar msn (precisa do texto e usuário logado);
  Future<ChatMessage?> save(String text, ChatUser users);

  factory ChatService() {
    // return ChatMockService();
    return ChatFirebaseService();
  }
}
