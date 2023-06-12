import 'package:flutter/material.dart';

Widget ButtonFloat(BuildContext context,String nomRoute){
  return FloatingActionButton(
      onPressed: (){
        Navigator.pushNamed(context, nomRoute);
      },
    backgroundColor: Colors.orange,
    child: Icon(Icons.add),
  );
}