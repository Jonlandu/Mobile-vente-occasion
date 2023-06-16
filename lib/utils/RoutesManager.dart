import 'package:flutter/material.dart';
import 'package:squelette_mobile_parcours/models/ArticleModel.dart';
import 'package:squelette_mobile_parcours/pages/connexion/RegisterPage.dart';
import 'package:squelette_mobile_parcours/pages/Articles/ArticlesPage.dart';
import '../pages/Articles/ArticleCreatePage.dart';
import '../pages/Articles/ArticleDetailsPage.dart';
import 'package:squelette_mobile_parcours/pages/user/DashboardPage.dart';
import 'package:squelette_mobile_parcours/pages/welcome/PreferencePage.dart';
import 'package:squelette_mobile_parcours/pages/home/HomePage.dart';
import 'package:squelette_mobile_parcours/pages/connexion/LoginPage.dart';
import 'package:squelette_mobile_parcours/pages/welcome/BienvenuPage.dart';

import 'Routes.dart';

class RoutesManager {
  static Route? route(RouteSettings r) {
    switch (r.name) {
      case Routes.ArticlesPageRoutes:
        return MaterialPageRoute(builder: (_) => ArticlesPage());

      case Routes.ArticlesDetailsPageRoutes:
        var args=r.arguments as Map?;
        var articlechoosed = {};
        var articleData=ArticleModel.fromJson(args ?? articlechoosed);
        return MaterialPageRoute(builder: (_)=> ArticleDetailsPage(article: articleData));

      case Routes.CreateArticleSellPageRoutes:
        return MaterialPageRoute(builder: (_)=> ArticleCreatePage());


      case Routes.DashboardPageRoutes:
      //var args=r.arguments as String?;
        return MaterialPageRoute(builder: (_) => DashboardPage());
      case Routes.LoginPageRoutes:
      //var args=r.arguments as String?;
        return MaterialPageRoute(builder: (_) => LoginPage());
      case Routes.BienvenuePageRoutes:
      //var args=r.arguments as String?;
        return MaterialPageRoute(builder: (_) => BienvenuPage());
      case Routes.PreferencePageRoutes:
      //var args=r.arguments as String?;
        return MaterialPageRoute(builder: (_) => PreferencePage());
      case Routes.RegisterPageRoutes:
        return MaterialPageRoute(builder: (_)=> RegisterPage());
      case '/':
      // don't generate route on start-up
        return null;
      default:
        return MaterialPageRoute(builder: (_) => HomePage());
    }
  }
}
