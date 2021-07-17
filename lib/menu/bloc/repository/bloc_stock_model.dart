
import 'dart:convert';

Map<String, BlocStockModel> stocksFromJson(String str) => Map.from(json.decode(str))
    .map((k, v) => MapEntry<String, BlocStockModel>(k, BlocStockModel.fromJson(v)));

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
     this.rate ,
     this.avis,
  });
  DateTime  datePublier;
   bool isSales;
  ProductCategories productCategories;
  String productDiscreption;
  int productId;
  String productImage;
  int  productLike;
  String productName;
  int  productQte;
  double  rate ;
  dynamic productSalesPrice;
  dynamic productUnitPrice;
  Map<String, Avi>  avis;

  factory BlocStockModel.fromJson(Map<String, dynamic> json) => BlocStockModel(
        datePublier: json["DatePublier"] == null
            ? DateTime.now().subtract(const Duration(days:11))
            : DateTime.parse(json["DatePublier"]),
        isSales:  json["IsSales"],
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

/*  Avi.fromSnapshot(DataSnapshot snapshot)
      : comment = snapshot.value["Comment"],
        isLike = snapshot.value["IsLike"],
        rate = snapshot.value["Rate"]; */

  factory Avi.fromJson(Map<String, dynamic> json) => Avi(
        comment: json["Comment"],
        isLike: json["IsLike"],
        rate: json["Rate"],
      );

  Map<String, dynamic> toJson() => {
        "Comment": comment,
        "IsLike": isLike,
        "Rate": rate,
      };
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
/*  ProductCategories.fromSnapshot(DataSnapshot snapshot)
      : categoriesId = snapshot.value["CategoriesID"],
        categoriesImage = snapshot.value["CategoriesImage"],
        categoriesName = snapshot.value["CategoriesName"];*/

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
}
