import 'package:flutter/material.dart';
import 'package:folio/menu/constants/own_colors.dart';

import 'additem_mobile.dart';
class AddItemDesktop extends StatefulWidget {
  const AddItemDesktop({Key key}) : super(key: key);

  @override
  _AddItemDesktopState createState() => _AddItemDesktopState();
}

class _AddItemDesktopState extends State<AddItemDesktop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(color: BrandColors.black,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child:Center(
            child: SizedBox(height:MediaQuery.of(context).size.height ,
            width: MediaQuery.of(context).size.width/2,child: Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35),
            side:BorderSide(width: 1,color: BrandColors.googleOrange)),
              color: BrandColors.xboxGrey,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: AddItem(),
              
            ),),),
          ) ,
        ),
      ),
    );
  }
}
