import 'package:flutter/material.dart';
import 'package:squelette_mobile_parcours/pages/ListeConversationPage.dart';
// import 'package:squelette_mobile_parcours/pages/HomePage.dart';
import 'package:squelette_mobile_parcours/pages/home/ArticlesPage.dart';
//import 'package:squelette_mobile_parcours/pages/messageExemple.dart';
import '../pages/DiscussionPage.dart';
import '../pages/TemplatePage.dart';
import 'package:squelette_mobile_parcours/models/ArticleModel.dart';
import 'package:squelette_mobile_parcours/pages/home/ArticlesPage.dart';
import '../pages/createArticle/CreateArticleSellPage.dart';
import '../pages/detailsArticle/ArticlesDetailsPage.dart';
import 'package:squelette_mobile_parcours/pages/DashboardPage.dart';
import 'package:squelette_mobile_parcours/pages/PreferencePage.dart';
import 'package:squelette_mobile_parcours/pages/HomePage.dart';
import 'package:squelette_mobile_parcours/pages/LoginPage.dart';
import 'package:squelette_mobile_parcours/pages/home/ArticlesPage.dart';
import 'package:squelette_mobile_parcours/pages/BienvenuPage.dart';


import 'Routes.dart';

class RoutesManager {
  static Route? route(RouteSettings r) {
    switch (r.name) {
      case Routes.ArticlesPageRoutes:
        return MaterialPageRoute(builder: (_) => ArticlesPage());
      case Routes.ListeArticleRoutes:
       return MaterialPageRoute(builder: (_)=> ListeConversationPage());
      case Routes.DiscussionPageRoutes:
        return MaterialPageRoute(builder: (_)=> DiscussionPage());


      case Routes.ArticlesDetailsPageRoutes:
        var args=r.arguments as Map?;
        var articlechoosed = {};
        var articleData=ArticleModel.fromJson(args ?? articlechoosed);
        return MaterialPageRoute(builder: (_)=> ArticlesDetailsPage(article: articleData));

      case Routes.CreateArticleSellPageRoutes:
        return MaterialPageRoute(builder: (_)=> CreateArticleSellPage());

      case Routes.diaRoutes:
        return MaterialPageRoute(builder: (_)=> Dialog());


      case Routes.DashboardPageRoutes:
      //var args=r.arguments as String?;
        return MaterialPageRoute(builder: (_) => DashboardPage());
      case Routes.LoginPageRoutes:
      //var args=r.arguments as String?;
        return MaterialPageRoute(builder: (_) => LoginPage());
      case Routes.BienvenuePageRoutes:
      //var args=r.arguments as String?;
        return MaterialPageRoute(builder: (_) => BienvenuPage());
      case Routes.PreferencePagePageRoutes:
      //var args=r.arguments as String?;
        return MaterialPageRoute(builder: (_) => PreferencePage());
      case '/':
      // don't generate route on start-up
        return null;
      default:
        return MaterialPageRoute(builder: (_) => HomePage());
    }
  }
}
