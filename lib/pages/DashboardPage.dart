import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:squelette_mobile_parcours/utils/Constantes.dart';
import '../controllers/UserCtrl.dart';
import '../utils/Routes.dart';
import '../utils/StockageKeys.dart';
import '../widgets/ButtonFloat.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  GetStorage box = GetStorage();

  @override
  Widget build(BuildContext context) {
    var token = box.read(StockageKeys.tokenyKey);
    return token!=null? Scaffold(
      floatingActionButton: ButtonFloat(),
      extendBodyBehindAppBar: true,
      body: _body(),
    ): Scaffold(
      extendBodyBehindAppBar: true,
      body: _connectezVous(),
    );
  }

  Widget _body(){
    var userCtrl = context.watch<UserCtrl>();
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius:
              const BorderRadius.only(bottomRight: Radius.circular(50))),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 30),
                title: Text(
                  '${userCtrl.user?.name}',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: Colors.white),
                ),
                subtitle: Text(
                  '${userCtrl.user?.email}',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.white54),
                ),
                trailing: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle
                  ),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage('${Constantes.BASE_URL}/${userCtrl.user?.image}'),
                  ) , //AssetImage("assets/img.png"),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
        Container(
          color: Colors.black,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.only(topLeft: Radius.circular(100))),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisSpacing: 30,
              physics: NeverScrollableScrollPhysics(),
              mainAxisSpacing: 30,
              crossAxisCount: 2,
              children: [
                elementDashboard("Mes publications",1, nbr: "52", Icons.announcement, Colors.orange),
                elementDashboard("Articles favoris",2,nbr: "20", CupertinoIcons.square_favorites_alt, Colors.orange),
                elementDashboard("Articles vendus",3,nbr: "5", CupertinoIcons.square_fill_on_square_fill, Colors.orange),
                elementDashboard("Mes follows",4,nbr: "52", Icons.contacts_outlined, Colors.orange),
                elementDashboard("Analyse des articles",6, Icons.analytics_outlined, Colors.orange),
                elementDashboard("Messenger",7,nbr: "60", CupertinoIcons.chat_bubble_text, Colors.orange),
              ],
            ),
          ),
        )
      ],
    );
  }

  elementDashboard(String title,int index, IconData icon, Color background,{String? nbr}){
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 5),
              color: Colors.black.withOpacity(.2),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: background,
                shape: BoxShape.circle
              ),
              child: Icon(icon, color: Colors.white,),
            ),
            SizedBox(height: 8,),
            Text(title, style: Theme.of(context).textTheme.titleMedium,),
            SizedBox(height: 5,),
            Text(nbr==null? "":nbr, style: Theme.of(context).textTheme.labelMedium,)
          ],
        ),
      ),
      onTap: (){
        print("Elemenet $index");
      },
    );
  }

  Widget _connectezVous() {
    return TextButton(
        onPressed: () {
          Navigator.popAndPushNamed(context, Routes.LoginPageRoutes);
        }, child: Center(
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.rectangle
        ),
        child: Text('''
Veillez vous connecter pour voir cette page ! 
                            CLIQUEZ ICI''', style: TextStyle(color: Colors.black),),
      ),
    ));
  }
}
