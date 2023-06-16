import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squelette_mobile_parcours/controllers/MessageController.dart';
import 'package:squelette_mobile_parcours/controllers/UserCtrl.dart';
import 'package:squelette_mobile_parcours/models/MessageModel.dart';

class DiscussionPage extends StatefulWidget {
  @override
  _DiscussionPageState createState() => _DiscussionPageState();
}

class _DiscussionPageState extends State<DiscussionPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var messageCtrl = context.read<MessageController>();
      messageCtrl.recevoirListeMessage();
      var userCtrl = context.read<UserCtrl>();
      userCtrl.recuperDataAPI();
    });
  }

  @override
  Widget build(BuildContext context) {
    var userCtrl = context.watch<UserCtrl>();
    var messageCtrl = context.watch<MessageController>();
    var messages = messageCtrl.messages.map((message) => MessageModel.fromJson(message as Map<String, dynamic>)).toList();

    ChatUser user = ChatUser(
      id: '${userCtrl.user?.id}',
      firstName: '${userCtrl.user?.name}',
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Aimée Amisa'),
        leading: IconButton(
          icon: CircleAvatar(
            backgroundImage: AssetImage('assets/img.png'),
          ),
          onPressed: () {},
        ),
      ),
      body: DashChat(
        currentUser: user,
        onSend: (ChatMessage m) {
          setState(() {
            var newMessage = MessageModel(
              content: m.text,
              user_id: int.parse(m.user.id),
            );
            messages.insert(0, newMessage);
            // Envoyer le message à l'API
          });
        },
        messages: messages.map((message) => message.toChatMessage()).toList(),
        messageListOptions: MessageListOptions(
          onLoadEarlier: () async {
            await Future.delayed(const Duration(seconds: 3));
          },
        ),
      ),
    );
  }
}