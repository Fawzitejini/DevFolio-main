import 'package:firebase_db_web_unofficial/DatabaseSnapshot.dart';
import 'package:firebase_db_web_unofficial/firebasedbwebunofficial.dart';
import 'package:folio/menu/bloc/repository/firebase_stock_model.dart';

class Freposetery {
  FStock ls;
  static Future<List<FStock>> getData() async {
    DatabaseSnapshot snap =
        await FirebaseDatabaseWeb.instance.reference().child("Stock").once();

    List<FStock> ls;
    Map<dynamic, dynamic> stock = snap.value;
    stock.forEach((key, value) {
      ls.add(value);
    });
    return ls;
  }
}
