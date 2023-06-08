import 'package:flutter/material.dart';
import 'package:squelette_mobile_parcours/controllers/CategorieController.dart';
import 'package:provider/provider.dart';
import 'package:squelette_mobile_parcours/controllers/ArticleController.dart';
import 'package:squelette_mobile_parcours/pages/home/widgets/CategoriesWidget.dart';
import 'package:squelette_mobile_parcours/pages/home/widgets/ArtcilesListWidget.dart';
import '../../widgets/errors/NetworkErrorExceptionType1Widget.dart';
import '../../widgets/errors/NetworkErrorExceptionType2Widget.dart';
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
      title: Row(
        children: [
          Flexible(
            child: Row(
              children: [
                Icon(
                  Icons.shopping_cart_rounded,
                  color: Colors.black,
                ),
                Center(
                  child: Text(
                    "TekaSombaShop",
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Widget _body() {
    var articleCtrl = context.watch<ArticleController>();
    var categorieCtrl = context.watch<CategorieController>();

    return Column(
      children: [
        ArticlesSearchesWidget(),
        (categorieCtrl.isHttpException == true)
            ? Center(
          child: NetworkErrorExceptionType1Widget(),
        )
            : CategoriesWidget(categories: categorieCtrl.categories),
        Expanded(child:
        (articleCtrl.isHttpException == true)
            ? Center(
          child: NetworkErrorExceptionType2Widget(),
        )
            : ArticlesListWidget(articles: articleCtrl.articles)),
      ],
    );
  }
}
