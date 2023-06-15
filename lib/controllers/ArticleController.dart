import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:squelette_mobile_parcours/models/ArticleModel.dart';
import '../utils/Endpoints.dart';
import '../utils/Request.dart';
import '../utils/StockageKeys.dart';

class ArticleController with ChangeNotifier {
  GetStorage? stockage;
  List<ArticleModel> articles = [];
  List<ArticleModel> annoncesSimilaire = [];
  bool loading = false;
  bool? isHttpException;

  ArticleController({this.stockage});

  void recuperArticlesAPI() async {
    var url = "${Endpoints.articlesEndpoint}";
    loading = true;
    notifyListeners();
    var reponse = await getData(url);

    if(reponse!=null){
      print(reponse['data']);
      articles=reponse["data"].map<ArticleModel>((e) => ArticleModel.fromJson(e)).toList();
      isHttpException = false;
    }/*else{
      isHttpException = true;
      var datastockee = stockage?.read(StockageKeys.articlesKey);
      var for_a_time_data = datastockee["data"].map<ArticleModel>((e)=>ArticleModel.fromJson(e)).toList();
      articles = for_a_time_data;
      print("data satockee :${for_a_time_data}");
    }*/
    loading = false;
    notifyListeners();
  }

  Future<HttpResponse> envoieDataArticleCree(Map data,List<File> images) async {
    var url = "${Endpoints.createPublicationEndpoint}";

    String? token=stockage?.read(StockageKeys.tokenKey);

    HttpResponse reponse = await postData(url, data, token: token);

    if (reponse.status) {
      print("Réponse Brut : ${reponse.data?['id']}");
      var article = ArticleModel.fromJson(reponse.data?['article'] ?? {});
      articles.add(article);

      var endpoint = Endpoints.createImagesPublicationEndpoint.replaceAll("{id}", reponse.data?['id']);
      postDataWithFile(endpoint, images.map((e) => e.path).toList(), token: token);
      print("==================IMAGES ${images.map((e) => e.path)}");
    }
    return reponse;
  }
  void recuperAnnoncesSimilaireAPI() async {
    var url = "${Endpoints.annoncesSimilaireEndpoint}";
    loading = true;
    notifyListeners();

    var reponse = await getData(url);

    if (reponse != null) {
      annoncesSimilaire = reponse["data"]
          .map<ArticleModel>((e) => ArticleModel.fromJson(e))
          .toList();
      stockage?.write(StockageKeys.annoncesSimilaireKey, reponse);
      isHttpException = false;
    } else {
      isHttpException = true;
      var datastockee = stockage?.read(StockageKeys.annoncesSimilaireKey);
      var for_a_time_data = datastockee["data"].map<ArticleModel>((e) =>
          ArticleModel.fromJson(e)).toList();
      articles = for_a_time_data;
    }
    loading = false;
    notifyListeners();
  }
}
