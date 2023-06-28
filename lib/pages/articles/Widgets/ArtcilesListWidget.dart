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
      return Center(child: CircularProgressIndicator(),
      );
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
          var imagesToprint = article.images.isNotEmpty ? (article.images[0].imagePath ?? "") :  "";
          var negociationValintermediare = article.negociation;
          var negociationVal = "";
          if(negociationValintermediare == 1){
            negociationVal = "Négociable";
          }else{
            negociationVal = "Non négociable";
          }
          return Padding(
            //padding: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Container(
              alignment: Alignment.center,
              // padding: EdgeInsets.all(1),
              //margin: EdgeInsets.symmetric(vertical: 0, horizontal: 4),
              padding: EdgeInsets.symmetric( horizontal: 4),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.orange,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.ArticlesDetailsPageRoutes,
                          arguments: article.toJson());
                    },
                    child: Container(
                      margin: EdgeInsets.all(7),
                      child: CachedNetworkImage(
                        imageUrl: "${Constantes.BASE_URL}${imagesToprint}",
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error),
                        width: 135,
                        height: 135,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 11),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              article.title ?? "",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Catégories : ${article.categorie_name ?? ""} ",
                              style: TextStyle(
                                fontSize: 6,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(
                              Icons.favorite_border,
                              color: Colors.orange,
                              size: 15,
                            ),
                            Text(
                              "${article.interesse ?? ""} intéressé(s)",
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
                                  "${negociationVal}",
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
                        Flexible(
                          child: Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                color: Colors.black,
                                size: 11,
                              ),
                              Flexible(
                                child: Text(
                                  //"Publie 04-05-2023",
                                  "Publie ${article.createdAt}",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 7,
                                    color: Colors.black,

                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
