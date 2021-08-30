import 'package:firebase_db_web_unofficial/firebasedbwebunofficial.dart';
import 'package:folio/menu/bloc/repository/firebase_stock_model.dart';

import '../../../public_data.dart';

class SetData {
  static Map stockToMap(FStock stock, FCategories categories) {
    return {
      "datepublier": DateTime.now().toString(),
      "productId": randomNumber(100, 9999).toString(),
      "name": stock.productName,
      "categorie": FCategories.productCategoriesTomMap(categories),
      "photo": stock.productImage,
      "description": stock.productDiscreption,
      "price": stock.productUnitPrice,
      "saleprice": stock.productSalesPrice,
      "issales": stock.isSales
    };
  }

 static Future<void> setNewitems(FStock stock, FCategories categories) async {
   FirebaseDatabaseWeb.instance
        .reference()
        .child("items").child(getRandString(10))
        .set(stockToMap(stock, categories));
    print("object saved");
  }
}






/** datePublier: item["datepublier"] == null
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
        isSales: item['issales'] 
         






         */



