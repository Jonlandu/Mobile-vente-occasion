
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/ArticleModel.dart';
import '../../utils/Constantes.dart';
import '../../utils/Endpoints.dart';

class DeleteArticlePage extends StatefulWidget {
  final ArticleModel article;

  DeleteArticlePage({required this.article});

  @override
  _DeleteArticlePageState createState() => _DeleteArticlePageState();
}

class _DeleteArticlePageState extends State<DeleteArticlePage> {
  bool _isDeleting = false;
  var url = Uri.parse("${Constantes.BASE_URL}${Endpoints.deleteArticle}");

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: _isDeleting ? null : deleteArticle,
          child: _isDeleting
              ? CircularProgressIndicator() // Affiche un indicateur de progression pendant la suppression de l'article.
              : Text('Supprimer l\'article'),
        ),
      ),
    );
  }
}