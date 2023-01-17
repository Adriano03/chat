import 'package:chat/core/models/chat_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatNotificationService with ChangeNotifier {
  final List<ChatNotification> _items = [];

  int get itemsCount {
    return _items.length;
  }

  List<ChatNotification> get items {
    return [..._items];
  }

  void add(ChatNotification notification) {
    _items.add(notification);
    notifyListeners();
  }

  void remove(int i) {
    _items.removeAt(i);
    notifyListeners();
  }

  // Push Notification;
  Future<void> init() async {
    await _configureTerminated();
    await _configureForeground();
    await _configureBackground();
  }

  // Metódo para conceder permissão para IOS;
  Future<bool> get _isAutorized async {
    final messaging = FirebaseMessaging.instance;
    final settings = await messaging.requestPermission();
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  // Notificação com a aplicação aberta;
  Future<void> _configureForeground() async {
    if (await _isAutorized) {
      FirebaseMessaging.onMessage.listen(_messageHandler);
    }
  }

  // Notificação com a aplicação em modo de espera;
  Future<void> _configureBackground() async {
    if (await _isAutorized) {
      FirebaseMessaging.onMessageOpenedApp.listen(_messageHandler);
    }
  }

  // Notificação com a aplicação fechada;
  Future<void> _configureTerminated() async {
    if (await _isAutorized) {
      RemoteMessage? initialMsg =
          await FirebaseMessaging.instance.getInitialMessage();
      _messageHandler(initialMsg);
    }
  }

  void _messageHandler(RemoteMessage? msg) {
    if (msg == null || msg.notification == null) return;
    add(
      ChatNotification(
        title: msg.notification!.title ?? 'Não informado!',
        body: msg.notification!.body ?? 'Não informado!',
      ),
    );
  }
}
