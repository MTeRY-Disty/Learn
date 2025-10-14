import 'package:get/get.dart';

import '../core/Routes.dart';

class NavBarController extends GetxController {
  RxInt tapped = 0.obs;

  final List<String> routes = [
    Routes.httpUser,
    Routes.httpPost,
    Routes.httpTodo,
    Routes.page4,
  ];

  void onTap(int index) {
    tapped.value = index;
    Get.toNamed(routes[index]);
  }
}