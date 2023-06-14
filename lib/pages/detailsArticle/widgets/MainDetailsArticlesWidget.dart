import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../../models/ArticleModel.dart';

class MainDetailsArticlesWidget extends StatelessWidget {
  final ArticleModel detailsArticles;

  MainDetailsArticlesWidget({required this.   detailsArticles});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 2)),
        itemCount: 1,
        itemBuilder: (BuildContext ctx, index) {
          var negociationValintermediare = detailsArticles.negociation;
          var negociationVal = "";
          if(negociationValintermediare == 1){
            negociationVal = "Négociable";
          }else{
            negociationVal = "Non négociable";
          }
          return Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical: 0, horizontal: 4),
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "${detailsArticles.title}",
                              style: TextStyle(
                                fontSize: 21,
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Catégories : ${detailsArticles.categorie}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 90,
                        ),
                        Column(
                          children: [
                            Icon(
                              Icons.favorite,
                              color: Colors.orange,
                              size: 24,
                            ),
                            Text(
                              "${detailsArticles.interrese} intéressé(s)",
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(
                              Icons.remove_red_eye,
                              color: Colors.black,
                              size: 24,
                            ),
                            Text(
                              "${detailsArticles.views} Vues",
                              style: TextStyle(
                                fontSize: 11,
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
                      Flexible(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: [
                              Row(children: [
                                Text(
                                  "",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],),
                              Row(
                                children: [
                                  Text(
                                    "Description : ",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
                                  "${detailsArticles.price} Fc",
                                  style: TextStyle(
                                    fontSize: 21,
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
                                    fontSize: 12,
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
                    height: 5,
                  ),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // description du produit
                        Flexible(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: ReadMoreText(
                              "${detailsArticles.content}",
                              trimLines: 3,
                              colorClickableText: Colors.orange,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: '...show more',
                              trimExpandedText: ' show less',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.key,
                                color: Colors.black,
                                size: 20,
                              ),
                              Text(
                                "Mots clés : ",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                margin:
                                EdgeInsets.symmetric(vertical: 5, horizontal: 4),
                                padding:
                                EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black12,
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: InkWell(
                                  onTap: () {},
                                  child: Text(
                                    "${detailsArticles.keyword}",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 20,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                                  onPressed: () {
                                    Center(child: CircularProgressIndicator());
                                  },
                                  child: Text(
                                    'Contactez-moi',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                onTap: () {},
                                child: Icon(
                                  Icons.share,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
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
                              Flexible(
                                child: Text(
                                  "Postée par : ${detailsArticles.user_id}, le 25 mai 2023",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 13,
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
                  Padding(
                    padding: EdgeInsets.only(bottom: 11),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: InkWell(
                            onTap: () {},
                            child: Row(
                              children: [
                                Icon(
                                  Icons.place,
                                  color: Colors.orange,
                                  size: 22,
                                ),
                                Flexible(
                                  child: Text(
                                    "${detailsArticles.country}-${detailsArticles.city}",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Flexible(
                          child: InkWell(
                            onTap: () {},
                            child: Row(
                              children: [
                                Icon(
                                  Icons.info_outline_rounded,
                                  color: Colors.orange,
                                  size: 25,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Flexible(
                                  child: Text(
                                    "Signaler un Abus",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 9,),
                  Text(
                    "Annoncces Similaire",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
