import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:little_paper/pages/explore/controller.dart';

import '../../../common/widgets/back_app_bar.dart';
import '../controller.dart';
import '../../../common/widgets/api_image.dart';

class FavoritePage extends GetView<FavoriteController> {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => FutureBuilder(
          future: controller.state.fetchDataFuture,
          builder: (context, exploreSnapshot) {
            // Restore scroll position
            WidgetsBinding.instance.addPostFrameCallback((_) {
              controller.state.scrollController.jumpTo(
                controller.state.scrollPosition,
              );
            });

            return CustomScrollView(
                cacheExtent: 3000,
                key: const PageStorageKey("exploreImages"),
                controller: controller.state.scrollController,
                slivers: [
                  _buildBackAppBar(),
                  _buildExploreImages(exploreSnapshot),
                ]);
          }),
    ));
  }

  _buildBackAppBar() {
    return const BackAppBar(
      title: "Favorite Images",
      shareFunction: null,
      imageModel: null,
      favoriteFunction: null,
    );
  }

  _buildExploreImages(exploreSnapshot) {
    return Builder(
      builder: ((context) {
        if (exploreSnapshot.hasError) {
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

        if (controller.state.favoriteImages.isEmpty &&
            exploreSnapshot.connectionState == ConnectionState.done) {
          return SliverToBoxAdapter(
              child: Center(
                  child: Text(
            textAlign: TextAlign.center,
            "Nothing To View, try add your like images",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),
          )));
        }

        if (controller.state.favoriteImages.isEmpty &&
            exploreSnapshot.connectionState == ConnectionState.waiting) {
          return SliverPadding(
              padding: EdgeInsets.only(top: 50.h, bottom: 50.h),
              sliver: const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              ));
        }

        if (exploreSnapshot.hasData &&
            exploreSnapshot.connectionState == ConnectionState.done) {
          return Obx(
            () => SliverGrid(
              delegate: SliverChildBuilderDelegate(
                childCount: controller.state.imagesCountToView,
                (context, index) => ApiImage(
                  controller.state.favoriteImages[index],
                  exploreController: Get.find<ExploreController>(),
                  favoriteController: controller,
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
                  QuiltedGridTile(2, 2),
                  QuiltedGridTile(2, 2),
                ],
              ),
            ),
          );
        }

        return SliverToBoxAdapter(
            child: Center(
          child: ElevatedButton(
            onPressed: () => controller.handleReloadData(),
            child: const Text(
              "Reload",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ));
      }),
    );
  }
}
