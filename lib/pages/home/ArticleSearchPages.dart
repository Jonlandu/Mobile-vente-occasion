import 'package:flutter/material.dart';
import '../../models/ArticleModel.dart';
import '../../utils/Routes.dart';

class ArticleSearchPage extends StatelessWidget {
  final List<ArticleModel> resultatSearched;
  ArticleSearchPage({required this.resultatSearched});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Résultat de la Recherche'),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: resultatSearched.length,
          itemBuilder: (BuildContext context, int index) {
          ArticleModel article = resultatSearched[index];
          print("JOSUEEEEEEEEEEEEEEEEEEEEE VERRIFICATION : ${resultatSearched[index].title}");
            return Card(
              child: ListTile(
                title: Row(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          //"${article.title}",
                          "ID",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Column(
                      children: [
                        Text('Name', style: TextStyle(fontWeight: FontWeight.bold),),
                        Text('email'),
                      ],
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(context, Routes.ArticlesDetailsPageRoutes, arguments: article);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
