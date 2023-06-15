import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:squelette_mobile_parcours/models/ConversationModel.dart';
import 'package:squelette_mobile_parcours/models/UserModel.dart';
import '../utils/Endpoints.dart';
import '../utils/Request.dart';
import '../utils/StockageKeys.dart';

class ConversationController with ChangeNotifier {
  GetStorage? stockage;
  List<ConversationModel> conversations = [];
  List<UserModel> usersConversations = [];
  bool loading = false;
  bool? isHttpException;

  ConversationController({this.stockage});

  creerConversationApi(Map data) async {
    var url = Endpoints.CreerConversation;
    var tkn = stockage?.read(StockageKeys.tokenyKey);
    var reponse = await postData(url, data, token: tkn);
    print("Resultat ${reponse.data}");
  }


  Future<String> recupererNomUser() async {
    var url = Endpoints.detailUser;
    loading = true;
    notifyListeners();
    var tkn = stockage?.read(StockageKeys.tokenyKey);
    var reponse = await getData(url, token: tkn);

    if (reponse != null) {
      //print("======================== ARTICLE ::::: ${reponse['title']}");

      var articleNom = reponse['title'];
      return articleNom;
    }
    return reponse;
  }

  void recevoirListeConversation() async {
    var url = "${Endpoints.CreerConversation}";
    loading = true;
    notifyListeners();
    var token = stockage?.read(StockageKeys.tokenyKey);
    print("token::::$token");

    var reponse = await getData(url, token: token);
    // print("============================================${reponse['clients']}");
    print("Résultat de la réccupération ${reponse}");

    if (reponse != null) {
      conversations = reponse
          .map<ConversationModel>((e) => ConversationModel.fromJson(e))
          .toList();
      //usersConversations = reponse['clients'].map<ConversationModel>((e)=> ConversationModel.fromJson(e)).toList();


      //stockage?.write(StockageKeys.tokenyKey, reponse);
      isHttpException = false;
      notifyListeners();
    } else {
      isHttpException = true;
      //var datastockee= stockage?.read(StockageKeys.tokenyKey);
      //var temp= datastockee.map<ConversationModel>((e)=>ConversationModel.fromJson(e)).toList;
      //conversations = temp;
      //print("data stocké :${temp}");
    }
    loading = false;
    notifyListeners();
  }

}

void main() {
  var test = ConversationController();
  //test.RecevoirListeMessage();
  //test.creerConversationApi({"article_id":2,"user_id":2});
  //test.recevoirListeMessage();
  test.recevoirListeConversation();
}
