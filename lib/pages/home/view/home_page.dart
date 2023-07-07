import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:little_paper/common/widgets/bottom_navigation_bar.dart';
import 'package:little_paper/pages/home/controller.dart';
import 'package:little_paper/pages/home/view/widgets/favorite_icon_button.dart';

import '../../explore/view/explore_page.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  _buildAppBar() {
    return AppBar(
      title: Obx(() {
        return controller.state.internetConnection
            ? const Text("Little Paper")
            : Text(
                "Little Paper - OFFLINE",
                style: TextStyle(
                  fontSize: 20.sp,
                ),
              );
      }),
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
      ),
      actions: const [
        FavoriteIconButton(),
      ],
    );
  }

  PageView _buildPageView() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: controller.pageController,
      onPageChanged: controller.handleOnPageChanged,
      children: const [
        ExplorePage(),
        Center(child: Text("Search")),
        Center(child: Text("Settings")),
      ],
    );
  }

  BottomNavyBar _buildBottomNavigationBar() {
    return BottomNavyBar(
      selectedIndex: controller.state.currentIndex,
      onItemSelected: controller.handleOnItemSelected,
      showElevation: false,
      borderRadius: BorderRadius.circular(46),
      iconSize: 30,
      itemCornerRadius: 46,
      itemPadding: EdgeInsets.only(left: 15.w),
      backgroundColor: const Color.fromARGB(209, 255, 255, 255),
      items: controller.bottomNavigationBarItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildPageView(),
      floatingActionButton: Obx(() => _buildBottomNavigationBar()),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
