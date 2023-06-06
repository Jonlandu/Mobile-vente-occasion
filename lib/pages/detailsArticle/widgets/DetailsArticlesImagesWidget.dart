import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:squelette_mobile_parcours/models/ArticleModel.dart';
import '../../../utils/Constantes.dart';

class DetailsArticlesImagesWidget extends StatelessWidget {
  final ArticleModel article;

  DetailsArticlesImagesWidget({required this.article});

  @override
  Widget build(BuildContext context) {
    print(article.images);
    return article.images != null && article.images!.length != 0
        ? ImageSlideshow(
        height: 300,
        indicatorColor: Colors.white,
        isLoop: true,
        onPageChanged: (value) {
          debugPrint("Page chaged : $value");
        },
        //autoPlayInterval: 3000,
        children:article.images!.map((e) {
          print("${Constantes.BASE_URL}/${e}");
          return CachedNetworkImage(
            imageUrl: "${Constantes.BASE_URL}/${e}",

            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.cover,
          );
        },
        ).toList()
    )
        : Container(
      height: 300,
      color: Colors.orange,
    );
  }
}
