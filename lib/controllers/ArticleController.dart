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
  List<ArticleModel> articlesSearched = [];
  var detailarticles;
  List<ArticleModel> annoncesSimilaire = [];
  bool loading = false;
  bool? isHttpException;

  ArticleController({this.stockage});

  void recuperArticlesAPI() async {
    var url = "${Endpoints.articlesEndpoint}";
    loading = true;
    notifyListeners();
    var reponse = await getData(url);

    if(reponse!=null && reponse != []){
      articles=reponse["data"].map<ArticleModel>((e) => ArticleModel.fromJson(e)).toList();
      isHttpException = false;
    }else{
      isHttpException = true;
      var datastockee = stockage?.read(StockageKeys.articlesKey);
      var for_a_time_data = datastockee["data"].map<ArticleModel>((e)=>ArticleModel.fromJson(e)).toList();
      articles = for_a_time_data;
    }
    loading = false;
    notifyListeners();
  }

  void recuperDetailsArticlesAPI(articleId) async {
    var urlWithArticleId = Endpoints.articlesShowEndpoint.replaceAll("{id}", articleId.toString());
    var url = "${urlWithArticleId}";
    loading = true;
    notifyListeners();
    var reponse = await getData(url);

    if(reponse!=null){
      detailarticles=ArticleModel.fromJson(reponse);
      isHttpException = false;
    }else{
      isHttpException = true;
      //var datastockee = stockage?.read(StockageKeys.articlesKey);
      var for_a_time_data = ArticleModel.fromJson(reponse ?? {});
      detailarticles = for_a_time_data;
    }
    loading = false;
    notifyListeners();
  }

  Future<HttpResponse> envoieDataArticleCree(Map data,List<File> images) async {
    var url = "${Endpoints.createArticlePublicationEndpoint}";

    String? token=stockage?.read(StockageKeys.tokenKey);

    HttpResponse reponse = await postData(url, data, token: token);
    if (reponse.status) {
      var article = ArticleModel.fromJson(reponse.data?['article'] ?? {});
      articles.add(article);

      var endpoint = Endpoints.createImagesPublicationEndpoint.replaceAll("{id}", reponse.data?['id']);
      postDataWithFile(endpoint, images.map((e) => e.path).toList(), token: token);
    }
    return reponse;
  }

  Future<HttpResponse> deleteArticleSelected(int? articleId) async {
    var endpoint = Endpoints.deleteArticlesEndpoint.replaceAll("{id}", articleId.toString());
    var token = stockage?.read(StockageKeys.tokenKey);
    loading = true;
    notifyListeners();

    HttpResponse reponse = await deleteData(endpoint, token: token);
    return reponse;
  }

  Future<HttpResponse> updateArticlesCreated(articleId, Map data, List<File> images) async {
    var endpoint = Endpoints.updateArticlePublicationEndpoint.replaceAll("{id}", articleId.toString());
    print("Voici mon URL UPDATE $endpoint");
    var token = stockage?.read(StockageKeys.tokenKey);

    HttpResponse reponse = await updateData(endpoint, data, token: token);
    if (reponse.status) {
      var article = ArticleModel.fromJson(reponse.data?['article'] ?? {});
      articles.add(article);

      var endpoint = Endpoints.createImagesPublicationEndpoint.replaceAll("{id}", articleId.toString());
      postDataWithFile(endpoint, images.map((e) => e.path).toList(), token: token);
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

  Future<List<ArticleModel>> recuperArticlesSearched(String query) async {
    var endpoint = Endpoints.articlesSearchEndpoint.replaceAll("{keyWord}", query);
    loading = true;
    notifyListeners();
    var token = stockage?.read(StockageKeys.tokenKey);
    var reponse = await ArticleSearch(endpoint, token: token);

    if (reponse != null && reponse.isNotEmpty) {
      articlesSearched = reponse.map<ArticleModel>((e) => ArticleModel.fromJson(e)).toList();
      isHttpException = false;
    } else {
      isHttpException = true;
      var datastockee = stockage?.read(StockageKeys.articlesKey);
      var for_a_time_data = datastockee?.map<ArticleModel>((e) => ArticleModel.fromJson(e)).toList() ?? [];
      articlesSearched = for_a_time_data;
    }
    loading = false;
    notifyListeners();
    return articles;
  }
}
