import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../models/ArticleModel.dart';
import '../../../utils/Constantes.dart';

class AnnoncesSimilaireWidget extends StatelessWidget {
  final List<ArticleModel> annoncesSimilaires;

  AnnoncesSimilaireWidget({required this.annoncesSimilaires});

  @override
  Widget build(BuildContext context) {
    if (annoncesSimilaires.length == 0) {
      return Center(
        child: Text("Aucune annonce similaire !"),
      );
    }

    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: annoncesSimilaires.length,
        itemBuilder: (BuildContext ctx, index) {
          ArticleModel annonceSimilaire = annoncesSimilaires[index];
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.all(0),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.orange,
                        width: 0.8,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 5,),
                        Container(
                          margin: EdgeInsets.all(0),
                          child: CachedNetworkImage(
                            imageUrl:
                            "${Constantes.BASE_URL}/${annonceSimilaire.images?[0] ?? ""}",
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            fit: BoxFit.cover,
                            width: 120,
                            height: 140,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "${annonceSimilaire.title ?? ""}",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "${annonceSimilaire.price ?? 0} Fc",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 12,
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
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
