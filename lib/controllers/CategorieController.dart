import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../models/CategorieModel.dart';
import '../utils/Constantes.dart';
import '../utils/Request.dart';
import '../utils/StockageKeys.dart';

class CategorieController with ChangeNotifier {
  GetStorage? stockage;
  List<CategorieModel> categories = [];
  bool loading = false;
  bool? isHttpException;

  CategorieController({this.stockage});

  void recuperCategorieAPI() async {
    var url ="${Constantes.categoriesEndpoint}";
    loading = true;
    notifyListeners();

    var reponse = await getData(url);
    //print("Résultat de la réccupération ${reponse}");

    if(reponse!=null){
      categories=reponse["data"].map<CategorieModel>((e) => CategorieModel.fromJson(e)).toList();
      stockage?.write(StockageKeys.categoriesKey, reponse);
      isHttpException=false;
      notifyListeners();
    }else{
      isHttpException=true;
      var datastockee= stockage?.read(StockageKeys.categoriesKey);
      var temp= datastockee["data"].map<CategorieModel>((e)=>CategorieModel.fromJson(e)).toList;
      categories = temp;
      print("data satockee :${temp}");
    }
    loading = false;
    notifyListeners();
  }
}

void main() {
  var test = CategorieController();
  test.recuperCategorieAPI();
}
