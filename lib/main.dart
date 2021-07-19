import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:folio/constants.dart';
import 'package:folio/menu/constants/own_colors.dart';
import 'package:folio/sections/mainSection.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slimy_card/slimy_card.dart';
import 'package:splashscreen/splashscreen.dart';
import 'menu/bloc/repository/bloc_stock_reposetery.dart';
import 'menu/ui_states/master_pages/main_page.dart';
//import 'package:url_strategy/url_strategy.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {"portail":(context)=>Splash()
      ,         "menu":(context)=>MenuSplash(),
                 "ourmenu":(context)=>BlocMainPage()
      },
      initialRoute: "http://localhost:14556/",
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
        home: MenuSelector());
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
    BlocStockReposetery.fullStock = await BlocStockReposetery.getStockData();
    return Future.value(MainPage());
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      loaderColor: kPrimaryColor,
      
      navigateAfterFuture: loadfromFuture(),
      title: const Text('Bienvenu au platform essalam'),
      image: Image.network(
          "https://img.20mn.fr/4h6nRiywT-K3L4xrdTrjjA/648x360_simulation-informatique-disque-accretion-autour-horizon-trou-noir.jpg"),
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
                      Text(
                          "Découvrez nous avec notre portail"),
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
                    children: [
                      Text("Menu"),
                      Text("notre menu du jour")
                    ],
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



class TestWebfirebase extends StatefulWidget {
  const TestWebfirebase({ Key key }) : super(key: key);

  @override
  _TestWebfirebaseState createState() => _TestWebfirebaseState();
}

class _TestWebfirebaseState extends State<TestWebfirebase> {
  @override
  Widget build(BuildContext context)  {
    return  FutureBuilder(
      // Initialize FlutterFire:
      future:  Firebase.initializeApp(), 
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return Text("Wrong");
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return Text("Conected");
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Text("Auther");
      },
        
      
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
    BlocStockReposetery.fullStock = await BlocStockReposetery.getStockData();
    return Future.value(BlocMainPage());
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      loaderColor: kPrimaryColor,
      navigateAfterFuture: loadfromFuture(),
      title: const Text('Bienvenu au platform essalam'),
      image: Image.network(
          "https://img.20mn.fr/4h6nRiywT-K3L4xrdTrjjA/648x360_simulation-informatique-disque-accretion-autour-horizon-trou-noir.jpg"),
      backgroundColor: BrandColors.black,
      styleTextUnderTheLoader: const TextStyle(),
    );
  }
}
