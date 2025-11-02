import 'dart:async';

import 'package:c2/Controller/LikesController.dart';
import 'package:c2/Pages/Httptodos.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
//import 'package:c2/Controller/NavBarController.dart';
import 'package:c2/Controller/HttpController.dart';

import 'Controller/NavBarController.dart';
import 'Pages/HttpPost.dart';
import 'Pages/HttpUser.dart';
import 'Pages/Liked.dart';
import 'Pages/MainNavigationWrapper.dart';
import 'core/Routes.dart';



void main()  {

  runApp(GetMaterialApp(
  initialBinding: AllControllersBinding(),
    locale: Locale("en"),
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
    return Scaffold(
        appBar: AppBar(title: Text("Show"),backgroundColor: Colors.red,),
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
  }
}