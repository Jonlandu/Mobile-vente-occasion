import 'package:flutter/material.dart';

AppBar appBar(String titre, {Color? bgcolor} ) {
  return AppBar(
    centerTitle: true ,
    title: Text(titre,
      style: TextStyle(
          color: Colors.black,
          fontSize: 32
      ),
    ),
    leading: Icon(Icons.arrow_back, color: Colors.black,),
    backgroundColor: bgcolor==null? Colors.transparent: bgcolor,
    elevation: 0,
    actions: [

    ],
  );
}