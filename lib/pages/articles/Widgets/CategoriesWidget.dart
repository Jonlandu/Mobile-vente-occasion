import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../models/CategorieModel.dart';
import '../../../utils/Constantes.dart';
import '../../../widgets/errors/NetworkErrorExceptionType1Widget.dart';

class CategoriesWidget extends StatelessWidget {
  final List<CategorieModel> categories;

  CategoriesWidget({required this.categories});

  @override
  Widget build(BuildContext context) {
    if(categories.length==0){
      return Center(child: NetworkErrorExceptionType1Widget(),);
    }
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(vertical: 15),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: categories.length,
        itemBuilder: (BuildContext ctx, index) {
          CategorieModel categorie = categories[index];
          return Column(
            children: [
              InkWell(
                onTap: () {
                },
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding:
                        EdgeInsets.symmetric(vertical: 7, horizontal: 1),
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      shape: BoxShape.circle,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: "${Constantes.BASE_URL}/${categorie.image} ",
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error),
                      width: 30,
                      height: 30,
                    ),
                  ),
              ),
              // Spacer(),
              Container(
                child: Text(
                  "${categorie.category_name} ",
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 9,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
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
