import 'dart:convert';
import 'package:firebase/firebase.dart' as app;
import 'package:firebase_db_web_unofficial/firebasedbwebunofficial.dart';
import 'package:folio/public_data.dart';
import 'package:folio/users/facebook_users.dart';

class FStock {
  FStock({
    this.datePublier,
    this.isSales,
    this.productCategories,
    this.productDiscreption,
    this.productId,
    this.productImage,
    this.productName,
    this.productSalesPrice,
    this.productUnitPrice,
    this.avis,
    this.rate,
  });
  DateTime datePublier;
  bool isSales;
  FCategories productCategories;
  String productDiscreption;
  String productId;
  String productImage;
  String productName;
  dynamic productSalesPrice;
  dynamic productUnitPrice;
  List<FAvis> avis;
  double rate;
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

  String id;
  String comment;
  double rate;
  FacebookUserLogin user;
  FAvis({this.comment, this.rate, this.user});

  factory FAvis.fromJson(Map<String, dynamic> json) => FAvis(
        comment: json["Comment"],
        user: FacebookUserLogin.fromJson(json["User"]),
        rate: json["Rate"],
      );
}

class FUsers {
  String id;
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
    try {
      getCokie(facebookUserLogin.id,
        facebookUserLogin.fullName,
          facebookUserLogin.email);
      await getItems().then((value) => globalListOfStock = value);
      await getAllCategorie().then((value) => globalListOfCategories = value);
    } catch (e) {
      print("With error:  " + e.toString());
    }
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
  int count = 0;
  for (var item in _database.values) {
    count++;
    bool _isSales;
    if (item['issales'].toString() == "true") {
      _isSales = true;
    } else {
      _isSales = false;
    }
    FStock _fstock = FStock(
        datePublier: item["datepublier"] == null
            ? DateTime.now().subtract(const Duration(days: 11))
            : DateTime.parse(item["datepublier"]),
        productId: item['productId'].toString(),
        productName: item['name'],
        productCategories: FCategories.fromJson(item['categorie']),
        productImage: item['photo'] == null ? null : item['photo'],
        productDiscreption: item['description'],
        productUnitPrice: item['price'],
        productSalesPrice: item["saleprice"],
        isSales: _isSales,
        avis: item['avis'] == null ? [] : aviFromJson(item['avis']));
    _stock.add(_fstock);
    print('Loop is {$count} :' +
        _isSales.toString() +
        " and " +
        item['issales'].toString());
  }
  return _stock;
}

Future<List<FCategories>> getAllCategorie() async {
  List<FCategories> _categories = [];
  Map _mapOfCategorie = {};
  await FirebaseDatabaseWeb.instance
      .reference()
      .child("categorie")
      .once()
      .then((value) {
    if (value.value != null) {
      _mapOfCategorie = value.value;
    }
  });

  if (_mapOfCategorie.isEmpty) {
    return _categories;
  }

  for (var item in _mapOfCategorie.values) {
    _categories.add(FCategories(
        categoriesName: item['categoriename'], categoriesImage: item['photo']));
  }
  return _categories;
}
