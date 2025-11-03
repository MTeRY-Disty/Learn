import 'dart:ui';

import 'package:get/get.dart';

class LanguageController extends GetxController {
  var isEnglish = false.obs;

  void toggleLanguage() {
    if (isEnglish.value) {
      Get.updateLocale(Locale('ar'));
    } else {
      Get.updateLocale(Locale('en'));
    }
    isEnglish.toggle();
  }
  String get buttonText => isEnglish.value ? "AR" : "EN";
}

