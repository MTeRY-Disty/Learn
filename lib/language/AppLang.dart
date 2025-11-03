import 'package:c2/language/ar.dart';
import 'package:c2/language/en.dart';
import 'package:get/get.dart';


class AppLang extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    "en" : en,
    "ar" : ar,

  };

}