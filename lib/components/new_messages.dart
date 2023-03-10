import 'package:chat/core/services/auth/auth_service.dart';
import 'package:chat/core/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({Key? key}) : super(key: key);

  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  bool _isLoading = false;
  String _message = '';
  final _messageController = TextEditingController();

  Future<void> _sendMessage() async {
    final user = AuthService().currentUser;

    if (user != null) {
      setState(() => _isLoading = true);
      _messageController.clear();
      await ChatService().save(_message, user);
      setState(() {
        _message = '';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _messageController,
            textCapitalization: TextCapitalization.sentences,
            textInputAction: TextInputAction.send,
            decoration:
                const InputDecoration(labelText: '  Enviar mensagem...'),
            onChanged: (msg) => setState(() => _message = msg),
            onSubmitted: (_) {
              if (_message.trim().isNotEmpty) {
                _sendMessage();
              }
            },
          ),
        ),
        _isLoading
            ? const Padding(
                padding: EdgeInsets.only(right: 10),
                child: SizedBox(
                  width: 27,
                  height: 27,
                  child: CircularProgressIndicator(),
                ),
              )
            : IconButton(
                icon: const Icon(Icons.send),
                onPressed: _message.trim().isEmpty ? null : _sendMessage,
              ),
      ],
    );
  }
}
