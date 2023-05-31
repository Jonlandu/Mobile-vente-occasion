import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Message{
  static afficherSnack(BuildContext context, String msg,
      [Color color = Colors.red]) {
    final scaffold = ScaffoldMessenger.of(context);
    var snackbar = SnackBar(
      backgroundColor: color,
      content: Text(msg),
    );
    scaffold.showSnackBar(snackbar);
  }


  static  lancerChargementDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("Traitement en cours..."),
        );
      },
    );
  }

}