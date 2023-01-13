import 'dart:io';

import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/auth/auth_firebase_service.dart';
// import 'package:chat/core/services/auth/auth_mock_service.dart';

// Classe abstrata não pose ser instânciada;
abstract class AuthService {
  //Pegar o usuário corrente;
  ChatUser? get currentUser;

  // Lança um novo dado sempre que haja uma mudanda no estado do usuário(cadastrou, logou, deslogou);
  Stream<ChatUser?> get userChanges;

  Future<void> signup(String name, String email, String password, File? image);

  Future<void> login(String email, String password);

  Future<void> logout();

  // Alternar entre dados mocados ou dados do BD;
  factory AuthService() {
    // return AuthMockService();
    return AuthFirebasekService();
  }
}
