import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:little_paper/pages/explore/controller.dart';
import 'package:little_paper/pages/explore/view/widgets/explore_images.dart';
import 'package:little_paper/pages/explore/view/widgets/fetch_more_explore_imags.dart';
import 'package:little_paper/pages/explore/view/widgets/tag_app_bar.dart';

class ExplorePage extends GetView<ExploreController> {
  const ExplorePage({super.key});

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

            return LiquidPullToRefresh(
              color: const Color.fromARGB(71, 9, 47, 112),
              showChildOpacityTransition: false,
              animSpeedFactor: 2,
              height: 80.h,
              onRefresh: () => controller.handleReloadData(),
              child: CustomScrollView(
                  cacheExtent: 3000,
                  key: const PageStorageKey("exploreImages"),
                  controller: controller.state.scrollController,
                  slivers: [
                    _buildTagsAppBar(),
                    ExploreImages(
                      exploreSnapshot: exploreSnapshot,
                    ),
                    SliverPadding(
                      padding: EdgeInsets.only(bottom: 60.h),
                      sliver: SliverToBoxAdapter(
                        child: FetchMoreExploreImages(
                            exploreSnapshot: exploreSnapshot),
                      ),
                    ),
                  ]),
            );
          }),
    ));
  }

  _buildTagsAppBar() {
    return TagsAppBar(controller);
  }
}
