import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class dialogue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: 'Cliquez ici pour ',
        children: [
          TextSpan(
            text: 'voir un exemple',
            style: TextStyle(
              color: Colors.blue,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Exemple'),
                      content: Text('Ceci est un exemple de boîte de dialogue'),
                      actions: [
                        TextButton(
                          child: Text('Fermer'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    );
                  },
                );
              },
          ),
        ],
      ),
    );
  }
}