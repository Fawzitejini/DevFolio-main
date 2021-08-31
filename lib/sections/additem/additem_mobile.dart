import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:folio/menu/bloc/repository/firebase_stock_model.dart';
import 'package:folio/menu/bloc/repository/setstock.dart';
import 'package:folio/menu/constants/data_converter.dart';
import 'package:folio/menu/constants/own_colors.dart';

import '../../public_data.dart';


bool isExistCategory = false;
String image;
bool isSale = false;
String checkedLabelCaption = "Categories deja existe";
String unCheckedLabelCaption = "Nouveau categorie";
String checkedPriceCaption = "En promotion";
String unCheckedPriceCaption = "Prix unitaire";
TextEditingController categorie = TextEditingController();
TextEditingController designation = TextEditingController();
TextEditingController description = TextEditingController();
TextEditingController unitPrice = TextEditingController();
TextEditingController salesPrice = TextEditingController();

class AddItem extends StatefulWidget {
  const AddItem({Key key}) : super(key: key);

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  @override
  Widget build(BuildContext context) {
    FStock _stock = FStock();
    return Scaffold(
        backgroundColor: BrandColors.xboxGrey,
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              SizedBox(height: 20),
              Text("Nouveau element"),
              SizedBox(height: 20),
              Row(
                children: [
                  image == null
                      ? Container()
                      : Expanded(
                          child: Image.memory(
                            DataConverter.image(image),
                            width: 180,
                            height: 180,
                            fit: BoxFit.cover,
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
                                        borderRadius:
                                            BorderRadius.circular(8))),
                                onPressed: () async {
                                  image = await uploadImage();
                                  setState(() {});
                                },
                                child: Text("upload image")),
                          ))),
                ],
              ),
              SizedBox(height: 20),
              CheckWidget(),
              SizedBox(
                height: 20,
              ),
              Designation(),
              SizedBox(height: 20),
              Description(),
              SizedBox(
                height: 20,
              ),
              PriceSection(),
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
                          _stock.productName = designation.text;

                          _stock.isSales = isSale;
                          _stock.productDiscreption = description.text;
                          _stock.productImage = image == null ? null : image;
                          _stock.productUnitPrice =
                              double.parse(unitPrice.text);
                          _stock.productSalesPrice =
                              double.parse(salesPrice.text);
                          await SetData.setNewitems(
                              _stock,
                              FCategories(
                                  categoriesId: "Test",
                                  categoriesName: "Test",
                                  categoriesImage: "Nan"));
                          Navigator.of(context).pop();
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
                                      icon: Icon(Icons.close,
                                          color: Colors.white),
                                    )
                                  ],
                                );
                              });
                        }
                      },
                      child: Text("Sauvgardez"))),
            ],
          ),
        ));
  }
}

class CheckWidget extends StatefulWidget {
  const CheckWidget({Key key}) : super(key: key);

  @override
  _CheckWidgetState createState() => _CheckWidgetState();
}

class _CheckWidgetState extends State<CheckWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 150,
          height: 50,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              onPressed: () async {
                // MaterialPageRoute(builder: (_)=>  AddCategorie());
                Navigator.of(context).pushNamed("newcategorie");
              },
              child: Text("Nv. categorie")),
        ),
        SizedBox(width: 20),
        Expanded(
            child: DropdownButtonFormField(
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(color: Colors.amber),
            ),
            border: OutlineInputBorder(),
          ),
          onChanged: (str) {
            categorie.text = str;
          },
          items: globalListOfCategories
              .map((FCategories value) {
            return DropdownMenuItem<String>(
              value: value.categoriesName,
              child: Text(value.categoriesName),
            );
          }).toList(),
          hint: Text("Selectioner Categorie"),
          disabledHint: Text("Disabled"),
          elevation: 8,
          style: TextStyle(color: Colors.white, fontSize: 16),
          icon: Icon(Icons.arrow_drop_down_circle),
          iconDisabledColor: Colors.red,
          iconEnabledColor: Colors.green,
          isExpanded: true,
          dropdownColor: Colors.deepOrange,
        ))
      ],
    );
  }
}

class Designation extends StatefulWidget {
  const Designation({Key key}) : super(key: key);

  @override
  _DesignationState createState() => _DesignationState();
}

class _DesignationState extends State<Designation> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: designation,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.amber),
              borderRadius: BorderRadius.circular(5)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green),
              borderRadius: BorderRadius.circular(5)),
          labelText: "Designation",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
    );
  }
}

class Description extends StatefulWidget {
  const Description({Key key}) : super(key: key);

  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: description,
      maxLines: null,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.amber),
              borderRadius: BorderRadius.circular(5)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green),
              borderRadius: BorderRadius.circular(5)),
          hintText: 'Description',
          labelText: "Description",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
    );
  }
}

class PriceSection extends StatefulWidget {
  const PriceSection({Key key}) : super(key: key);

  @override
  _PriceSectionState createState() => _PriceSectionState();
}

class _PriceSectionState extends State<PriceSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 150,
              child: CheckboxListTile(
                value: isSale,
                onChanged: (e) {
                  setState(() {
                    isSale = e;
                  });
                },
                title: Text(
                  isSale == true ? unCheckedPriceCaption : checkedPriceCaption,
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
            isSale == true
                ? Expanded(
                    child: Column(
                    children: [
                      TextField(
                        controller: unitPrice,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber),
                                borderRadius: BorderRadius.circular(5)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green),
                                borderRadius: BorderRadius.circular(5)),
                            hintText: 'PU',
                            labelText: "PU",
                            suffixText: "MAD",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5))),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: salesPrice,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber),
                                borderRadius: BorderRadius.circular(5)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green),
                                borderRadius: BorderRadius.circular(5)),
                            hintText: 'Prix de promotion',
                            labelText: "Prix de promotion",
                            suffixText: "MAD",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5))),
                      ),
                    ],
                  ))
                : Expanded(
                    child: TextField(
                    controller: unitPrice,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber),
                            borderRadius: BorderRadius.circular(5)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(5)),
                        hintText: 'PU',
                        labelText: "PU",
                        suffixText: "MAD",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5))),
                  )),
          ],
        )
      ],
    );
  }
}
