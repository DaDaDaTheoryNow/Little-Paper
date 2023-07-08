import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:little_paper/common/widgets/bottom_navigation_bar.dart';
import 'package:little_paper/pages/home/controller.dart';
import 'package:little_paper/pages/home/view/widgets/favorite_icon_button.dart';

import '../../explore/view/explore_page.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildPageView(),
      floatingActionButton: Obx(() => _buildBottomNavigationBar()),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      drawer: const NavigationDrawer(),
    );
  }

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
      actions: const [
        FavoriteIconButton(),
      ],
      iconTheme: const IconThemeData(color: Colors.white),
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
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      width: 80.w,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  children: const [
                    TextSpan(text: 'Made\n'),
                    TextSpan(
                      text: 'by\n',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    TextSpan(text: 'Vladislav\n'),
                    TextSpan(text: 'Smirnov\n'),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                Get.find<HomeController>().handleGoToTelegram();
              },
              icon: const Icon(Icons.telegram),
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
