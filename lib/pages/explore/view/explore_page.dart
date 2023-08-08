import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:little_paper/common/theme/app_colors.dart';
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
          future: controller.state.exploreImagesFuture,
          builder: (context, exploreImagesSnapshot) {
            // Restore scroll position
            WidgetsBinding.instance.addPostFrameCallback((_) {
              controller.state.scrollController.jumpTo(
                controller.state.scrollPosition,
              );
            });

            return RefreshIndicator(
              color: AppColors.blue,
              onRefresh: () => controller.handleReloadData(),
              child: CustomScrollView(
                  cacheExtent: 3000,
                  key: const PageStorageKey("exploreImages"),
                  controller: controller.state.scrollController,
                  slivers: [
                    _buildTagsAppBar(),
                    ExploreImages(
                      exploreImagesSnapshot: exploreImagesSnapshot,
                    ),
                    SliverPadding(
                      padding: EdgeInsets.only(bottom: 60.h),
                      sliver: SliverToBoxAdapter(
                        child: FetchMoreExploreImages(
                            exploreImagesSnapshot: exploreImagesSnapshot),
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
