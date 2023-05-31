
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:squelette_mobile_parcours/utils/Constantes.dart';
import '../Models/AuthentificationModel.dart';
import '../utils/requetes.dart';
import 'package:get_storage/get_storage.dart';



class AuthentificationCtrl with ChangeNotifier {

  AuthentificationCtrl({this.stockage});

  String? token;
  AuthentificationModel? user;
  GetStorage? stockage;

  List<AuthentificationModel> auth = [];
  bool loading = false;//gestion de cas d'erreur



  Future<HttpResponse>login(Map data) async{
    var url="${Constantes.authentificationEndpoint}";
    HttpResponse response = await postData(url, data);
    if(response.status){
      // if(response!= null/){
      user=AuthentificationModel.fromJson(response.data?['user'] ?? {});
      stockage?.write("user", response.data?["data"] ?? {});
      stockage?.write("TOKEN", response.data?["TOKEN"]?? "");
      notifyListeners();
    }
    print(response.data);
    return response;


  }

  //recuperer api
  void recuperDataAPI() async{
    var url=Uri.parse("${Constantes.BASE_URL}${Constantes.authentificationEndpoint}");
    loading=true;
    notifyListeners();
    var reponse= await http.get(url);
    print(reponse.runtimeType);
    print(reponse.body.runtimeType);
    print(reponse.body); // contient le resultat de la reponse
    print(reponse.statusCode); // contient le code http
    loading=false;
    notifyListeners();

  }

}