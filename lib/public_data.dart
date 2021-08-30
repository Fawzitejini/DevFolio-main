
import 'dart:convert';
import 'dart:math';

import 'menu/bloc/repository/firebase_stock_model.dart';
FStock globalStock ;
FCategories globalCategories ;

String getRandString(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  int randomNumber(min, max){
    var rn = new Random();
    return min + rn.nextInt(max - min);
  }