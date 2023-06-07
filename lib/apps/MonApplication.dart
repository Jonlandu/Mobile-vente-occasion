import 'package:flutter/material.dart';
import 'package:squelette_mobile_parcours/Controllers/AuthentificationCtrl.dart';
import '../controllers/ArticleController.dart';
import '../controllers/CategorieController.dart';
import '../controllers/UserCtrl.dart';
import '../utils/RoutesManager.dart';
import 'package:provider/provider.dart';
import '../utils/Routes.dart';
import 'package:get_storage/get_storage.dart';

class MonApplication extends StatelessWidget {

  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ArticleController(stockage: box)),
        ChangeNotifierProvider(create: (_) => CategorieController(stockage: box)),
        ChangeNotifierProvider(create: (_) => UserCtrl(stockage: box)),
        ChangeNotifierProvider(create: (_) => AuthentificationCtrl(stockage: box)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RoutesManager.route,
        initialRoute: Routes.BienvenuePageRoutes,
      ),
    );
  }
}
