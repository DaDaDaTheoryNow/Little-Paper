import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../common/widgets/bottom_navigation_bar.dart';
import 'state.dart';

class HomeController extends GetxController {
  final state = HomeState();
  HomeController();

  StreamSubscription? subscription;
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

  void handleOnItemSelected(index) {
    state.currentIndex = index;
    pageController!.jumpToPage(state.currentIndex);
  }

  void handleOnPageChanged(index) => state.currentIndex = index;

  void handleGoToFavoritePage() {
    Get.toNamed("favorite");
  }

  void handleGoToTelegram() async {
    var url = Uri.parse("https://t.me/dadada17");

    state.internetConnection
        ? await launchUrl(url, mode: LaunchMode.externalApplication)
        : Get.snackbar("Error", "You need internet connection");
  }

  @override
  void onInit() {
    pageController = PageController();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        state.internetConnection = false;
      } else {
        state.internetConnection = true;
      }
    });

    super.onInit();
  }

  @override
  void onClose() {
    pageController!.dispose();
    subscription!.cancel();

    super.onClose();
  }
}
