import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:moor/moor.dart';

import 'menu/bloc/repository/firebase_stock_model.dart';

FStock globalStock;
List<FStock> globalListOfStock = [];
List<FCategories> globalListOfCategories = [];
FCategories globalCategories;

String getRandString(int len) {
  var random = Random.secure();
  var values = List<int>.generate(len, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

int randomNumber(min, max) {
  var rn = new Random();
  return min + rn.nextInt(max - min);
}

Future<String> uploadImage() async {
  FilePickerResult result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['jpg', 'png'],
  );

  if (result != null) {
    Uint8List fileBytes = result.files.first.bytes;
    //String fileName = result.files.first.name;
    return base64Encode(fileBytes);
  } else {}
  return null;
}

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}
