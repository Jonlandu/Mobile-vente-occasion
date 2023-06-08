import 'package:flutter/material.dart';

import '../widgets/Appbar.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      appBar: appBar('Messages'),
    );
  }

  Widget _body(){
    return Stack( children: [
      SingleChildScrollView(child: Column(children: [],))
    ],);
  }
}



