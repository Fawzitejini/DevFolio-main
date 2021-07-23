//import 'package:firebase_db_web_unofficial/DatabaseSnapshot.dart';
import 'package:firebase_db_web_unofficial/firebasedbwebunofficial.dart';
import 'package:folio/menu/bloc/repository/firebase_stock_model.dart';

class Freposetery {
  // ignore: missing_return
  static Future<List<FCategories>> getData() async {
    List<FCategories> ls = [];
    await FirebaseDatabaseWeb.instance
        .reference()
        .child("Categories")
        .once()
        .then((value) {
      Map<dynamic, dynamic> d = value.value;
      for (var item in d.values) {
        ls.add(FCategories(
          categoriesId: item['CategoriesID'],
          categoriesImage: item['CategoriesImage'],
          categoriesName: item['CategoriesName'],
        ));
      }
      print(ls.length);
      return ls;
      /*   if(d.isNotEmpty){
      d.forEach((key, value) {
          FCategories cat = new FCategories(categoriesId: value['CategoriesID']==null?"Popo":value['CategoriesID'],
            categoriesImage: value['CategoriesImage'].toString(),
            categoriesName: value['CategoriesName'].toString());
        ls.add(cat);
        print(value['CategoriesID']);
      });}*/
      //  print(ls.length);
      // return ls;
    });
  }
}
