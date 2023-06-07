import 'package:flutter/material.dart';
import 'package:squelette_mobile_parcours/pages/DashboardPage.dart';
import 'package:squelette_mobile_parcours/pages/MessagePage.dart';

import 'ProfilPage.dart';
import 'home/ArticlesPage.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentIndex=0;
  Color other = Colors.black;
  Color selectedItem = Colors.orange;

  final pages=[
    ArticlesPage(),
    DashboardPage(),
    MessagePage(),
    ProfilPage()
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:pages[_currentIndex], bottomNavigationBar: _bottomNav(),);
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
          icon: Icon(Icons.home_outlined),
          label: 'Accueil',

        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.analytics_outlined),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Message',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      onTap: (int index){
        setState(() {
          _currentIndex=index;
          other= Colors.black;
          selectedItem= Colors.orange;
        });
      },
    );
  }
}



