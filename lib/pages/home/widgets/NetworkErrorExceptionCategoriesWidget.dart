import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Widget NetworkErrorExceptionCategoriesWidget() {
  return Container(
    height: 40,
    margin: EdgeInsets.symmetric(vertical: 15),
    child: Row(
      children: [
        InkWell(
          onTap: (){
            Center(child: CircularProgressIndicator());
          },
          child: Row(
            children: [
              Icon(
                Icons.refresh,
                color: Colors.black,
                size: 25,
              ),
              SizedBox(width: 8,),
              Text(
                  "Veuillez actualiser..."
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
