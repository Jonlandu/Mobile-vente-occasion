import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:squelette_mobile_parcours/controllers/ConversationController.dart';
import 'package:squelette_mobile_parcours/controllers/UserCtrl.dart';
import '../../../models/ArticleModel.dart';
import '../../../utils/Routes.dart';

class MainDetailsArticlesWidget extends StatelessWidget {
  final ArticleModel detailsArticles;

  MainDetailsArticlesWidget({required this.detailsArticles});

  @override
  Widget build(BuildContext context) {
    var conversationCtrl = context.read<ConversationController>();
    var userCtrl = context.read<UserCtrl>();
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

          return Padding(
            padding: const EdgeInsets.all(10),
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
                              "${detailsArticles.categorie_name}",
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
                        InkWell(
                          child: Column(
                            children: [
                              detailsArticles.interesse == 0 ?
                              Icon(
                                Icons.favorite_border,
                                color: Colors.orange,
                                size: 24,
                              ):Icon(
                                Icons.favorite,
                                color: Colors.orange,
                                size: 24,
                              ),
                              Text(
                                "${detailsArticles.interesse} intéressé(s)",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          onTap: (){

                          },
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
                                fontSize: 16,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Row(children: [
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
                                child: Row(
                                  children: [
                                    Icon(Icons.tag, size: 12,),
                                    Text(
                                      "${detailsArticles.keyword}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "Par : ${detailsArticles.user_name},\n le ${detailsArticles.createdAt}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                          ),
                        ),
                      SizedBox(width: 50,),
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
                                  child:userCtrl.user?.id != detailsArticles.user_id?
                                  InkWell(
                                    child: Text(
                                      'Contactez-moi',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onTap: (){
                                      Map data = {"article_id":detailsArticles.id,"user_id":userCtrl.user?.id};
                                      conversationCtrl.creerConversationApi(data);
                                      Navigator.pushNamed(context, Routes.DiscussionPageRoutes);
                                    },
                                  ):InkWell(
                                    child: Text(
                                      'Qui m\'ont écrit ?',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onTap: (){
                                      showSnackBar(context, "Bientôt disponible !");
                                    },
                                  )
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              InkWell(

                                onTap: () {
                                  showSnackBar(context, "Bientôt disponible !");
                                },
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
                  /*SizedBox(height: 9,),
                  Text(
                    "Annoncces Similaire",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),*/
                ],
              ),
            ),
          );
        }
        );
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
  }
}
