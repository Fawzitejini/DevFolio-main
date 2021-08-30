import 'dart:convert';
import 'package:firebase/firebase.dart' as app;
import 'package:firebase_db_web_unofficial/firebasedbwebunofficial.dart';

import '../../../public_data.dart';

class FStock {
  FStock({
    this.datePublier,
    this.isSales,
    this.productCategories,
    this.productDiscreption,
    this.productId,
    this.productImage,
    this.productName,
    this.productQte,
    this.productSalesPrice,
    this.productUnitPrice,
    this.avis,
  });
  DateTime datePublier;
  bool isSales;
  FCategories productCategories;
  String productDiscreption;
  int productId;
  String productImage;
  int productLike;
  String productName;
  int productQte;
  double rate;
  dynamic productSalesPrice;
  dynamic productUnitPrice;
  List<FAvis> avis;
}

class FCategories {
  FCategories({
    this.categoriesId,
    this.categoriesImage,
    this.categoriesName,
  });

  String categoriesId;
  String categoriesImage;
  String categoriesName;
  factory FCategories.fromJson(Map<String, dynamic> json) => FCategories(
        categoriesId: json["CategoriesID"],
        categoriesImage: json["CategoriesImage"],
        categoriesName: json["CategoriesName"],
      );
  static Map productCategoriesTomMap(FCategories categories) {
    return {
      "CategoriesID": categories.categoriesId,
      "CategoriesImage": categories.categoriesImage,
      "CategoriesName": categories.categoriesName
    };
  }
}

List<FAvis> aviFromJson(String str) =>
    List<FAvis>.from(json.decode(str).map((x) => FAvis.fromJson(x)));

class FAvis {
  static Map avisToDatabase(FAvis avi) {
    return {
      "Comment": avi.comment,
      "Rate": avi.rate,
      "User": avi.user,
    };
  }

  int id;
  String comment;
  double rate;
  FUsers user;
  FAvis({this.comment, this.rate, this.user});

  factory FAvis.fromJson(Map<String, dynamic> json) => FAvis(
        comment: json["Comment"],
        user: FUsers.fromJson(json["User"]),
        rate: json["Rate"],
      );
}

class FUsers {
  int id;
  String name;
  String email;
  String address;
  String password;
  String avatar;
  String telephone;

  FUsers({this.name, this.email, this.address, this.telephone, this.avatar});
  factory FUsers.fromJson(Map<String, dynamic> json) => FUsers(
        name: json["name"],
        email: json["email"],
        address: json["address"],
        telephone: json["telephone"],
        avatar: json["avatar"],
      );
}

class InitialzeApp {
  static Future<void> initializeApp() async {
    try {
      if (app.apps.isEmpty) {
        app.initializeApp(
            apiKey: "AIzaSyDHtURV4WTAuYl3X63u862WhboqlPsLze0",
            authDomain: "fouzi-87672.firebaseapp.com",
            databaseURL: "https://fouzi-87672.firebaseio.com",
            projectId: "fouzi-87672",
            storageBucket: "fouzi-87672.appspot.com",
            messagingSenderId: "960199945853",
            appId: "1:960199945853:web:02807192f3554c86ce8b14");
      }
    } catch (e) {
      print("error initialize: {$e}");
      return;
    }
    await getItems().then((value) => essalamMenu = value);
    print("Out error with " + essalamMenu.length.toString());
  }
}

List<FStock> essalamMenu = [];

Future<List<FStock>> getItems() async {
  List<FStock> _stock = [];
  Map _database = {};
  await FirebaseDatabaseWeb.instance
      .reference()
      .child("items")
      .once()
      .then((value) {
    if (value.value == null) {
    } else {
      _database = value.value;
    }
  });
  if (_database.isEmpty) {
    return _stock;
  }
  _stock.clear();
  for (var item in _database.values) {
    FStock _fstock = FStock(
        datePublier: item["datepublier"] == null
            ? DateTime.now().subtract(const Duration(days: 11))
            : DateTime.parse(item["datepublier"]),
        productId: randomNumber(100, 99999999),
        productName: item['name'],
        productQte: item['qte'],
        productCategories: FCategories.fromJson(item['categorie']),
        productImage: item['photo'],
        productDiscreption: item['description'],
        productUnitPrice: item['price'],
        productSalesPrice: item['saleprice'],
        avis: aviFromJson(item['avis']),
        isSales: item['issales']);
    _stock.add(_fstock);
  }
}
