import 'package:flutter/material.dart';


import 'package:provider/provider.dart';
import 'package:squelette_mobile_parcours/Controllers/AuthentificationCtrl.dart';
import 'package:squelette_mobile_parcours/pages/LoginPage.dart';
import 'package:squelette_mobile_parcours/pages/TemplatePage.dart';
import '../controllers/AuthentificationCtrl.dart';
import '../widgets/ChampsSaisie.dart';
import '../widgets/Chargement.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Color couleurFond = Colors.white;

  String errorMsg = "";
  bool isVisible = false;
  var formKey = GlobalKey<FormState>();
  var username = TextEditingController();
  var password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: couleurFond,
      body: Stack(
        children: [_body(context), Chargement(isVisible)],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Form(
      key: formKey,
      child: Center(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text("Bienvenu(e) !", style: TextStyle(fontSize: 29,fontWeight: FontWeight.w500,color: Color(0xff000000),height: 1.1725)),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text("Créer un compte ", style: TextStyle(fontSize: 29,fontWeight: FontWeight.w500,color: Color(0xff000000),height: 1.1725)),
                ),
                SizedBox(
                  height: 20,
                ),
                ChampSaisie(ctrl: username, label: "Nom complet", required: true),
                SizedBox(
                  height: 15,
                ),
                ChampSaisie(ctrl: username, label: "Email", required: true),
                SizedBox(
                  height: 15,
                ),
                ChampSaisie(
                    ctrl: password,
                    label: "Mot de passe",
                    required: true,
                    isPassword: true),
                SizedBox(
                  height: 15,
                ),
                ChampSaisie(
                    ctrl: password,
                    label: "Confirmer le Mot de passe",
                    required: true,
                    isPassword: true),
                SizedBox(
                  height: 0,
                ),
                _textError(),
                SizedBox(
                  height: 8,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'vous avez un compte ?',
                    style: TextStyle(color: Colors.black),

                  ),
                ),
                SizedBox(
                  height: 1,
                ),
                Container(
                  alignment: Alignment.center,
                  child: TextButton(
                    child: Text(
                      'Connectez-vous !',
                      style: TextStyle(color: Colors.orange,decoration: TextDecoration.underline,fontSize: 16,fontWeight: FontWeight.w500),
                    ),
                    onPressed: () async {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => LoginPage()));
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconApp() {
    return Icon(
      Icons.home,
      size: 50,
      color: Colors.orange,
    );
  }


  Widget _textError() {
    return Text(errorMsg, style: TextStyle(color: Colors.red, fontSize: 16));
  }
}