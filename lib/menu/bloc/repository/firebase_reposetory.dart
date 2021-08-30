//import 'package:firebase_db_web_unofficial/DatabaseSnapshot.dart';

import 'package:folio/menu/bloc/repository/firebase_stock_model.dart';

import '../../../../public_data.dart';


class FReposetery {




  List<FStock> publicStock() {
    return globalListOfStock;
  }

  List<FStock> getTopratedItems() {
    var ms = publicStock();
    double masterRate = 0;
    double mastercount = 0;
    for (var element in ms) {
      double sumRate = 0;
      int total = 0;
      if (element.avis != null) {
        total = element.avis.length;
        for (var value in element.avis) {
          sumRate += value.rate;
          mastercount += 1;
          masterRate += value.rate;
        }
      } else {
        //   element.rate = 1;
        if (total == 0) total = 1;
        if (sumRate == 0) sumRate = 1;

        
      }
      element.rate = sumRate / total;
    }
    if (masterRate == 0) masterRate = 1;
    if (mastercount == 0) mastercount = 1;
    var ls = ms
        .where((element) => element.rate > masterRate / mastercount)
        .toList();

    //   ls.sort((b, a) => a.rate!.compareTo(b.rate!));
    ls.sort((b, a) => a.rate.compareTo(b.rate));
    return ls;
  }

 List<FCategories> getCategorie() {
    List<FCategories> cat = [];
    publicStock().forEach((element) {
      var m = cat.where((element2) =>
              (element.productCategories.categoriesId == element2.categoriesId))
          .toList();
      if (m.isEmpty) {
        cat.add( FCategories(
          categoriesId: element.productCategories.categoriesId,
          categoriesImage: element.productCategories.categoriesImage,
          categoriesName: element.productCategories.categoriesName,
        ));
      }
    });
    return cat;
  }

  List<FStock> getSalesitems() {
    List<FStock>salesItems = [];

    salesItems =
        publicStock().where((element) => element.isSales == true).toList();
    return salesItems.toList();
  }

  List<FStock> getNewitems() {
    List<FStock> newItems = [];
    var now = DateTime.now();
    newItems = publicStock()
        .where((element) => now.difference(element.datePublier).inDays < 20)
        .toList();
    return newItems.toList();
  }


}
