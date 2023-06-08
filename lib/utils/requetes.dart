import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Constantes.dart';

class HttpResponse{
  bool status;
  Map?  data;
  String? errorMsg;
  bool? isException;
  HttpResponse({this.data, required this.status, this.errorMsg, this.isException});
}

Future<dynamic> getData(String url_api) async{

  try {
    var url = Uri.parse(url_api);
    var response = await http.get(url);
    print(response.runtimeType); // Les types de données
    print(response.body.runtimeType); // Les types de données
    print(response.body); // Les resultats de la reponse
    print(response.statusCode); // contient le code de http
    if(response.statusCode==200){
      return json.decode(response.body);
    }
    return null;
  }catch(e, trace){
    print(e.toString());
    print(trace.toString());
    return null;
  }

}

Future<HttpResponse> postData(String api_url, Map data) async{
  try{

    var url=Uri.parse("${Constantes.BASE_URL}$api_url");
    String dataStr=json.encode(data);
    var response=await http.post(url, body: dataStr, headers: {"Content-Type":"application/json"}).timeout(Duration(seconds: 5)) ;
    var successList=[200, 201];
    var msg=json.decode(response.body);
    var st=successList.contains(response.statusCode);
    if(response.statusCode==500) throw Exception(msg);

    return  HttpResponse(status: st, data: msg);// {"status": st, "msg": msg};
    // return null;
  }catch(e, trace){
    print(e.toString());
    print(trace.toString());
    // return null;
    //return {"status": false, "error_msg": };
    return  HttpResponse(status: false, errorMsg: "Erreur inattendue, Problème de connexion", isException: true);// {"status": st, "msg": msg};

  }


}