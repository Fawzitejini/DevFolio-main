import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_db_web_unofficial/DatabaseSnapshot.dart';

class FStock {
  FStock({
    this.datePublier,
    this.isSales,
    this.productCategories,
    this.productDiscreption,
    this.productId,
    this.productImage,
    this.productLike,
    this.productName,
    this.productQte,
    this.productSalesPrice,
    this.productUnitPrice,
    this.rate,
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
}

class FAvis {
  int id;
  String comment;
  double rate;
  FUsers user;
  FAvis({this.comment, this.rate, this.user});
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
}

class DataSource {
  static Future<FirebaseApp> snap() async {
    final _initialization = await Firebase.initializeApp();
    return _initialization;
  }
}
