
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:squelette_mobile_parcours/models/TagModel.dart';
import 'package:squelette_mobile_parcours/utils/Endpoints.dart';
import 'package:squelette_mobile_parcours/utils/Request.dart';

import '../utils/StockageKeys.dart';

class TagCtrl with ChangeNotifier {
  GetStorage? stockage;
  List<TagModel> listeTags = [];
  bool loading = false;

  TagCtrl({this.stockage});


  void recupererTags() async {
    var url =Endpoints.tags;
    loading = true;
    notifyListeners();
    var reponse = await getData(url);
    if(reponse!=null){
      listeTags=reponse.map<TagModel>((e) => TagModel.fromJson(e)).toList();
      //stockage?.write(StockageKeys.tags, reponse);
      notifyListeners();
      for (var value in listeTags){
        print("================ VALUE ${value.nom}");
      }
    }
    loading = false;
    notifyListeners();
  }

  Future<HttpResponse> envoiePreference(Map data) async{
    var url="${Endpoints.preference}";
    var tkn = stockage?.read(StockageKeys.tokenKey);
    HttpResponse response = await postData(url, data, token: tkn);
    if(response.status){
      // if(response!= null/){
      //user=AuthentificationModel.fromJson(response.data?['user'] ?? {});
      //stockage?.write("user", response.data?["data"] ?? {});
      //stockage?.write(StockageKeys.tokenyKey, response.data?["token"]?? "");
      notifyListeners();
    }
    print(response.data);
    return response;


  }

}

void main(){
  var test = TagCtrl();
  Map data={
    "preference":['voiture', 'habit', 'phone'],
    "user_id":1
  };
  test.envoiePreference(data);
  print("================================");
}