import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:squelette_mobile_parcours/controllers/UserCtrl.dart';

import '../controllers/TagCtrl.dart';
import '../utils/Routes.dart';

class PreferencePage extends StatefulWidget {
  const PreferencePage({Key? key}) : super(key: key);

  @override
  State<PreferencePage> createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage> {
  List<String> tags = [];
  GetStorage? stockage;
  bool isSelected = false;
  List<String> preferences = [
    'Habits',
    'Laptop',
    'Veste',
    'T-shirt',
    'Polo',
    'Pantalon',
    'Jordan',
    'Electronique',
    'Sandale',
    'Robe',
    'Ordinateur',
    'Téléphone',
    'Voiture',
    'TV',
    'Smartphone',
  ];
  Color? color;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var userCtrl = context.read<UserCtrl>();
      if(userCtrl.isFirstTimeBienvenue){
        _naviguerVersPreferencePage();
      }

    });

  }

  _naviguerVersPreferencePage(){
    Navigator.popAndPushNamed(context, Routes.HomePagePageRoutes);
  }

  @override
  Widget build(BuildContext context) {
    var tagCtrl = context.watch<TagCtrl>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 74,),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Column(
                children: [
                  Container(
                    child: Text('Quels sont les produits que vous aimerez voir ?',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.24,
                          color: Colors.black,
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Text(
                      "Choisissez vos préférences que vous voulez voir pour une meilleur expérience \nde l’application.",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                        letterSpacing: -0.24,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: Wrap(
                spacing: 10,
                children: [
                  for (var value in tagCtrl.listeTags)
                    ChoiceChip(
                      shadowColor: Colors.black,
                      elevation: 2,
                      padding: EdgeInsets.all(12),
                      label: Text(value.nom as String),
                      selected: tags.contains(value.nom),
                      labelStyle: tags.contains(value.nom)
                          ? TextStyle(color: Colors.white, fontSize: 14, )
                          : TextStyle(color: Colors.black,fontSize: 14,),
                      selectedColor: Color.fromRGBO(255, 121, 0, 1),
                      disabledColor: Color.fromRGBO(216, 217, 219, 1),
                      onSelected: (bool selected) {
                        setState(() {
                          if (selected) {
                            tags.add(value.nom as String);
                          } else {
                            tags.remove(value.nom);
                          }
                        });
                        print("===================== Valeurs ${tags}");
                      },
                    ),
                ],
              ),
            ),
            SizedBox(height: 150,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    //stockage?.write(StockageKeys.preferenceKey, tags);
                  },
                  child: Container(
                    width: 70,
                    child: Center(
                      child: Text(
                        'Annuler',
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero)
                  ),
                ),
                SizedBox(width: 25,),
                ElevatedButton(
                  onPressed: () {
                    var userCtrl = context.read<UserCtrl>();
                    userCtrl.isFirstTimeBienvenue = true;
                    _naviguerVersPreferencePage();
                  },
                  child: Container(
                    width: 70,
                    child: Center(
                      child: Text(
                        'Ajouter',
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero)
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
