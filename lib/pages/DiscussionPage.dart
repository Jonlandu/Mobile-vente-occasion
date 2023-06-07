import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';

class DiscussionPagePage extends StatefulWidget {
  @override
  _DiscussionPagePageState createState() => _DiscussionPagePageState();
}

class _DiscussionPagePageState extends State<DiscussionPagePage> {
  ChatUser user = ChatUser(
    id: '0',
    firstName: 'Aimée',
    lastName: 'Amisa',
  );

  List<ChatMessage> messages = <ChatMessage>[
    ChatMessage(
      text: 'google.com hello you @Marc is it &you okay?',
      user: ChatUser(
        id: '1',
        firstName: 'Josué',
        lastName: 'Nlandu',
        profileImage: '',



      ),

      createdAt: DateTime.now(),
      mentions: [
        Mention(title: '@Marc'),
        Mention(title: '&you'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aimée Amisa'),
      ),
      body: DashChat(
        currentUser: user,
        onSend: (ChatMessage m) {
          setState(() {
            messages.insert(0, m);
          });
        },
        messages: messages,
        messageListOptions: MessageListOptions(
          onLoadEarlier: () async {
            await Future.delayed(const Duration(seconds: 3));
          },
        ),
      ),
    );
  }
}
