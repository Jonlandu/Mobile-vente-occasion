import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:provider/provider.dart';
import 'package:squelette_mobile_parcours/controllers/UserCtrl.dart';
import 'package:squelette_mobile_parcours/utils/Routes.dart';

class BienvenuPage extends StatefulWidget {
  const BienvenuPage({Key? key}) : super(key: key);

  @override
  State<BienvenuPage> createState() => _BienvenuPageState();
}

class _BienvenuPageState extends State<BienvenuPage> {

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
    Navigator.popAndPushNamed(context, Routes.PreferencePageRoutes);
  }

  @override
  Widget build(BuildContext context) {
    return OnBoardingSlider(
        finishButtonText: 'Done',
        finishButtonStyle: FinishButtonStyle(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)))),
        onFinish: () {
          _naviguerVersPreferencePage();
/*          var userCtrl = context.read<UserCtrl>();
          userCtrl.isFirstTimeBienvenue = true;*/
          //Navigator.popAndPushNamed(context, Routes.PreferencePagePageRoutes);
        },
        /*finishButtonStyle: FinishButtonStyle(
          backgroundColor: Colors.black,
        ),*/
        skipTextButton: Text('Passé',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            )),
        /*trailing: Text(
          'Login',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),*/
        trailingFunction: () {},
        totalPage: 3,
        pageBackgroundColor: Colors.white,
        headerBackgroundColor: Colors.transparent,
        background: [
          Image.asset(
            'assets/Humaaans - 1.png',
            //height: 400,
          ),
          Image.asset(
            'assets/Humaaans -2.png',
            //height: 400,
          ),
          Image.asset(
            'assets/Humaaans - 3.png',
            //height: 400,
          ),
        ],
        speed: 1.8,
        pageBodies: [
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 480,
                ),
                Text(
                  'Bienvenue dans notre App \n  Tekasomba shop \n \n Découvrez une sélection unique d\'articles d\'occasion à des prix abordables',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Text(
                    'Trouvez votre prochain trésor parmi nos offres exclusives et faites des économies tout en préservant l\'environnement',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black26,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 480,
                ),
                Text(
                  'Chassez les bonnes affaires ! Trouvez des articles de seconde main de qualité à des prix imbattables.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                 Expanded(
                   child: Text(
                    'Faites des économies tout en contribuant à la réduction des déchets et à la préservation de notre planète.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black26,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                ),
                 ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 480,
                ),
                Text(
                  'Trouvez tout ce dont vous avez besoin! Une grande variété d\'articles de qualité à des prix abordables.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Nous proposons une grande variété d\'articles de qualité, des vêtements et des chaussures aux meubles et aux appareils électroniques',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black26,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ]);
  }
}
