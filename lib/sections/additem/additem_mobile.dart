import 'dart:ui';

import 'package:flutter/material.dart';

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
    return Scaffold(
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
                      child: CircleAvatar(
                        radius: 50,
                        child: Center(
                            child: Image.asset("assets/dsc.png", width: 95)),
                      ),
                    ),
              Expanded(
                  flex: 1,
                  child: Container(
                      height: 40,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.grey,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          onPressed: null,
                          child: Text("upload image")))),
              Expanded(flex: 2, child: Container())
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
          PriceSection(), SizedBox(
            height: 20,
          ),Container(
              height: 40,width:double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  onPressed:()
                  {

                  } ,
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
          width:150,
          child: CheckboxListTile(
            value: isExistCategory,
            onChanged: (e) {
              setState(() {
                isExistCategory = e;
              });
            },
            title: Text(
              isExistCategory == true
                  ? unCheckedLabelCaption
                  : checkedLabelCaption,
              style: TextStyle(fontSize: 12),
            ),
          ),
        ),
        isExistCategory == true
            ? Expanded(
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
                items: <String>['Boisson', 'Pizza', 'Burger', 'Sandwish']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
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
            : Expanded(
                child: TextField(
                  controller: categorie,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber),
                        borderRadius: BorderRadius.circular(5)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(5)),
                    hintText: 'Categorie',
                    labelText: "Categorie",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              )),
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
          hintText: 'Designation',
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
                      TextField( controller:unitPrice,
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
                      TextField(controller: salesPrice,
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
