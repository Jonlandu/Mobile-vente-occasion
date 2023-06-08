import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:squelette_mobile_parcours/models/UserModel.dart';
import 'package:squelette_mobile_parcours/utils/Endpoints.dart';
import 'package:squelette_mobile_parcours/utils/StockageKeys.dart';
import '../utils/requette.dart';

class UserCtrl with ChangeNotifier {
  UserModel? user;
  bool loading = false;
  bool logout=false;
  GetStorage? stockage;

  UserCtrl({this.stockage});


  void recuperDataAPI() async {
    var token=stockage?.read(StockageKeys.tokenyKey) ;
    var url =Endpoints.detailUserEndpoint;
    loading = true;
    notifyListeners();
    var reponse = await getData(url, token: token);
    if(reponse!=null){
     user= UserModel.fromJson(reponse['user']);
      notifyListeners();

    }

    loading = false;
    notifyListeners();
  }


}

void main() {
  var f = UserCtrl();
  f.recuperDataAPI();
}