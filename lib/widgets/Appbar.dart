import 'package:flutter/material.dart';

AppBar appBar(String titre, {Color? bgcolor} ) {
  return AppBar(
    automaticallyImplyLeading: false,
    centerTitle: true ,
    title: Text(titre,
      style: TextStyle(
          color: Colors.black,
          fontSize: 32
      ),
    ),
    backgroundColor: bgcolor==null? Colors.transparent: bgcolor,
    elevation: 0,
    actions: [

    ],
  );
}