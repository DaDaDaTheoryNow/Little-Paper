import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:little_paper/common/models/image.dart';

import 'package:little_paper/common/widgets/errors/check_internet_connection.dart';
import 'package:little_paper/common/widgets/errors/hurry_warning.dart';
import 'package:little_paper/common/widgets/errors/nothing_to_view.dart';

import 'package:little_paper/pages/explore/controller.dart';

import '../../../../common/widgets/api_image.dart';

class ExploreImages extends StatelessWidget {
  final AsyncSnapshot<List<ImageModel>> exploreImagesSnapshot;
  const ExploreImages({required this.exploreImagesSnapshot, super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExploreController>(
      builder: ((controller) {
        if (exploreImagesSnapshot.hasError) {
          if (exploreImagesSnapshot.error is DioException &&
              exploreImagesSnapshot.error
                  .toString()
                  .contains("Request Cancelled")) {
            return const SliverToBoxAdapter(
              child: HurryWarning(),
            );
          } else {
            return SliverToBoxAdapter(
              child: CheckInternetConnection(
                  reloadFunction: () => controller.handleReloadData()),
            );
          }
        }

        if (controller.state.exploreImages.isEmpty &&
            exploreImagesSnapshot.connectionState == ConnectionState.done) {
          return SliverToBoxAdapter(
            child: NothingToView(
                title: "Nothing To View, try other tags",
                reloadFunction: () => controller.handleReloadData()),
          );
        }

        if (controller.state.exploreImages.isEmpty &&
            exploreImagesSnapshot.connectionState == ConnectionState.waiting) {
          return SliverToBoxAdapter(
            child: _buildLoading(controller),
          );
        }

        if (exploreImagesSnapshot.hasData &&
            exploreImagesSnapshot.connectionState == ConnectionState.done) {
          return _buildExploreImages(controller);
        }

        return const SliverToBoxAdapter(child: Text("Something don't work :("));
      }),
    );
  }

  _buildLoading(ExploreController controller) {
    // fix long loading need
    return Container(
        margin: EdgeInsets.only(top: 50.h, bottom: 50.h),
        child: const Center(child: CircularProgressIndicator()));
  }

  _buildExploreImages(ExploreController controller) {
    return Obx(() => SliverGrid(
          delegate: SliverChildBuilderDelegate(
            childCount: controller.state.imagesCountToView,
            (context, index) => ApiImage(
              controller.state.exploreImages[index],
              favoriteController: null,
              exploreController: controller,
              searcherController: null,
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
        ));
  }
}
