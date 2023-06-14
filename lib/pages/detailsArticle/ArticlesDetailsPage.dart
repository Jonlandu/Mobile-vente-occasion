import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/ArticleController.dart';
import '../../models/ArticleModel.dart';
import '../../utils/Constantes.dart';
import '../../utils/Endpoints.dart';
import '../../utils/Routes.dart';
import '../../widgets/errors/NetworkErrorExceptionType1Widget.dart';
import 'package:http/http.dart' as http;
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
      /*var annoncesSimilaireCtrl = context.read<ArticleController>();
      annoncesSimilaireCtrl.recuperAnnoncesSimilaireAPI();*/
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
          Navigator.pop(context);
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
                  value: 1, child: Row(
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
              )),
              PopupMenuDivider(),
              PopupMenuItem<int>(
                  value: 2,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          //ouvrirDialog(context);
                        },
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
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

  /*void SelectedItem(BuildContext context, item) {
    switch (item) {
      *//*case 0:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ModifierArticlePage()));
        break;*//*
      case 2:
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => DeleteArticlePage(articleId: widget.article)),
                (route) => false);
        break;
    }
  }*/
  /*ArticleModel articleId = widget.article.id;

  Future<void> deleteArticle() async {
    setState(() {
      _isDeleting = true;
    });

    try {
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          // Ajout de l'en-tête si possible
        },
      );

      if (response.statusCode == 200) {
        // Suppression réussie
        // Traitez ici la logique après la suppression de l'article, par exemple, affichez un message de succès.
      } else {
        // Gestion des erreurs lors de la suppression de l'article
        // Traitez ici les cas d'erreur, par exemple, affichez un message d'erreur ou effectuez une action appropriée.
      }
    } catch (e) {
      // Gestion des erreurs de connexion, d'exceptions, etc.
      // Traitez ici les erreurs qui pourraient survenir lors de l'appel de l'API de suppression.
    }

    setState(() {
      _isDeleting = false;
    });


  ouvrirDialog(context) async {
    bool? resulat = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        var url = Uri.parse("${Constantes.BASE_URL}${Endpoints.deleteArticle}${widget.article.id}");
        return AlertDialog(
          title: Text("Déconnexion"),
          content: new Text("Voulez-vous vraiment suprimer ?"),
          actions: <Widget>[
            TextButton(
              child: new Text(
                "Annuler",
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            new TextButton(
              child: new Text(
                "Confirmer", style: TextStyle(color: Colors.orange),),
              onPressed: () {
                Navigator.pop(context, true);
                deleteArticle();
                box.remove(StockageKeys.tokenKey);
                Navigator.popAndPushNamed(context, Routes.HomePagePageRoutes);
              },
            ),
          ],
        );
      },
    );

    if (resulat != null) {
      var message = !resulat ? "Suppression annulée" : "Supprimer";
      showSnackBar(context, message);
    }
  }

  showSnackBar(context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(
      content: Text(message),
      action:
      SnackBarAction(label: 'OK',
          textColor: Colors.orange,
          onPressed: scaffold.hideCurrentSnackBar),
    ));
  }*/
}
