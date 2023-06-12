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
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/empty.gif"),
              SizedBox(height: 20.0),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  showSnackBar(context, "Dans quelques jours il sera disponible");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: Text('En développement'),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: Image.asset(
            "assets/app_icon2.png",
            width: 25,
            height: 25,
          ),
        ),
      ],
    );
  }
  showSnackBar(context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(
      content: Text(message),
      action:
      SnackBarAction(label: 'OK',
          textColor: Colors.orange,
          onPressed: scaffold.hideCurrentSnackBar),
    ));
  }
}



