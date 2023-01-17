import 'dart:io';

import 'package:flutter/material.dart';

import 'package:chat/core/models/chat_message.dart';

class MessageBubble extends StatelessWidget {
  static const _defaultImage = 'assets/images/avatar.png';
  final ChatMessage message;
  final bool belongsToCurrentUser;

  const MessageBubble({
    Key? key,
    required this.message,
    required this.belongsToCurrentUser,
  }) : super(key: key);

  Widget _showUserImage(String imageUrl) {
    ImageProvider? provider;
    final uri = Uri.parse(imageUrl);

    // Especifica de onde está vindo cada imagem, se é do firebase(http) ou do mock;
    if (uri.path.contains(_defaultImage)) {
      provider = const AssetImage(_defaultImage);
    } else if (uri.scheme.contains('http')) {
      provider = NetworkImage(uri.toString());
    } else {
      provider = FileImage(File(uri.toString()));
    }

    return CircleAvatar(
      backgroundImage: provider,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: belongsToCurrentUser
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                color: belongsToCurrentUser
                    ? Colors.grey.shade300
                    : Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  topRight: const Radius.circular(10),
                  bottomLeft: belongsToCurrentUser
                      ? const Radius.circular(10)
                      : const Radius.circular(0),
                  bottomRight: !belongsToCurrentUser
                      ? const Radius.circular(10)
                      : const Radius.circular(0),
                ),
              ),
              child: Column(
                crossAxisAlignment: belongsToCurrentUser
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    message.userName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(color: Colors.black38),
                  Text(
                    message.text,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: belongsToCurrentUser
              ? MediaQuery.of(context).size.width * 0.23
              : null,
          right: !belongsToCurrentUser
              ? MediaQuery.of(context).size.width * 0.23
              : null,
          child: _showUserImage(message.userImageUrl),
        ),
      ],
    );
  }
}
