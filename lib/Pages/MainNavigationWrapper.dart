import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/NavBarController.dart';
import 'HttpPost.dart';
import 'HttpUser.dart';

class MainNavigationWrapper extends StatelessWidget {
  const MainNavigationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Show"),
        backgroundColor: Colors.red,
      ),
      bottomNavigationBar: GetBuilder<NavBarController>(builder: (controllerNav) {
        return BottomNavigationBar(
          currentIndex: controllerNav.tapped.value,
          onTap: controllerNav.onTap,
          showUnselectedLabels: false,
          unselectedItemColor: const Color(0xFF526400),
          selectedItemColor: Colors.red,
          items: [
            BottomNavigationBarItem(
              icon: Icon(FluentSystemIcons.ic_fluent_person_accounts_regular),
              label: "profile",
              activeIcon: Icon(FluentSystemIcons.ic_fluent_person_accounts_filled),
            ),
            BottomNavigationBarItem(
              icon: Icon(FluentSystemIcons.ic_fluent_photo_filter_regular),
              label: "photos",
              activeIcon: Icon(FluentSystemIcons.ic_fluent_photo_filter_filled),
            ),
            BottomNavigationBarItem(
              icon: Icon(FluentSystemIcons.ic_fluent_add_circle_regular),
              label: "c",
              activeIcon: Icon(FluentSystemIcons.ic_fluent_add_circle_filled),
            ),
            BottomNavigationBarItem(
              icon: Icon(FluentSystemIcons.ic_fluent_system_regular),
              label: "b",
              activeIcon: Icon(FluentSystemIcons.ic_fluent_system_filled),
            ),
          ],
        );
      }),
      body: GetBuilder<NavBarController>(
        builder: (controllerNav) {
          // This will show the current page based on navigation
          return Navigator(
            key: Get.nestedKey(1), // Important for nested navigation
            onGenerateRoute: (settings) {
              switch (controllerNav.tapped.value) {
                case 0:
                  return GetPageRoute(page: () =>  HttpUser());
                case 1:
                  return GetPageRoute(page: () =>  HttpPost());
                case 2:
                  return GetPageRoute(page: () => const Center(child: Text("Page 3")));
                case 3:
                  return GetPageRoute(page: () => const Center(child: Text("Page 4")));
                default:
                  return GetPageRoute(page: () => const Center(child: Text("Page 4")));
              }
            },
          );
        },
      ),
    );
  }
}