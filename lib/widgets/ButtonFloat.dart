import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

Widget ButtonFloat(BuildContext context,String nomRoute){
  return SpeedDial(
    backgroundColor: Colors.orange,
    gradientBoxShape: BoxShape.circle,
    buttonSize: Size(50,50),
    overlayColor: Colors.black54,
    animatedIcon: AnimatedIcons.add_event,
    children: [
      SpeedDialChild(
          child: Icon(Icons.share),
          label: "Partager l'Application"
      ),
      SpeedDialChild(
        child: Icon(Icons.add),
        label: "Publier une vente",
        onTap: (){
          Navigator.pushNamed(context, nomRoute);
        },
      ),
    ],
    onOpen: ()=>print("=================== Connecter ou pas "),
  );
}