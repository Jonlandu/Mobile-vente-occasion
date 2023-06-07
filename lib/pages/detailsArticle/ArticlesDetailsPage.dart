import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/ArticleController.dart';
import '../../models/ArticleModel.dart';
import '../../widgets/errors/NetworkErrorExceptionType1Widget.dart';
import 'widgets/AnnoncesSimilaireWidget.dart';
import 'widgets/DetailsArticlesImagesWidget.dart';
import 'widgets/MainDetailsArticlesWidget.dart';

class ArticlesDetailsPage extends StatefulWidget {
  final ArticleModel article;

  ArticlesDetailsPage({required this.article});

  @override
  State<ArticlesDetailsPage> createState() => _ArticlesDetailsPageState();
}

class _ArticlesDetailsPageState extends State<ArticlesDetailsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var annoncesSimilaireCtrl = context.read<ArticleController>();
      annoncesSimilaireCtrl.recuperAnnoncesSimilaireAPI();
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
      leading: InkWell(
        onTap: () {
          print("Salut");
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back,
          size: 23,
          color: Colors.black,
        ),
      ),

      title: Center(
        child: Text(
          "Détails Articles",
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Widget _body() {
    var annoncesSimilaireCtrl = context.watch<ArticleController>();

    print("Josué c'est ça : ${annoncesSimilaireCtrl.annoncesSimilaire}");

    return SingleChildScrollView(
      child: Column(
        children: [
          DetailsArticlesImagesWidget(article: widget.article),
          MainDetailsArticlesWidget(detailsArticles: widget.article),
          SizedBox(height: 5,),
          (annoncesSimilaireCtrl.isHttpException == true)
              ? Center(
            child: NetworkErrorExceptionType1Widget(),
          )
              : AnnoncesSimilaireWidget(annoncesSimilaires: annoncesSimilaireCtrl.annoncesSimilaire),
        ],
      ),
    );
  }
}
