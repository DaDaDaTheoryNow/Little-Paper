import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:little_paper/common/services/getx_service/little_paper_service.dart';
import 'package:little_paper/pages/image/controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/widgets/bottom_navigation_bar.dart';
import 'state.dart';

class HomeController extends GetxController {
  final state = HomeState();
  StreamSubscription? subscription;

  HomeController();

  List<BottomNavyBarItem> get bottomNavigationBarItems => [
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
          title: const Text("Search"),
        ),
      ];

  void handleOnItemSelected(int index) {
    state.currentIndex = index;
    state.pageController.jumpToPage(state.currentIndex);

    LittlePaperService.to.unfocusSearcherAppBar();
  }

  void handleOnPageChanged(int index) {
    state.currentIndex = index;
  }

  void handleGoToFavoritePage() {
    Get.delete<ImageController>();
    Get.toNamed("favorite");
  }

  void handleGoToTelegram() async {
    final url = Uri.parse("https://t.me/dadada17");

    if (checkInternetConnection()) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      showInternetConnectionError();
    }
  }

  void navigateToSearcherPage() {
    state.pageController.jumpToPage(1);
  }

  bool checkInternetConnection() {
    return state.internetConnection;
  }

  void changeShowFavorite(value) {
    state.showFavorite = value;
  }

  void showInternetConnectionError() {
    Get.snackbar("Error", "You need an internet connection");
  }

  @override
  void onInit() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      state.internetConnection = (result != ConnectivityResult.none);
    });

    super.onInit();
  }

  @override
  void onClose() {
    subscription?.cancel();
    super.onClose();
  }
}
