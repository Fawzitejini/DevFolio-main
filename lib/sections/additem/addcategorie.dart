import 'package:firebase_db_web_unofficial/firebasedbwebunofficial.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'package:folio/menu/bloc/repository/firebase_stock_model.dart';
import 'package:folio/menu/constants/data_converter.dart';
import 'package:folio/menu/constants/own_colors.dart';
import 'package:folio/menu/ui_states/master_pages/main_page.dart';

import '../../constants.dart';
import '../../public_data.dart';

String catImage;

TextEditingController categorieName = TextEditingController();

class AddCategorieMobile extends StatefulWidget {
  const AddCategorieMobile({Key key}) : super(key: key);

  @override
  _AddCategorieMobileState createState() => _AddCategorieMobileState();
}

class _AddCategorieMobileState extends State<AddCategorieMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
          children: [
            catImage == null
                ? Container()
                : Expanded(
                    child: Image.memory(
                      DataConverter.image(catImage),
                      width: 180,
                      height: 180,
                      fit: BoxFit.fill,
                    ),
                  ),
            Expanded(
                flex: 1,
                child: Container(
                    height: 40,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.grey,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          onPressed: () async {
                            catImage = await uploadImage();
                            setState(() {});
                          },
                          child: Text("upload image")),
                    ))),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          controller: categorieName,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber),
                  borderRadius: BorderRadius.circular(5)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                  borderRadius: BorderRadius.circular(5)),
              labelText: "Nom de categorie",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 40,
          width: double.infinity,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              onPressed: () async {
                try {
                  FCategories _categorie = FCategories(
                      categoriesImage: catImage,
                      categoriesName: categorieName.text);
                  FirebaseDatabaseWeb.instance
                      .reference()
                      .child("categorie")
                      .child(getRandString(10))
                      .set({
                    "CategoriesID": "Cat" + randomNumber(10, 999).toString(),
                    "categoriename": _categorie.categoriesName,
                    "photo": _categorie.categoriesImage,
                  });
                  globalListOfCategories.add(_categorie);
                  Navigator.of(context).pop();
                   categorieName.text = null;
                                      catImage = null;
                                      setState(() {
                                        
                                      });
                  //    Navigator.of(context).pushReplacementNamed("newitem");
                } catch (e) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: BrandColors.xboxGrey,
                          scrollable: true,
                          title: Text('Login',
                              style: TextStyle(color: Colors.amber)),
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                              child: Text(
                                "Erreur: {$e}",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          actions: [
                            // ignore: deprecated_member_use
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(Icons.close, color: Colors.white),
                            )
                          ],
                        );
                      });
                }
              },
              child: Text("Sauvgardez")),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 40,
          width: double.infinity,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Annulez")),
        )
      ]),
    ));
  }
}

class AddCategorieDesktop extends StatefulWidget {
  const AddCategorieDesktop({Key key}) : super(key: key);

  @override
  _AddCategorieDesktopState createState() => _AddCategorieDesktopState();
}

class _AddCategorieDesktopState extends State<AddCategorieDesktop> {
  final ValueChanged<FCategories> categorie;

  _AddCategorieDesktopState({this.categorie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: Center(
          child: SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                      side: BorderSide(
                          width: 1, color: BrandColors.googleOrange)),
                  color: BrandColors.xboxGrey,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              catImage == null
                                  ? Container()
                                  : Expanded(
                                      child: Image.memory(
                                        DataConverter.image(catImage),
                                        width: 180,
                                        height: 180,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                      height: 40,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.grey,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8))),
                                            onPressed: () async {
                                              catImage = await uploadImage();
                                              setState(() {});
                                            },
                                            child: Text("upload image")),
                                      ))),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: categorieName,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.amber),
                                    borderRadius: BorderRadius.circular(5)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green),
                                    borderRadius: BorderRadius.circular(5)),
                                labelText: "Nom de categorie",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5))),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 40,
                            width: double.infinity,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.grey,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8))),
                                onPressed: () async {
                                  try {
                                    FCategories _categorie = FCategories(
                                        categoriesImage: catImage,
                                        categoriesName: categorieName.text);
                                    FirebaseDatabaseWeb.instance
                                        .reference()
                                        .child("category")
                                        .child(getRandString(10))
                                        .set({
                                      "CategoriesID": "Cat" +
                                          randomNumber(10, 999).toString(),
                                      "categoriename":
                                          _categorie.categoriesName,
                                      "photo": _categorie.categoriesImage,
                                    });
                                    Navigator.of(context).pop();
                                    setState(() {
                                      categorieName.text = null;
                                      catImage = null;
                                      setState(() {
                                        
                                      });
                                  
                                    });
                                  } catch (e) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor:
                                                BrandColors.xboxGrey,
                                            scrollable: true,
                                            title: Text('Login',
                                                style: TextStyle(
                                                    color: Colors.amber)),
                                            content: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Form(
                                                child: Text(
                                                  "Erreur: {$e}",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            actions: [
                                              // ignore: deprecated_member_use
                                              IconButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                icon: Icon(Icons.close,
                                                    color: Colors.white),
                                              )
                                            ],
                                          );
                                        });
                                  }
                                },
                                child: Text("Sauvgardez")),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 40,
                            width: double.infinity,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: kPrimaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8))),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Annulez")),
                          )
                        ]),
                  ))),
        ),
      ),
    );
  }
}

class AddCategorie extends StatelessWidget {
  const AddCategorie({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
        mobile: AddCategorieMobile(), desktop: AddCategorieDesktop());
  }
}
