import 'package:flutter/material.dart';
import 'package:squelette_mobile_parcours/pages/home/ArticlesPage.dart';

import 'Routes.dart';

class RoutesManager {
  static Route route(RouteSettings r) {
    switch (r.name) {
      case Routes.TemplateRoutes:
        //var args=r.arguments as String?;
        return MaterialPageRoute(builder: (_) => ArticlesPage());

      default:
        return MaterialPageRoute(builder: (_) => ArticlesPage());
    }
  }
}
