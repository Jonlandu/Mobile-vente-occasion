import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:squelette_mobile_parcours/models/ArticleModel.dart';
import '../utils/Constantes.dart';
import '../utils/Request.dart';
import '../utils/StockageKeys.dart';

class ArticleController with ChangeNotifier {
  GetStorage? stockage;
  List<ArticleModel> articles = [];
  bool loading = false;
  bool? isHttpException;

  ArticleController({this.stockage});

  void recuperArticlesAPI() async {
    var url ="${Constantes.articlesEndpoint}";
    loading = true;
    notifyListeners();

    var reponse = await getData(url);
    print("Résultat de la réccupération ${reponse}");

    if(reponse!=null){
      articles=reponse["data"].map<ArticleModel>((e) => ArticleModel.fromJson(e)).toList();
      stockage?.write(StockageKeys.articlesKey, reponse);
      isHttpException=false;
    }else{
      isHttpException=true;
      var datastockee= stockage?.read(StockageKeys.articlesKey);
      var temp= datastockee["data"].map<ArticleModel>((e)=>ArticleModel.fromJson(e)).toList();
      articles = temp;
      print("data satockee :${temp}");
    }
    loading = false;
    notifyListeners();
  }
}

void main() {
  var test = ArticleController();
  test.recuperArticlesAPI();
}
