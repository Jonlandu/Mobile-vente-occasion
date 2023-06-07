import 'package:flutter/material.dart';
// import 'package:squelette_mobile_parcours/pages/HomePage.dart';
import 'package:squelette_mobile_parcours/pages/home/ArticlesPage.dart';
//import 'package:squelette_mobile_parcours/pages/messageExemple.dart';
import '../pages/DiscussionPage.dart';
import '../pages/ListeArticle.dart';
import '../pages/TemplatePage.dart';

import 'Routes.dart';

class RoutesManager {
  static Route route(RouteSettings r) {
    switch (r.name) {
      case Routes.TemplateRoutes:
        //var args=r.arguments as String?;
        return MaterialPageRoute(builder: (_) => ArticlesPage());
      case Routes.ListeArticleRoutes:
       return MaterialPageRoute(builder: (_)=> ListeArticle());
      case Routes.DiscussionPageRoutes:
        return MaterialPageRoute(builder: (_)=> DiscussionPagePage());
      default:
        return MaterialPageRoute(builder: (_) => TemplatePage());
    }
  }
}
