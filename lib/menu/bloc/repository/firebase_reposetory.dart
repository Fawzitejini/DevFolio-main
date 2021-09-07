//import 'package:firebase_db_web_unofficial/DatabaseSnapshot.dart';

import 'package:collection/collection.dart';
import 'package:folio/menu/bloc/repository/firebase_stock_model.dart';
import 'package:moor/moor.dart';

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
    var ls =
        ms.where((element) => element.rate > masterRate / mastercount).toList();

    //   ls.sort((b, a) => a.rate!.compareTo(b.rate!));
    ls.sort((b, a) => a.rate.compareTo(b.rate));
    return ls;
  }

  List<FCategories> getCategorie() {
    List<FCategories> cat = [];
    List<FCategories> m = [];
    publicStock().forEach((element) {
      cat.add(FCategories(
        categoriesId: element.productCategories.categoriesId,
        categoriesImage: element.productCategories.categoriesImage,
        categoriesName: element.productCategories.categoriesName,
      ));
    });
    var s = groupBy(cat, (FCategories p0) => p0.categoriesName);

    for (var item in s.keys) {
      var x = globalListOfCategories
          .where((element) => element.categoriesName == item);
      if (x.length > 0) {
        m.add(x.first);
      }
    }
    return m;
  }

  List<FStock> getSalesitems() {
    List<FStock> salesItems = [];
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

List<FStock> getFiltreItems(String categorieName) {
  List<FStock> filterItems = [];
  filterItems = globalListOfStock.where(
      (element) => categorieName == element.productCategories.categoriesName);
  return filterItems;
}
