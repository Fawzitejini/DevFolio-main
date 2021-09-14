
import 'package:flutter/material.dart';
import 'package:folio/admin/screens/main/main_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'controllers/MenuController.dart';



class AdminPanel extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuController(),
          ),
        ],
        child: MainScreen(),
      ),
    );
  }
}
