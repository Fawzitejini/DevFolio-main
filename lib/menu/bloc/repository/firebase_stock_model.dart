import 'dart:convert';
import 'package:firebase/firebase.dart' as app;
import 'package:firebase_db_web_unofficial/firebasedbwebunofficial.dart';
import 'package:folio/admin/models/RecentFile.dart';
import 'package:folio/public_data.dart';
import 'package:folio/users/facebook_users.dart';

class FStock {
  FStock({
    this.key,
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
  String key;
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

class FAvis {
  static Map avisToDatabase(FAvis avi) {
    return {
      "Comment": avi.comment,
      "Rate": avi.rate,
      "User": FacebookUserLogin.facebookUserToMap(avi.user),
    };
  }

  String key;
  String comment;
  double rate;
  FacebookUserLogin user;
  FAvis({this.key, this.comment, this.rate, this.user});
}

/*class FUsers {
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
}*/

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
      getCokie(facebookUserLogin.id, facebookUserLogin.fullName,
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

  for (var item in _database.entries) {
    bool _isSales;
    if (item.value['issales'].toString() == "true") {
      _isSales = true;
    } else {
      _isSales = false;
    }
    FStock _fstock = FStock(
      key: item.key,
      datePublier: item.value["datepublier"] == null
          ? DateTime.now().subtract(const Duration(days: 11))
          : DateTime.parse(item.value["datepublier"]),
      productId: item.value['productId'].toString(),
      productName: item.value['name'],
      productCategories: FCategories.fromJson(item.value['categorie']),
      productImage: item.value['photo'] == null ? null : item.value['photo'],
      productDiscreption: item.value['description'],
      productUnitPrice: item.value['price'],
      productSalesPrice: item.value["saleprice"],
      isSales: _isSales,
    );
   
    _fstock.avis = await CurrentItemAvis.listOfAvis(_fstock);
    _stock.add(_fstock);
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

class CurrentItemAvis {
  static Future<List<FAvis>> listOfAvis(FStock item) async {
    List<FAvis> _avis = [];
    Map _data = {};
    await FirebaseDatabaseWeb.instance
        .reference()
        .child("items")
        .child(item.key)
        .child("avis")
        .once()
        .then((value) {
      if (value.value == null) {
      } else {
        _data = value.value;
      }

      for (var item in _data.entries) {
        //   print(item.value["Comment"] + '\n' + item.value['Rate'] );
        _avis.add(FAvis(
            key: item.key,
            comment: item.value["Comment"].toString(),
            rate: double.parse(item.value['Rate'].toString()),
            user: FacebookUserLogin.fromJsonFireBase(item.value['User'])));
      }
    });

    return _avis;
  }
}
/** "Comment": avi.comment,
      "Rate": avi.rate,
      "User": FacebookUserLogin.facebookUserToMap(avi.user), */