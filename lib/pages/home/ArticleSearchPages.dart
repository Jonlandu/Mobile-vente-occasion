import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squelette_mobile_parcours/controllers/ArticleController.dart';
import '../../models/ArticleModel.dart';
import '../../utils/Routes.dart';

class ArticleSearchPages extends StatefulWidget {
  final List<ArticleModel> resultatSearched;
  ArticleSearchPages({required this.resultatSearched});
  @override
  State<ArticleSearchPages> createState() => _ArticleSearchPagesState();
}

class _ArticleSearchPagesState extends State<ArticleSearchPages> {
  int index = 0;
  int selectedIndex = 0;
  int nombreArticles = 0;
  String departementSelect = "Tous";
  List<String> departementListes = [];
  List<ArticleModel> listeSorting = [];
  List<ArticleModel> listeSortingView = [];
  List<ArticleModel> articleChercher = [];
  List<ArticleModel> listSearch = [];
  final search = TextEditingController();
  List<Widget> bodyChange = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      nombreArticles = listeSortingView.length;
      setState(() {});
      init_data();
    });
  }

  init_data() {
    var ArticleCtrl = context.read<ArticleController>();
    ArticleCtrl.recuperArticlesAPI();
    listeSorting = ArticleCtrl.articlesSearched;
    listeSortingView = listeSorting;
    listSearch = listeSortingView;

    if (mounted) setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Résultat de la recherche (${listeSorting.length})", style: TextStyle(fontSize: 16, color: Colors.white),),
        actions: [
          IconButton(
            icon: Icon(Icons.sync),
            color: Colors.orange,
            onPressed: () async {
              init_data();
              CircularProgressIndicator();
            },
          ),
        ],
      ),
      //bottomNavigationBar: bottomNavigation(),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                ),
              ),
            ],
          ),
          Expanded(
              child: ListView.builder(
                //physics: const BouncingScrollPhysics(),
                  itemCount: listeSortingView.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    ArticleModel article = listeSortingView[index];
                    // print(json.encode(agent.toMap()));
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        margin:
                        EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                        padding: EdgeInsets.symmetric(vertical: 2),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey[50],
                            radius: 30,
                            backgroundImage: AssetImage(
                              "${article.images}",
                            ),
                          ),
                          title: Text("${article.title}"),
                          subtitle: Text(
                              "Prix : ${article.price} Fc"),
                          trailing: IconButton(
                            iconSize: 25,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return SimpleDialog(
                                      title: Text(
                                        "${article.title}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.3,
                                        ),
                                      ),
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.all(15),
                                          child: Text(
                                              "Titre : ${article.title}"
                                                  "\nPrix: ${article.price}\n"),
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pushNamed(context, Routes.ArticlesPageRoutes);
                                            },
                                            child: Text("Voir plus"))
                                      ],
                                    );
                                  }
                              );
                            },
                            icon: Icon(Icons.help_outline_sharp),
                          ),
                        ),
                      ),
                    );
                  })),
        ],
      ),
    );
  }

  listeSearchView(String query) {
    if (query != "") {
      listSearch = listeSorting.where((e) {
        var element = e.title?.toLowerCase();
        var element1 = e.price?.toString().toLowerCase();
        final input = query.toLowerCase();
        return element!.contains(input) | element1!.contains(input);
      }).toList();
    } else {
      listSearch = listeSorting;
      listeSortingView = listSearch;
    }
    print("longueur de la liste: ${listSearch.length}");
    setState(() {
      listeSortingView = listSearch;
    });
  }
}
