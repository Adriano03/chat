import 'dart:io';
import 'dart:async';
import 'dart:math';

import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/auth/auth_service.dart';

class AuthMockService implements AuthService {
  // Usuário padrão para não precisar ficar criando e logando o usuário(Apenas p/ Mock);
  static final _defaultUser = ChatUser(
    id: '11',
    name: 'Adriano',
    email: 'adriano@hot.com',
    imageUrl: 'assets/images/avatar.png',
  );

  // Sempre que o método for static ele não perde seus dados quando é instânciado;
  static final Map<String, ChatUser> _users = {
    _defaultUser.email: _defaultUser,
  };
  static ChatUser? _currentUser;

  static MultiStreamController<ChatUser?>? _controller;
  static final _userStream = Stream<ChatUser?>.multi((controller) {
    _controller = controller;
    // Passando o valor nulo vai zerar o usuário atual e gera um novo valor nulo na stream; (_defaultUser apenas para mock);
    _updateUser(_defaultUser);
  });

  @override
  ChatUser? get currentUser {
    return _currentUser;
  }

  // Quando um novo valor for gerado vai ser notificado;
  @override
  Stream<ChatUser?> get userChanges {
    return _userStream;
  }

  @override
  Future<void> signup(
    String name,
    String email,
    String password,
    File? image,
  ) async {
    final newUser = ChatUser(
      // Criar novo usuário;
      id: Random().nextDouble().toString(),
      name: name,
      email: email,
      imageUrl: image?.path ?? 'assets/images/avatar.png',
    );
    // Adicionar novo usuário ao Map;
    _users.putIfAbsent(email, () => newUser);
    _updateUser(newUser);
  }

  @override
  Future<void> login(String email, String password) async {
    // Se existir user dentro do Map vai setar o currentUser, e vai gerar dado na Stream;
    _updateUser(_users[email]);
  }

  @override
  Future<void> logout() async {
    _updateUser(null);
  }

  static void _updateUser(ChatUser? user) {
    _currentUser = user;
    _controller?.add(_currentUser);
  }
}
