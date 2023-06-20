import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '../../controllers/ArticleController.dart';
import '../../models/ArticleModel.dart';
import '../../utils/Routes.dart';
import '../../widgets/errors/NetworkErrorExceptionType1Widget.dart';
import 'Widgets/AnnoncesSimilaireWidget.dart';
import 'Widgets/DetailsArticlesImagesWidget.dart';
import 'Widgets/MainDetailsArticlesWidget.dart';

class ArticleDetailsPage extends StatefulWidget {
  final ArticleModel article;

  ArticleDetailsPage({required this.article});

  @override
  State<ArticleDetailsPage> createState() => _ArticleDetailsPageState();
}

class _ArticleDetailsPageState extends State<ArticleDetailsPage> {
  bool isVisible = false;
  bool _isAppBarVisible = true;
  late final ScrollController _scrollController;
  var articleId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var articleController = context.read<ArticleController>();
      articleController.recuperDetailsArticlesAPI(widget.article.id);
      print("VOICI L'ID GLISSER PAR LA LISTE DES ARTICLES : ${widget.article.id}");
      //var annoncesSimilaireCtrl = context.read<ArticleController>();
      //annoncesSimilaireCtrl.recuperAnnoncesSimilaireAPI();
      _scrollController = ScrollController();
      _scrollController.addListener(_handleScroll);
    });
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    setState(() {
      _isAppBarVisible = _scrollController.position.userScrollDirection == ScrollDirection.forward;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isAppBarVisible ? _appBar():null,
      body: _body(),
    );
  }

  AppBar _appBar() {
    var articleCtrl = context.watch<ArticleController>();
    //articleCtrl.recuperDetailsArticlesAPI(articleCtrl.detailarticles.id);

    void _validateDelete(BuildContext ctx) async {
      FocusScope.of(context).requestFocus(new FocusNode());
      isVisible = true;
      final int? articleId = articleCtrl.detailarticles.id;

      await articleCtrl.deleteArticleSelected(articleId);
      await Future.delayed(Duration(seconds: 2));

      Navigator.popAndPushNamed(context, Routes.HomePagePageRoutes);
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 5),
          content: Text('Vous avez suppimer cet article')));
      isVisible = false;
    }

    return AppBar(
      leading: InkWell(
        onTap: () {
          Navigator.popAndPushNamed(context, Routes.HomePagePageRoutes);
          //Navigator.pop(context, Routes.HomePagePageRoutes);
          setState(() {});
        },
        child: Icon(
          Icons.arrow_back,
          size: 23,
          color: Colors.black,
        ),
      ),
      actions: [
        Theme(
          data: Theme.of(context).copyWith(
              textTheme: TextTheme().apply(bodyColor: Colors.black),
              dividerColor: Colors.orange,
              iconTheme: IconThemeData(color: Colors.orange)),
          child: PopupMenuButton<int>(
            color: Colors.black,
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                  value: 1,
                  /*onTap: () {
                    Navigator.pushNamed(context, Routes.ArticleUpdateRoutes);
                    setState(() {});
                  },*/
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.ArticleUpdateRoutes,
                          arguments: widget.article.toJson());
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.edit,
                          color: Colors.orange,
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Text("Modifier")
                      ],
                    ),
                  )),
              PopupMenuDivider(),
              PopupMenuItem<int>(
                  value: 2,
                  onTap: () async {
                    _validateDelete(context);
                    setState(() {});
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Text("Delete")
                    ],
                  )),
            ],
            //onSelected: (item) => SelectedItem(context, item),
          ),
        ),
      ],
      title: Center(
        child: Text(
          "TekaSombaShop",
          style: TextStyle(
            color: Colors.orange,
            fontSize: 18,
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Widget _body() {
    var articleController = context.watch<ArticleController>();
    var annoncesSimilaireCtrl = context.watch<ArticleController>();
    return SingleChildScrollView(
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            DetailsArticlesImagesWidget(article: articleController.detailarticles),
            MainDetailsArticlesWidget(detailsArticles: articleController.detailarticles),
            SizedBox(
              height: 5,
            ),
            (annoncesSimilaireCtrl.isHttpException == true)
                ? Center(
                    child: NetworkErrorExceptionType1Widget(),
                  )
                : AnnoncesSimilaireWidget(
                    annoncesSimilaires: annoncesSimilaireCtrl.annoncesSimilaire),
          ],
        ),
      ),
    );
  }
}
