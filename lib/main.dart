import 'dart:async';

import 'package:c2/Controller/LangController.dart';
import 'package:c2/Controller/LikesController.dart';
import 'package:c2/Controller/SortController.dart';
import 'package:c2/Pages/Httptodos.dart';
import 'package:c2/language/AppLang.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
//import 'package:c2/Controller/NavBarController.dart';
import 'package:c2/Controller/HttpController.dart';
import 'package:get_storage/get_storage.dart';

import 'Controller/NavBarController.dart';
import 'Pages/HttpPost.dart';
import 'Pages/HttpUser.dart';
import 'Pages/Liked.dart';
import 'Pages/MainNavigationWrapper.dart';



Future<void> main()  async {
  await GetStorage.init(); // <-- need
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
  initialBinding: AllControllersBinding(),
    locale: Locale("ar"),
    translations: AppLang() ,
    home: Click(),
    ) );
}

class Click extends StatelessWidget {
  const Click({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Show(),
    );
  }
}



class Show extends StatelessWidget {
  const Show({super.key});


  @override
  Widget build(BuildContext context) {
    Get.find<HttpController>();
    List<StatelessWidget> pages = [
      HttpUser(),
      HttpPost(),
      HttpTodos(),
      LikedItemsPage(),
    ];
    final languageController = Get.find<LanguageController>();

    return Scaffold(
        appBar: AppBar(
          title: Text("Show".tr),
          backgroundColor: Colors.red,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: TextButton(
                onPressed: () {
                  languageController.toggleLanguage();
                },
                child: Text(
                  languageController.isEnglish.value ? "AR" : "EN",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar:MainNavigationWrapper(),

      body: Obx(() {
        return IndexedStack(
          index: Get.find<NavBarController>().tapped.value,
          children: pages,
        );
      }),



    );
  }
}


class AllControllersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HttpController());
    Get.lazyPut(() => NavBarController());
    Get.lazyPut(() => LikesController());
    Get.lazyPut(() => LanguageController());
    Get.lazyPut(() => SortController());
  }
}