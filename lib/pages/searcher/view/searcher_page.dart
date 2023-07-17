import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:little_paper/pages/explore/controller.dart';
import 'package:little_paper/pages/home/controller.dart';
import 'package:little_paper/pages/searcher/view/widgets/searcher_app_bar.dart';

import '../../../common/widgets/api_image.dart';
import '../controller.dart';

class SearcherPage extends GetView<SearcherController> {
  const SearcherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => FutureBuilder(
          future: controller.state.fetchDataFuture,
          builder: (context, searcherSnapshot) {
            // Restore scroll position and text in text field
            WidgetsBinding.instance.addPostFrameCallback((_) {
              controller.state.scrollController.jumpTo(
                controller.state.scrollPosition,
              );
              controller.state.textEditingController =
                  TextEditingController(text: controller.state.searcherTags);
            });

            return CustomScrollView(
              cacheExtent: 3000,
              key: const PageStorageKey("searcherImages"),
              controller: controller.state.scrollController,
              slivers: [
                _buildSearcherAppBar(),
                _buildSearcherImages(searcherSnapshot),
                SliverPadding(
                  padding: EdgeInsets.only(bottom: 60.h),
                  sliver: SliverToBoxAdapter(
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.w),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: _buildFetchMoreImages(searcherSnapshot),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    ));
  }

  _buildSearcherAppBar() {
    return const SearcherAppBar();
  }

  _buildSearcherImages(searcherSnapshot) {
    return Builder(
      builder: ((context) {
        if (controller.state.searcherTags.isEmpty) {
          return SliverPadding(
              padding: EdgeInsets.only(top: 10.h),
              sliver: SliverToBoxAdapter(
                child: Center(
                    child: Text(
                  "Search your favorite wallpaper",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
                )),
              ));
        }

        if (searcherSnapshot.hasError) {
          if (searcherSnapshot.error is DioException &&
              searcherSnapshot.error.toString().contains("Request Cancelled")) {
            return SliverToBoxAdapter(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  "Are you in a hurry somewhere?",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  textAlign: TextAlign.center,
                  "You will have to wait to continue.",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
                ),
              ],
            ));
          } else {
            return SliverToBoxAdapter(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  "Any problems. Check Internet Connection",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                ElevatedButton(
                  onPressed: () => controller.handleReloadData(),
                  child: const Text(
                    "Reload",
                    style: TextStyle(color: Colors.black),
                  ),
                )
              ],
            ));
          }
        }

        if (controller.state.searcherImages.isEmpty &&
            searcherSnapshot.connectionState == ConnectionState.done) {
          return SliverToBoxAdapter(
              child: Center(
                  child: Column(
            children: [
              Text(
                "Nothing To View, try other tags",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              ElevatedButton(
                onPressed: () => controller.handleReloadData(),
                child: const Text(
                  "Reload",
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          )));
        }

        if (controller.state.searcherImages.isEmpty &&
            searcherSnapshot.connectionState == ConnectionState.waiting) {
          return SliverPadding(
              padding: EdgeInsets.only(top: 50.h, bottom: 50.h),
              sliver: const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              ));
        }

        if (searcherSnapshot.hasData &&
            searcherSnapshot.connectionState == ConnectionState.done) {
          return Obx(
            () => SliverGrid(
              delegate: SliverChildBuilderDelegate(
                childCount: controller.state.imagesCountToView,
                (context, index) => ApiImage(
                  controller.state.searcherImages[index],
                  favoriteController: null,
                  exploreController: Get.find<ExploreController>(),
                  searcherController: controller,
                  isOpened: false,
                  isFillImage: false,
                ),
              ),
              gridDelegate: SliverQuiltedGridDelegate(
                crossAxisCount: 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                repeatPattern: QuiltedGridRepeatPattern.inverted,
                pattern: const [
                  QuiltedGridTile(2, 1),
                  QuiltedGridTile(1, 1),
                  QuiltedGridTile(1, 1),
                ],
              ),
            ),
          );
        }

        return SliverToBoxAdapter(child: Container());
      }),
    );
  }

  _buildFetchMoreImages(searcherSnapshot) {
    return Obx(() {
      if (controller.state.searcherImages.isNotEmpty &&
          !controller.state.fetchingMoreImages &&
          searcherSnapshot.connectionState == ConnectionState.done) {
        return ElevatedButton(
          onPressed: () async {
            final internetConnection =
                Get.find<HomeController>().state.internetConnection;

            if (internetConnection) {
              await controller.handleFetchingMoreImages();
            } else {
              Get.snackbar(
                  "Error", "For loading more images need internet connection");
            }
          },
          child: const Text(
            "More",
            style: TextStyle(color: Colors.black),
          ),
        );
      }

      if (controller.state.fetchingMoreImages == true) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      return Container();
    });
  }
}
