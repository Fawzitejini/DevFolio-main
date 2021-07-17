import 'package:flutter/material.dart';
import 'child_states/category_state.dart';

class CategoryMainPage extends StatefulWidget {
  const CategoryMainPage({Key key}) : super(key: key);

  @override
  _CategoryMainPageState createState() => _CategoryMainPageState();
}

class _CategoryMainPageState extends State<CategoryMainPage> {
  @override
  Widget build(BuildContext context) {
    return const CategoryState();
  }
}


