import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/ArticleController.dart';
import '../../../utils/Routes.dart';

class ArticlesSearchesWidget extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    void _performSearch(BuildContext context, String query) async {
      var articleCtrl = context.read<ArticleController>();
      var searchResult = await articleCtrl.recuperArticlesSearched(query);

      Navigator.pushNamed(context, Routes.ArticleSearchPageRoutes, arguments: searchResult);
    }
    return Container(
      height: 40,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 40,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 3),
                  height: 50,
                  width: 200,
                  child: TextFormField(
                    controller: _searchController,
                    onFieldSubmitted: (value) {
                      _performSearch(context, value);
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Recherche",
                    ),
                    /*onChanged: ,*/
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    _performSearch(context, _searchController.text);
                  },
                  child: Icon(
                    Icons.search,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}