import 'package:flutter/material.dart';
// import 'package:squelette_mobile_parcours/pages/HomePage.dart';
import 'package:squelette_mobile_parcours/pages/home/ArticlesPage.dart';
//import 'package:squelette_mobile_parcours/pages/messageExemple.dart';
import '../pages/DiscussionPage.dart';
import '../pages/ListeArticle.dart';
import '../pages/TemplatePage.dart';
import 'package:squelette_mobile_parcours/models/ArticleModel.dart';
import 'package:squelette_mobile_parcours/pages/home/ArticlesPage.dart';
import '../pages/createArticle/CreateArticleSellPage.dart';
import '../pages/detailsArticle/ArticlesDetailsPage.dart';
import 'package:squelette_mobile_parcours/pages/DashboardPage.dart';
import 'package:squelette_mobile_parcours/pages/HomePage.dart';
import 'package:squelette_mobile_parcours/pages/LoginPage.dart';


import 'Routes.dart';

class RoutesManager {
  static Route route(RouteSettings r) {
    switch (r.name) {
      case Routes.ArticlesPageRoutes:
        return MaterialPageRoute(builder: (_) => ArticlesPage());
      case Routes.ListeArticleRoutes:
       return MaterialPageRoute(builder: (_)=> ListeArticle());
      case Routes.DiscussionPageRoutes:
        return MaterialPageRoute(builder: (_)=> DiscussionPagePage());


      case Routes.ArticlesDetailsPageRoutes:
        var args=r.arguments as Map?;
        var articlechoosed = {};
        var articleData=ArticleModel.fromJson(args ?? articlechoosed);
        return MaterialPageRoute(builder: (_)=> ArticlesDetailsPage(article: articleData));

      case Routes.CreateArticleSellPageRoutes:
        return MaterialPageRoute(builder: (_)=> CreateArticleSellPage());


      case Routes.DashboardPageRoutes:
      //var args=r.arguments as String?;
        return MaterialPageRoute(builder: (_) => DashboardPage());
      case Routes.LoginPageRoutes:
      //var args=r.arguments as String?;
        return MaterialPageRoute(builder: (_) => LoginPage());

      default:
        return MaterialPageRoute(builder: (_) => TemplatePage());
    }
  }
}
