import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:little_paper/pages/explore/controller.dart';
import 'package:little_paper/pages/explore/view/widgets/api_image.dart';
import 'package:little_paper/pages/explore/view/widgets/tag_app_bar.dart';

class ExplorePage extends GetView<ExploreController> {
  const ExplorePage({super.key});

  _buildAppBar() {
    return TagsAppBar(controller);
  }

  _buildExploreImages(exploreSnapshot) {
    return Builder(
      builder: ((context) {
        if (exploreSnapshot.hasError) {
          return SliverToBoxAdapter(
              child: Center(
                  child: Text(
            textAlign: TextAlign.center,
            "Any problems. Check Internet Connection",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),
          )));
        }
        if (controller.state.exploreImages.isEmpty &&
            exploreSnapshot.connectionState == ConnectionState.done) {
          return SliverToBoxAdapter(
              child: Center(
                  child: Text(
            "Nothing To View, try other tags",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),
          )));
        }

        if (controller.state.exploreImages.isEmpty &&
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
                (context, index) =>
                    ApiImage(controller.state.exploreImages[index]),
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

  _buildFetchMoreImages(exploreSnapshot) {
    return Obx(() {
      if (controller.state.exploreImages.isNotEmpty &&
          !controller.state.fetchingMoreImages &&
          exploreSnapshot.connectionState == ConnectionState.done) {
        return ElevatedButton(
          onPressed: () async => await controller.handleFetchingMoreImages(),
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
                  _buildAppBar(),
                  _buildExploreImages(exploreSnapshot),
                  SliverPadding(
                    padding: EdgeInsets.only(bottom: 60.h),
                    sliver: SliverToBoxAdapter(
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.w),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: _buildFetchMoreImages(exploreSnapshot),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]);
          }),
    ));
  }
}
