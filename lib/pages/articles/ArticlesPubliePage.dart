import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../models/ArticleModel.dart';

class ArticlesPubliePage extends StatelessWidget {
  final List<ArticleModel> articlesVendeur;

  ArticlesPubliePage({required this.articlesVendeur});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            body: Column(children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius:
                    const BorderRadius.only(bottomRight: Radius.circular(50))),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 30),
                  title: Text(
                    'Mes articles publiés',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Colors.white),
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.all(3),
                    decoration:
                        BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    child: ClipOval(),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
          articlesVendeur.isNotEmpty
              ? Container(
                  color: Colors.black,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(100))),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: articlesVendeur.length,
                        itemBuilder: (ctx, i) {
                          var articleVend = articlesVendeur[i];
                          var imagesToprint = articleVend.images.isNotEmpty
                              ? (articleVend.images[0].imagePath ?? "")
                              : "";
                          return Container(
                            padding: const EdgeInsets.all(4.0),
                            margin: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(15)),
                            child: TextButton(
                              child: ListTile(
                                  title: Text(
                                    "${articleVend.title}",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  subtitle: Text(
                                    "${articleVend.createdAt}",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  trailing: Icon(
                                    Icons.keyboard_double_arrow_right,
                                    color: Colors.white,
                                  ),
                                  leading: CachedNetworkImage(
                                    imageUrl: imagesToprint,
                                    placeholder: (context, url) =>
                                        Center(child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                    fit: BoxFit.cover,
                                  )),
                              onPressed: () {},
                            ),
                          );
                        }),
                  ),
                )
              : Column(
                children: [
                  Container(
                      color: Colors.black,
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.only(topLeft: Radius.circular(100))),
                          child: Container(
                            padding: const EdgeInsets.all(4.0),
                            margin: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.zero),
                            child: Center(
                              child: Text('Désolé vous n\'avez pas d\'articles pupliés'),
                            ),
                          )),
                    ),
                  SizedBox(height: 150,),
                  Column(
                    children: [
                      Image.asset("assets/empty.gif"),
                      SizedBox(height: 20,),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: Text('Publié un article'),
                      ),
                    ],
                  ),
                ],
              ),
        ])),
        Positioned(
          bottom: 20,
          right: 20,
          child: Image.asset(
            "assets/app_icon2.png",
            width: 25,
            height: 25,
          ),
        )
      ],
    );
  }
}
