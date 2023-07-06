import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/widgets/bottom_navigation_bar.dart';
import 'state.dart';

class HomeController extends GetxController {
  final state = HomeState();
  HomeController();

  PageController? pageController;
  List<BottomNavyBarItem> bottomNavigationBarItems = [
    BottomNavyBarItem(
      icon: const Icon(
        Icons.explore,
      ),
      activeColor: Colors.white,
      inactiveColor: Colors.white,
      title: const Text("Explore"),
    ),
    BottomNavyBarItem(
        icon: const Icon(
          Icons.search_rounded,
        ),
        activeColor: Colors.white,
        inactiveColor: Colors.white,
        title: const Text("Search")),
    BottomNavyBarItem(
        icon: const Icon(
          Icons.settings,
        ),
        activeColor: Colors.white,
        inactiveColor: Colors.white,
        title: const Text("Settings")),
  ];

  handleOnItemSelected(index) {
    state.currentIndex = index;
    pageController!.jumpToPage(state.currentIndex);
  }

  handleOnPageChanged(index) => state.currentIndex = index;

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }

  @override
  void onClose() {
    pageController!.dispose();
    super.onClose();
  }
}
