import 'package:http/http.dart' as http;

import 'bloc_stock_model.dart';

class BlocStockReposetery {
  static List<BlocStockModel> fullStock = [];
  static  Future<List<BlocStockModel>> getStockData() async {
    var uri = "https://possystem-be235-default-rtdb.firebaseio.com/Stock.json";
    var requiest = await http.get(Uri.parse(uri));
    
    Map<String, BlocStockModel> ls;
    if (requiest.statusCode == 200) {
      
      ls = stocksFromJson(requiest.body);
      return ls.values.toList();
    }
    return [];
  }
  Future<List<BlocStockModel>> getTopratedItems() async {
    var ms = await getStockData();
    double masterRate = 0;
    double mastercount = 0;
    for (var element in ms) {
      double sumRate = 0;
      int total = 0;
      if (element.avis != null) {
        total = element.avis.values.length;
        for (var value in element.avis.values) {
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

  Future<List<ProductCategories>> getCategorie() async {
    List<ProductCategories> cat = [];
    await getStockData().then((value) => {
          // ignore: avoid_function_literals_in_foreach_calls
          value.forEach((element) {
            var m = cat.where((element2) =>
                (element.productCategories.categoriesId ==
                    element2.categoriesId)).toList();
            if (m.isEmpty) {
              cat.add( ProductCategories(
                categoriesId: element.productCategories.categoriesId,
                categoriesImage: element.productCategories.categoriesImage,
                categoriesName: element.productCategories.categoriesName,
              ));
            }
          })
        });
    return cat;
  }

  Future<List<BlocStockModel>> getSalesitems() async {
    List<BlocStockModel> salesItems = [];

    await getStockData().then((value) =>
        salesItems = value.where((element) => element.isSales).toList());
    return salesItems.toList();
  }

  Future<List<BlocStockModel>> getNewitems() async {
    List<BlocStockModel> newItems = [];
    var now = DateTime.now();
    await getStockData().then((value) => newItems = value
        .where((element) => now.difference(element.datePublier).inDays < 10)
        .toList());

    return newItems.toList();
  }
}

class NoneAsyncBlocStockReposetery {
  List<BlocStockModel> getStockData() {
    return BlocStockReposetery.fullStock;
  }

  List<BlocStockModel> getTopratedItems() {
    var ms = BlocStockReposetery.fullStock;
    double masterRate = 0;
    double mastercount = 0;
    for (var element in ms) {
      double sumRate = 0;
      int total = 0;
      if (element.avis != null) {
        total = element.avis.values.length;
        for (var value in element.avis.values) {
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

  List<ProductCategories> getCategorie() {
    List<ProductCategories> cat = [];
    getStockData().forEach((element) {
      var m = cat.where((element2) =>
              (element.productCategories.categoriesId == element2.categoriesId))
          .toList();
      if (m.isEmpty) {
        cat.add( ProductCategories(
          categoriesId: element.productCategories.categoriesId,
          categoriesImage: element.productCategories.categoriesImage,
          categoriesName: element.productCategories.categoriesName,
        ));
      }
    });
    return cat;
  }

  List<BlocStockModel> getSalesitems() {
    List<BlocStockModel> salesItems = [];

    salesItems =
        getStockData().where((element) => element.isSales == true).toList();
    return salesItems.toList();
  }

  List<BlocStockModel> getNewitems() {
    List<BlocStockModel> newItems = [];
    var now = DateTime.now();
    newItems = getStockData()
        .where((element) => now.difference(element.datePublier).inDays < 20)
        .toList();
    return newItems.toList();
  }
}
