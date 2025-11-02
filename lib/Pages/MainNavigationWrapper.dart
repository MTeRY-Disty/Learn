import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/NavBarController.dart';

class MainNavigationWrapper extends StatelessWidget {
  const MainNavigationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
  return Obx(() {
  final controller = Get.find<NavBarController>();
  return BottomNavigationBar(
  currentIndex: controller.tapped.value,
  onTap: controller.onTap,
  showUnselectedLabels: false,
  unselectedItemColor: const Color(0xFF526400),
  selectedItemColor: Colors.red,
  items: const [
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
  });
  }
  }