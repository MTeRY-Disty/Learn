import 'package:get/get.dart';

import '../core/Routes.dart';

class NavBarController extends GetxController {
  var tapped = 0.obs;



  void onTap(int index) {
    tapped.value = index;
  }
}