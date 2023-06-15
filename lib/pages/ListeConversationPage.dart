import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squelette_mobile_parcours/controllers/ConversationController.dart';
import 'package:squelette_mobile_parcours/controllers/MessageController.dart';
import 'package:squelette_mobile_parcours/controllers/UserCtrl.dart';
import 'package:squelette_mobile_parcours/models/ConversationModel.dart';
import 'package:squelette_mobile_parcours/utils/Routes.dart';

class ListeConversationPage extends StatefulWidget {
  const ListeConversationPage({Key? key}) : super(key: key);

  @override
  State<ListeConversationPage> createState() => _ListeConversationPageState();
}

class _ListeConversationPageState extends State<ListeConversationPage> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var conversationCtrl = context.read<ConversationController>();
      conversationCtrl.recevoirListeConversation();
      // var messageCtrl = context.read<MessageController>();
      // messageCtrl.recevoirListeMessage();
      // var userCtrl = context.read<UserCtrl>();
      // userCtrl.recuperDataAPI();
    });
  }

  final _contentStyle = const TextStyle(
      color: Colors.black, fontSize: 17, fontWeight: FontWeight.normal);
  final _headerStyle = const TextStyle(
      color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    var conversationCtl = context.watch<ConversationController>();
    var messageCtrl = context.watch<MessageController>();
    var userCtrl = context.watch<UserCtrl>();
    return Scaffold(
        appBar: AppBar(
          title: Text('Discussion'),
          backgroundColor: Colors.black,
        ),
        body: ListView.builder(
            padding: EdgeInsets.only(top: 20),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: conversationCtl.conversations.length,
            itemBuilder: (ctx, i) {
              var conversation = conversationCtl.conversations[i];
              return conversionItemiew(conversation);
            }));
  }

  conversionItemiew(ConversationModel conversation) {
    var conversationCtl = context.watch<ConversationController>();
    var messageCtrl = context.watch<MessageController>();
    var userCtrl = context.watch<UserCtrl>();
    //var c=conversationCtl.usersConversations;
    print("hheee");
    var userListConv = conversationCtl.conversations.map((e) {
      e.clients;
    });
    return Accordion(
      maxOpenSections: 1,
      paddingListBottom: 0,
      paddingListTop: 0,
      //conversationCtl.conversations.length,
      headerBackgroundColorOpened: Colors.black54,
      scaleWhenAnimating: true,
      openAndCloseAnimation: true,
      headerPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      // sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
      // sectionClosingHapticFeedback: SectionHapticFeedback.light,
      children: [
        AccordionSection(
          isOpen: false,
          leftIcon: const Icon(Icons.compare_rounded, color: Colors.white),
          // rightIcon: Colors.black87,
          header: Text("${conversation.articleTitle}"),
          contentBorderColor: const Color(0xffffffff),
          headerBackgroundColorOpened: Colors.orangeAccent,
          headerBackgroundColor: Colors.orange,

          content: Container(
            // color: Colors.red,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
                children: (conversation.clients ?? []).map(
              (e) {
                return InkWell(
                  child: Card(
                    elevation: 3,
                    child: ListTile(
                      leading: Icon(
                        Icons.supervised_user_circle,
                        color: Colors.black,
                      ),
                      title: Text("${e.nom}"),
                    ),
                  ),
                  onTap: () {
                    // Navigator.pushReplacement(context, Routes.DiscussionPageRoutes as Route<Object?>);
                    Navigator.popAndPushNamed(
                        context, Routes.DiscussionPageRoutes);
                  },
                );
              },
            ).toList()),
          ),
        ),
      ],
    );
  }
}
