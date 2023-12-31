import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:little_paper/common/widgets/bottom_navigation_bar.dart';
import 'package:little_paper/pages/home/controller.dart';
import 'package:little_paper/pages/searcher/view/searcher_page.dart';

import '../../explore/view/explore_page.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageView(),
      floatingActionButton: Obx(() => _buildBottomNavigationBar()),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  PageView _buildPageView() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: controller.state.pageController,
      onPageChanged: controller.handleOnPageChanged,
      children: const [
        ExplorePage(),
        SearcherPage(),
      ],
    );
  }

  BottomNavyBar _buildBottomNavigationBar() {
    return BottomNavyBar(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      selectedIndex: controller.state.currentIndex,
      onItemSelected: controller.handleOnItemSelected,
      showElevation: false,
      borderRadius: BorderRadius.circular(46),
      iconSize: 30,
      itemCornerRadius: 46,
      itemPadding: EdgeInsets.only(left: 10.w),
      backgroundColor: const Color.fromARGB(209, 255, 255, 255),
      items: controller.bottomNavigationBarItems,
    );
  }
}
