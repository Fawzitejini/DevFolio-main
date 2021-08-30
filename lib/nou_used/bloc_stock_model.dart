import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:google_maps/google_maps.dart';

Map<String, BlocStockModel> stocksFromJson(String str) =>
    Map.from(json.decode(str)).map((k, v) =>
        MapEntry<String, BlocStockModel>(k, BlocStockModel.fromJson(v)));

String stocksToJson(Map<String, BlocStockModel> data) => json.encode(
    Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class BlocStockModel {
  BlocStockModel({
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
  ProductCategories productCategories;
  String productDiscreption;
  int productId;
  String productImage;
  int productLike;
  String productName;
  int productQte;
  double rate;
  dynamic productSalesPrice;
  dynamic productUnitPrice;
  Map<String, Avi> avis;

  factory BlocStockModel.fromJson(Map<String, dynamic> json) => BlocStockModel(
        datePublier: json["DatePublier"] == null
            ? DateTime.now().subtract(const Duration(days: 11))
            : DateTime.parse(json["DatePublier"]),
        isSales: json["IsSales"],
        productCategories:
            ProductCategories.fromJson(json["ProductCategories"]),
        productDiscreption: json["ProductDiscreption"],
        productId: json["ProductId"],
        productImage: json["ProductImage"],
        productLike: json["ProductLike"],
        productName: json["ProductName"],
        productQte: json["ProductQte"],
        productSalesPrice: json["ProductSalesPrice"],
        productUnitPrice: json["ProductUnitPrice"],
        avis: json["Avis"] == null
            ? null
            : Map.from(json["Avis"])
                .map((k, v) => MapEntry<String, Avi>(k, Avi.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "DatePublier":
            datePublier == null ? null : datePublier.toIso8601String(),
        // ignore: unnecessary_null_comparison
        "IsSales": isSales,
        "ProductCategories": productCategories.toJson(),
        "ProductDiscreption": productDiscreption,
        "ProductId": productId,
        "ProductImage": productImage,
        "ProductLike": productLike,
        "ProductName": productName,
        "ProductQte": productQte,
        //  "ProductSalesPrice": productSalesPrice,
        "ProductUnitPrice": productUnitPrice,
        "Avis": avis == null
            ? null
            : Map.from(avis)
                .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class Avi {
  Avi({
    this.comment,
    this.isLike,
    this.rate,
  });

  String comment;
  bool isLike;
  dynamic rate;
   factory Avi.fromJson(Map<String, dynamic> json) => Avi(
        comment: json["userId"],
        isLike: json["id"],
        rate: json["title"],  
    );
/*  Avi.fromSnapshot(DataSnapshot snapshot)
      : comment = snapshot.value["Comment"],
        isLike = snapshot.value["IsLike"],
        rate = snapshot.value["Rate"]; */

  factory Avi.fromdb(DataSnapshot json) => Avi(
        comment: json.value["Comment"],
        isLike: json.value["IsLike"],
        rate: json.value["Rate"],
      );

  Map<String, dynamic> toJson() => {
        "Comment": comment,
        "IsLike": isLike,
        "Rate": rate,
      };

  static Map avisToDatabase(Avi avi) {
    return {
      "Comment": avi.comment,
      "IsLike": avi.isLike,
      "Rate": avi.rate,
    };
  }
}

class ProductCategories {
  ProductCategories({
    this.categoriesId,
    this.categoriesImage,
    this.categoriesName,
  });

  String categoriesId;
  String categoriesImage;
  String categoriesName;

  factory ProductCategories.fromJson(Map<String, dynamic> json) =>
      ProductCategories(
        categoriesId: json["CategoriesID"],
        categoriesImage: json["CategoriesImage"],
        categoriesName: json["CategoriesName"],
      );

  Map<String, dynamic> toJson() => {
        "CategoriesID": categoriesId,
        "CategoriesImage": categoriesImage,
        "CategoriesName": categoriesName,
      };

  static Map productCategoriesFromData(ProductCategories categories) {
    return {
      "CategoriesID": categories.categoriesId,
      "CategoriesImage": categories.categoriesImage,
      "CategoriesName": categories.categoriesName
    };
  }
}

class StockModel {
  StockModel({
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
  ProductCategories productCategories;
  String productDiscreption;
  int productId;
  String productImage;
  int productLike;
  String productName;
  int productQte;
  double rate;
  dynamic productSalesPrice;
  dynamic productUnitPrice;
  List<Avis> avis;

  static Future<void> stockInitialize() async {
    List<StockModel> items = [];
    Map<dynamic, dynamic> database = {};
    FirebaseDatabase.instance.reference().child("").once().then((value) {
      if (value.value != null) {
        database = value.value;
      }
    });

    if (database.isNotEmpty) {
      for (var item in database.values) {
        StockModel stockModel = StockModel(
          datePublier: item[''],
          isSales: item[''],
          productCategories: item[''],
          productDiscreption: item[''],
          productId: item[""],
          productImage: item[''],
         productSalesPrice: item[''],
         productName: item[''],
         productLike:item[''],
         productUnitPrice: item[''],
         productQte: item[''],
         avis: aviFromJson(item['']),
        

        );

        items.add(stockModel);
      }
      return items;
    }
  }
}



List<Avis> aviFromJson(String str) => List<Avis>.from(json.decode(str).map((x) => Avis.fromJson(x)));

class Avis {
  static Map avisToDatabase(Avi avi) {
    return {
      "Comment": avi.comment,
      "IsLike": avi.isLike,
      "Rate": avi.rate,
    };
  }
  Avis({
    this.comment,
    this.isLike,
    this.rate,
  });

  String comment;
  bool isLike;
  dynamic rate;

    factory Avis.fromJson(Map<String, dynamic> json) => Avis(
        comment: json["userId"],
        isLike: json["id"],
        rate: json["title"],
      
    );

   
}