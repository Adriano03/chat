import 'package:chat/components/messages.dart';
import 'package:chat/components/new_messages.dart';
import 'package:chat/core/services/auth/auth_service.dart';
import 'package:chat/core/services/notification/chat_notification_service.dart';
import 'package:chat/pages/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    final notificationCounter =
        Provider.of<ChatNotificationService>(context).itemsCount;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) {
                          return const NotificationPage();
                        },
                      ),
                    );
                  },
                ),
                Positioned(
                  right: MediaQuery.of(context).size.width * 0.014,
                  top: MediaQuery.of(context).size.height * 0.007,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red.shade800,
                    child: Text(
                      notificationCounter.toString(),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  onTap: () => AuthService().logout(),
                  child: Row(
                    children: const [
                      Icon(Icons.exit_to_app, color: Colors.black),
                      SizedBox(width: 10),
                      Text('Sair'),
                    ],
                  ),
                ),
              ];
            },
          ),
          // DropdownButtonHideUnderline(
          //   child: DropdownButton(
          //     icon: Icon(
          //       Icons.more_vert,
          //       color: Theme.of(context).primaryIconTheme.color,
          //     ),
          //     items: [
          //       DropdownMenuItem(
          //         value: 'logout',
          //         child: Row(
          //           children: const [
          //             Icon(
          //               Icons.exit_to_app,
          //               color: Colors.black87,
          //             ),
          //             SizedBox(width: 10),
          //             Text('Sair'),
          //           ],
          //         ),
          //       ),
          //     ],
          //     onChanged: (value) {
          //       if (value == 'logout') {
          //         AuthService().logout();
          //       }
          //     },
          //   ),
          // ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: const [
            Expanded(child: Messages()),
            NewMessages(),
          ],
        ),
      ),
    );
  }
}
