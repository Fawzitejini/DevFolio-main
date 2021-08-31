import 'package:flutter/material.dart';
import 'package:folio/sections/additem/additem_desktop.dart';
import 'package:folio/sections/additem/additem_mobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

class RootAddItem extends StatelessWidget {
  const RootAddItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: AddItem(),
      desktop: AddItemDesktop(),
    );
  }
}
