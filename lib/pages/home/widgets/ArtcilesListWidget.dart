import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:squelette_mobile_parcours/utils/Constantes.dart';
import '../../../models/ArticleModel.dart';
import '../../../utils/Routes.dart';

class ArticlesListWidget extends StatelessWidget {
  final List <ArticleModel> articles;

  ArticlesListWidget({required this.articles});

  @override
  Widget build(BuildContext context) {

    if(articles.length==0){
      return Center(child: Text("Aucune donnée trouvé !"),);
    }
    return GridView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 10,
            crossAxisSpacing: 2,
            crossAxisCount: 2,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 1.39)),
        itemCount: articles.length,
        itemBuilder: (BuildContext ctx, index) {
          ArticleModel article = articles[index];
          return Container(
            alignment: Alignment.center,
            // padding: EdgeInsets.all(1),
            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.orange,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    print(article);
                    Navigator.pushNamed(context, Routes.ArticlesDetailsPageRoutes,
                        arguments: article.toJson());
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: CachedNetworkImage(
                      imageUrl: "${Constantes.BASE_URL}${article.images[0].imagePath ?? ""}",
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error),
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 11),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Column(
                            children: [
                              Text(
                                article.title ?? "",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "Catégories : ${article.title ?? ""} ",
                                style: TextStyle(
                                  fontSize: 6,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.favorite_border,
                            color: Colors.red,
                            size: 15,
                          ),
                          Text(
                            "${article.interrese ?? ""} intéressé(s)",
                            style: TextStyle(
                              fontSize: 6,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // description du produit
                    Flexible(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          article.content ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    // prix
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "${article.price ?? ""} ${article.devise ?? ""}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "${article.negociation ?? ""}",
                                style: TextStyle(
                                  fontSize: 6,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 11),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            Icon(
                              Icons.place,
                              color: Colors.orange,
                              size: 15,

                            ),
                            Flexible(
                              child: Text(
                                "${article.country ?? ""}-${article.city ?? ""}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12,),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            color: Colors.black,
                            size: 11,
                          ),
                          Text(
                            //"Publie 04-05-2023",
                            "Publie ${article.createdAt}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 7,
                              color: Colors.black,

                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
