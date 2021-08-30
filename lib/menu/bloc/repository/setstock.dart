import 'package:firebase_db_web_unofficial/firebasedbwebunofficial.dart';
import 'package:folio/menu/bloc/repository/firebase_stock_model.dart';

import '../../../public_data.dart';

class SetData {
  Map stockToMap(FStock stock, FCategories categories) {
    return {
      "datepublier": stock.datePublier,
      "productId": randomNumber(100, 99999999),
      "name": stock.productName,
      "categorie": FCategories.productCategoriesTomMap(categories),
      "photo": stock.productImage,
      "description": stock.productDiscreption,
      "price": stock.productUnitPrice,
      "saleprice": stock.productSalesPrice,
      "issales": stock.isSales
    };
  }

  void setNewitems(FStock stock, FCategories categories) {
    FirebaseDatabaseWeb.instance
        .reference()
        .child("items")
        .set(stockToMap(stock, categories));
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