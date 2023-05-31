import 'package:flutter/material.dart';


import 'package:provider/provider.dart';
import 'package:squelette_mobile_parcours/pages/HomePage.dart';
import 'package:squelette_mobile_parcours/pages/RegisterPage.dart';
import 'package:squelette_mobile_parcours/pages/TemplatePage.dart';
import 'package:squelette_mobile_parcours/utils/Constantes.dart';
import '../Controllers/AuthentificationCtrl.dart';
import '../utils/Message.dart';
import '../utils/Routes.dart';
import '../widgets/ChampsSaisie.dart';
import '../widgets/Chargement.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}



class _LoginPageState extends State<LoginPage> {
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
  LoginPressed() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (!formKey.currentState!.validate()) {
      return;
    }
    isVisible = true;

    setState(() {});
    var ctrl = context.read<AuthentificationCtrl>();
    Map datas = {
      "email": username.text,
      "password": password.text
    };
    print(datas);
    var res = await ctrl.login(datas);


    await Future.delayed(Duration(seconds: 4));

    isVisible = false;
    setState(() {});
    print(res.status);
    print("::::::::::::::::::::::${res.data}");
    //res.data?['status_message']=="vous etes connecter"
    if (res.status) {
      res.data?['status_message'];
      //Message.afficherSnack(context, "Authentification reussie", Colors.green);
      await Future.delayed(Duration(seconds: 4));
      setState(() {});

      Navigator.pushReplacementNamed(context, Routes.HomePagePageRoutes);
    } else {
      var msg =
      res.isException == true ? res.errorMsg : (res.data?['message']);
      print("mqg=====!!! : $msg");
      Message.afficherSnack(context, msg);

      print("------------------------${res.data?['message']}");
      print("------------------------${res.isException}");
      print("------------------------${res.errorMsg}");
    }
    return;
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
                  child: Text("Connectez-vous !", style: TextStyle(fontSize: 29,fontWeight: FontWeight.w500,color: Color(0xff000000),height: 1.1725)),
                ),
                SizedBox(
                  height: 20,
                ),
                ChampSaisie(ctrl: username, label: "Adresse Email", required: true),
                SizedBox(
                  height: 15,
                ),
                ChampSaisie(
                    ctrl: password,
                    label: "Mot de passe",
                    required: true,
                    isPassword: true),
                SizedBox(
                  height: 0,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: Text(
                      'Mot de passe oublié?',
                      style: TextStyle(color: Colors.orange,decoration: TextDecoration.underline),
                    ),
                    onPressed: () async {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => HomePage()));
                    },
                  ),
                ),
                _textError(),
                _buttonWidget(context),
                SizedBox(
                  height: 8,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'vous n"avez pas un compte ?',
                    style: TextStyle(color: Colors.black),

                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: TextButton(
                    child: Text(
                      'Enregistrez-vous !',
                      style: TextStyle(color: Colors.orange,decoration: TextDecoration.underline),
                    ),
                    onPressed: () async {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => RegisterPage()));
                    },
                  ),
                ),
                SizedBox(
                  height: 110,
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

  Widget _buttonWidget(BuildContext ctx) {

    return Container(
      width: 500,
      height: 50,
      child: ElevatedButton(
        onPressed: ()=>LoginPressed(),
        child: Text("Connexion"),
        style: ElevatedButton.styleFrom(
            primary: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16))),
      ),
    );
  }

  Widget _textError() {
    return Text(errorMsg, style: TextStyle(color: Colors.red, fontSize: 16));
  }
}