import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/ConversationController.dart';
import '../controllers/MessageController.dart';
import '../controllers/UserCtrl.dart';

class DiscussionPage extends StatefulWidget {
  @override
  _DiscussionPageState createState() => _DiscussionPageState();
}

class _DiscussionPageState extends State<DiscussionPage> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var conversationCtrl = context.read<ConversationController>();
      conversationCtrl.recevoirListeConversation();
      var messageCtrl = context.read<MessageController>();
      messageCtrl.recevoirListeMessage();
      var userCtrl = context.read<UserCtrl>();
      userCtrl.recuperDataAPI();
    });
  }


  @override
  Widget build(BuildContext context) {
    var userCtrl = context.watch<UserCtrl>();
    var conversationCtrl = context.watch<ConversationController>();
    var conversation=conversationCtrl.conversations;
    ChatUser user = ChatUser(
      id: '${userCtrl.user?.id}',
      firstName: '${userCtrl.user?.name}',
    );

    List<ChatMessage> messages = <ChatMessage>[
      ChatMessage(
        text: 'google.com hello you @Marc is it &you okay?',
        user: ChatUser(
          id: '${conversation}',
          firstName: '',
          lastName: 'Nlandu',
          profileImage: 'assets/img.png',



        ),

        createdAt: DateTime.now(),
        mentions: [
          Mention(title: '@Marc'),
          Mention(title: '&you'),
        ],
      ),
    ];
    return Scaffold(
/*      appBar: AppBar(
        title: Text('U'),
        leading: IconButton(
          icon: CircleAvatar(
            backgroundImage: AssetImage('assets/img.png'),
          ), onPressed: () {

        },
        ),


      ),*/
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
