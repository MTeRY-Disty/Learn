import 'package:c2/Pages/HttpPost.dart';
import 'package:c2/Pages/HttpUser.dart';
import 'package:c2/Pages/Httptodos.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class Routes {
  Routes._();
  static const httpUser = "/httpUser";
  static const httpPost = "/httpPost";
  static const httpTodo = "/httpTodo";
  static const page4 = "/page4";
}

class AllPages {
  AllPages._();

  static final pages = [
    GetPage(
      name: Routes.httpUser,
      page: () =>  HttpUser(),
    ),
    GetPage(
      name: Routes.httpPost,
      page: () =>  HttpPost(),
    ),
    GetPage(
      name: Routes.httpTodo,
      page: () => HttpTodos(),
    ),
    GetPage(
      name: Routes.page4,
      page: () => Placeholder()
    ),
  ];
}