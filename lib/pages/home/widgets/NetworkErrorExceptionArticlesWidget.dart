import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Widget NetworkErrorExceptionArticlesWidget() {
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 50,
        ),
        Text(
          "Veuillez Actualiser"
              "",
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        Image.asset(
          "assets/empty.gif",
          height: 150,
          width: 150,
        ),
        Text(
          "Désole, chargement de la liste des articles échouée !",
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
          ),
        ),
        /*ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () {
            Center(child: CircularProgressIndicator());
          },
          child: Text(
            'Actualiser',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
        ),*/
      ],
    ),
  );
}
