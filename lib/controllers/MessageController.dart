import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart';
import 'package:squelette_mobile_parcours/models/MessageModel.dart';
import 'package:squelette_mobile_parcours/models/ConversationModel.dart';
import '../utils/Constantes.dart';
import '../utils/Endpoints.dart';
import '../utils/Request.dart';
import '../utils/StockageKeys.dart';
import 'package:http/http.dart' as http;

class MessageController with ChangeNotifier {
  GetStorage? stockage;
  List<MessageModel> messages = [];
  bool loading = false;
  bool? isHttpException;

  MessageController({this.stockage});

  void EnvoyerMessage(Map data) async{
    var url = Endpoints.EnvoyerMessage;
    var tkn = stockage?.read(StockageKeys.tokenyKey);
    var reponse = await postData(url, data,token:tkn );
    print("Resultat ${reponse.data}");
  }
  creerConversationApi(Map data)async{
    var url = Endpoints.CreerConversation;
    var tkn = stockage?.read(StockageKeys.tokenyKey);
    var reponse = await postData(url, data,token:tkn );
    print("Resultat ${reponse.data}");
  }
  void RecevoirListeConversation() async{

    var url ="${Endpoints.ListeConversation}";
    loading = true;
    notifyListeners();

    var reponse = await getData(url);
    print("Résultat de la réccupération ${reponse}");

    if(reponse!=null){
      messages=reponse["data"].map<ConversationModel>((e) => ConversationModel.fromJson(e)).toList();
      stockage?.write(StockageKeys.ListeConversationKey, reponse);
      isHttpException=false;
      notifyListeners();
    }else{
      isHttpException=true;
      var datastockee= stockage?.read(StockageKeys.ListeConversationKey);
      var temp= datastockee["data"].map<MessageModel>((e)=>ConversationModel.fromJson(e)).toList;
      messages = temp;
      print("data stocké :${temp}");
    }
    loading = false;
    notifyListeners();

  }
  void RecevoirListeMessage() async{
    var url ="${Endpoints.ListeMessage}";
    loading = true;
    notifyListeners();

    var reponse = await getData(url, token: Constantes.DefaultToken);
    print("Résultat de la réccupération ${reponse}");

    if(reponse!=null){
      messages=reponse["data"].map<MessageModel>((e) => MessageModel.fromJson(e)).toList();
      stockage?.write(StockageKeys.RecevoirListeMessagekey, reponse);
      isHttpException=false;
      notifyListeners();
    }else{
      isHttpException=true;
      var datastockee= stockage?.read(StockageKeys.RecevoirListeMessagekey);
      var temp= datastockee["data"].map<MessageModel>((e)=>MessageModel.fromJson(e)).toList;
      messages = temp;
      print("data stocké :${temp}");
    }
    loading = false;
    notifyListeners();
  }
}

void main() {
  var test = MessageController();
  //test.RecevoirListeMessage();
  //test.creerConversationApi({"article_id":2,"user_id":1});
  test.EnvoyerMessage({"conversation_id":1,"content":"bonsoirtrrrr"});
}
