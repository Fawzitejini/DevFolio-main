import 'package:flutter/material.dart';
import 'package:folio/constants.dart';
import 'package:folio/menu/constants/own_colors.dart';
import 'package:folio/menu/ui_states/avis/avis.dart';
import 'package:folio/sections/mainSection.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slimy_card/slimy_card.dart';
import 'package:splashscreen/splashscreen.dart';
import 'menu/bloc/repository/firebase_stock_model.dart';
import 'menu/ui_states/master_pages/main_page.dart';
import 'dart:async';

import 'sections/additem/addcategorie.dart';
import 'sections/additem/additem.dart';
import 'users/facebook_users.dart';
import 'users/google_users.dart';

//import 'package:url_strategy/url_strategy.dart';
class Testfirebase {
  /**  static Future<void> fire() async {
    try {
      if (app.apps.isEmpty) {
        app.initializeApp(
            apiKey: "AIzaSyDHtURV4WTAuYl3X63u862WhboqlPsLze0",
            authDomain: "fouzi-87672.firebaseapp.com",
            databaseURL: "https://fouzi-87672.firebaseio.com",
            projectId: "fouzi-87672",
            storageBucket: "fouzi-87672.appspot.com",
            messagingSenderId: "960199945853",
            appId: "1:960199945853:web:91598c0f6cfbafb9ce8b14");
      }
    } catch (e) {
      print(e);
    }
    await Freposetery.getData();
    
  }*/

}

Future<void> main() async {
  // setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          "newcategorie": (_) => AddCategorie(),
          "newitem": (_) => RootAddItem(),
          "portail": (context) => Splash(),
          "newavis": (context) => CustomerAvis(),
          "ourmenu": (context) => MenuSplash(),
          "facebooktest":(_)=>MyApp2()
        },
        debugShowCheckedModeBanner: false,
        title: 'ESSALAM',
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColorDark: BrandColors.black,
          // primaryColor: kPrimaryColor,
          fontFamily: GoogleFonts.ubuntu().fontFamily,
          //fontFamily: "Montserrat",
          highlightColor: kPrimaryColor,
        ),
        home: Splash());
  }
}
// MainPage()

class StartPage extends StatelessWidget {
  const StartPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [],
      ),
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Future<Widget> loadfromFuture() async {
    // BlocStockReposetery.fullStock = await BlocStockReposetery.getStockData();
    await InitialzeApp.initializeApp();
    return Future.value(MainPage());
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      loaderColor: kPrimaryColor,
      navigateAfterFuture: loadfromFuture(),
      title: const Text('Groupe essalam'),
      image: Image.asset(
        "aseets/logo.png",
        width: 250,
        height: 250,
        cacheHeight: 250,
        cacheWidth: 250,
      ),
      backgroundColor: BrandColors.black,
      styleTextUnderTheLoader: const TextStyle(),
    );
  }
}

class MenuSelector extends StatelessWidget {
  const MenuSelector({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SlimyCard(
                  color: BrandColors.xboxGrey,
                  width: 170,
                  topCardHeight: 200,
                  bottomCardHeight: 100,
                  borderRadius: 15,
                  topCardWidget: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Portail"),
                      Text("Découvrez nous avec notre portail"),
                    ],
                  ),
                  bottomCardWidget: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        primary: kPrimaryColor),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed("portail");
                    },
                    child: Text("Contunier"),
                  ),
                  slimeEnabled: true,
                ),
                SlimyCard(
                  color: kPrimaryColor,
                  width: 170,
                  topCardHeight: 200,
                  bottomCardHeight: 100,
                  borderRadius: 15,
                  topCardWidget: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [Text("Menu"), Text("notre menu du jour")],
                  ),
                  bottomCardWidget: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        primary: BrandColors.black),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed("menu");
                    },
                    child: Text("Contunier"),
                  ),
                  slimeEnabled: true,
                ),
              ])
        ],
      ),
    );
  }
}

class MenuSplash extends StatefulWidget {
  const MenuSplash({Key key}) : super(key: key);

  @override
  _MenuSplashState createState() => _MenuSplashState();
}

class _MenuSplashState extends State<MenuSplash> {
  Future<Widget> loadfromFuture() async {
    await InitialzeApp.initializeApp();
    // await Freposetory.builds();
    return Future.value(MenuPage());
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      loaderColor: kPrimaryColor,
      navigateAfterFuture: loadfromFuture(),
      title: const Text('Bienvenu au platform essalam'),
      image: Image.network(
        "https://img.20mn.fr/4h6nRiywT-K3L4xrdTrjjA/648x360_simulation-informatique-disque-accretion-autour-horizon-trou-noir.jpg",
        height: 120,
        width: 120,
      ),
      backgroundColor: BrandColors.black,
      styleTextUnderTheLoader: const TextStyle(),
    );
  }
}
