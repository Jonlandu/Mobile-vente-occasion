import 'package:flutter/material.dart';


import 'package:provider/provider.dart';
import '../../controllers/AuthentificationCtrl.dart';
import '../../utils/Message.dart';
import '../../utils/Routes.dart';
import '../../widgets/ChampsSaisie.dart';
import '../../widgets/Chargement.dart';

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
      backgroundColor: Colors.grey[300],
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
    Map data = {
      "email": username.text,
      "password": password.text
    };
    print(data);
    var res = await ctrl.login(data);


    await Future.delayed(Duration(seconds: 1));

    isVisible = false;
    setState(() {});
    print(res.status);
    print("::::::::::::::::::::::${res.data}");
    //res.data?['status_message']=="vous etes connecter"
    if (res.status) {
      res.data?['status_message'];
      //Message.afficherSnack(context, "Authentification reussie", Colors.green);
      await Future.delayed(Duration(seconds: 1));
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
      child: Stack(
        children: [
          Center(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.lock, size: 100,),
                    SizedBox(height: 20,),
                    Container(
                      alignment: Alignment.center,
                      child: Text("Connectez-vous ", style: TextStyle(fontSize: 29,fontWeight: FontWeight.w500,color: Color(0xff000000),height: 1.1725)),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      'Content de vous retrouver encore !',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                      ),
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
                        onPressed: () {
                          showSnackBar(context, "Bientôt disponible !");
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
                        'vous n\'avez pas un compte ?',
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
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, Routes.RegisterPageRoutes);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.grey[400],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              'Ou connectez-vous avec',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        // google button
                        square(imagePath: 'assets/google.png'),

                        SizedBox(width: 25),

                        // apple button
                        square(imagePath: 'assets/facebook.png')
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Image.asset(
              "assets/app_icon2.png",
              width: 25,
              height: 25,
            ),
          ),
        ],
      ),
    );
  }
  Widget square({String? imagePath}){
    return InkWell(
      onTap: (){
        showSnackBar(context,"Encore en développement ");
      },
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey[200],
        ),
        child: Image.asset(
          imagePath!,
          height: 40,
        ),
      ),
    );
  }

  showSnackBar(context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(
      content: Text(message),
      action:
      SnackBarAction(label: 'OK',
          textColor: Colors.orange,
          onPressed: scaffold.hideCurrentSnackBar),
    ));
  }

  Widget _buttonWidget(BuildContext ctx) {

    return Container(
      width: 500,
      height: 50,
      child: ElevatedButton(
        onPressed: ()=>LoginPressed(),
        child: Text("Connexion", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black
        ),
      ),
    );
  }

  Widget _textError() {
    return Text(errorMsg, style: TextStyle(color: Colors.red, fontSize: 16));
  }
}