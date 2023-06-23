import 'package:flutter/material.dart';
import 'package:squelette_mobile_parcours/pages/ListeConversationPage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:squelette_mobile_parcours/utils/StockageKeys.dart';

import '../user/ProfilPage.dart';
import '../Articles/ArticlesPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentIndex=0;
  Color other = Colors.black;
  Color selectedItem = Colors.orange;
  GetStorage box = GetStorage();


  final pages=[
    ArticlesPage(),
    ListeConversationPage(),
    ProfilPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
      children: pages,
      ),
      bottomNavigationBar: _bottomNav(),
    );
  }
  Widget _bottomNav(){
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      iconSize: 30,
      unselectedItemColor: other,
      selectedItemColor: selectedItem,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Accueil',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Message',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label:
              box.read(StockageKeys.tokenKey) != null ? 'Profile' : 'Connexion',
        ),
      ],
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
          other = Colors.black;
          selectedItem = Colors.orange;
        });
      },
    );
  }
}
