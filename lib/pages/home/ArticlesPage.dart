import 'package:flutter/material.dart';
import 'package:squelette_mobile_parcours/controllers/CategorieController.dart';
import 'package:provider/provider.dart';
import 'package:squelette_mobile_parcours/controllers/ArticleController.dart';
import 'package:squelette_mobile_parcours/pages/home/widgets/CategoriesWidget.dart';
import 'package:squelette_mobile_parcours/pages/home/widgets/ArtcilesListWidget.dart';
import 'package:squelette_mobile_parcours/pages/home/widgets/NetworkErrorExceptionArticlesWidget.dart';
import 'package:squelette_mobile_parcours/pages/home/widgets/NetworkErrorExceptionCategoriesWidget.dart';
import 'widgets/ArticlesSearchesWidget.dart';

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({Key? key}) : super(key: key);

  @override
  State<ArticlesPage> createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var articleCtrl = context.read<ArticleController>();
      var categorieCtrl = context.read<CategorieController>();
      categorieCtrl.recuperCategorieAPI();
      articleCtrl.recuperArticlesAPI();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      leadingWidth: 0,
      leading: SizedBox(),
      title: Center(
        child: Text(
          "Accueil",
          style: TextStyle(
            color: Colors.black,
            fontSize: 40,
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Widget _body() {
    var articleCtrl = context.watch<ArticleController>();
    var categorieCtrl = context.watch<CategorieController>();

    print("articleCtrl.isHttpException ${articleCtrl.isHttpException}");

    return Stack(
      children: [
        SingleChildScrollView(
            child: Column(
          children: [
            ArticlesSearchesWidget(),
            (categorieCtrl.isHttpException == true)
                ? Center(
                    child: NetworkErrorExceptionCategoriesWidget(),
                  )
                : CategoriesWidget(categories: categorieCtrl.categories),

            (articleCtrl.isHttpException == true)
                ? Center(
                    child: NetworkErrorExceptionArticlesWidget(),
                  )
                : ArticlesListWidget(articles: articleCtrl.articles),
          ],
        )),
      ],
    );
  }
}
