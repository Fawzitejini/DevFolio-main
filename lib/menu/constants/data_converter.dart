import 'dart:convert';
import 'dart:typed_data';

// ignore: import_of_legacy_library_into_null_safe
import 'package:intl/intl.dart';

class DataConverter {
  static Uint8List image(String base_64) {
    try {
      var im = base64.decode(base_64);
      return im;
    } catch (e) {
      return null;
    }
  }

  static String currencyConvert(double number) {
    final oCcy =
        NumberFormat.currency(locale: "fr_MA", symbol: "DH", decimalDigits: 1);

    return oCcy.format(number);
  }

  static String numberConvert(double number) {
    var f = NumberFormat("###.0#", "en_US");
    return f.format(number);
  }
}
