import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:squelette_mobile_parcours/models/MessageModel.dart';
import 'package:squelette_mobile_parcours/models/ConversationModel.dart';
import '../utils/Constantes.dart';
import '../utils/Endpoints.dart';
import '../utils/Request.dart';
import '../utils/StockageKeys.dart';

class MessageController with ChangeNotifier {
  GetStorage? stockage;
  List<MessageModel> messages = [];
  bool loading = false;
  bool? isHttpException;

  MessageController({this.stockage});

  void envoyerMessage(Map data) async{
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
  void recevoirListeConversation() async{

    var url ="${Endpoints.CreerConversation}";
    loading = true;
    notifyListeners();

    var reponse = await getData(url, token: Constantes.DefaultToken);
    print("Résultat de la réccupération ${reponse}");

    if(reponse!=null){
      messages=reponse.map<MessageModel>((e) => ConversationModel.fromJson(e)).toList();
      stockage?.write(StockageKeys.tokenyKey, reponse);
      isHttpException=false;
      notifyListeners();
    }else{
      isHttpException=true;
      var datastockee= stockage?.read(StockageKeys.tokenyKey);
      var temp= datastockee.map<MessageModel>((e)=>ConversationModel.fromJson(e)).toList;
      messages = temp;
      print("data stocké :${temp}");
    }
    loading = false;
    notifyListeners();

  }
  void recevoirListeMessage() async{
    var url ="${Endpoints.EnvoyerMessage}";
    loading = true;
    notifyListeners();

    var reponse = await getData(url, token: Constantes.DefaultToken);
    print("Résultat de la réccupération ${reponse}");

    if(reponse!=null){
      messages=reponse.map<MessageModel>((e) => MessageModel.fromJson(e)).toList();
      stockage?.write(StockageKeys.tokenyKey, reponse);
      isHttpException=false;
      notifyListeners();
    }else{
      isHttpException=true;
      var datastockee= stockage?.read(StockageKeys.tokenyKey);
      var temp= datastockee.map<MessageModel>((e)=>MessageModel.fromJson(e)).toList;
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
  //test.EnvoyerMessage({"conversation_id":1,"content":"bonsoirtrrrr"});
  //test.recevoirListeMessage();
  test.recevoirListeConversation();
}
