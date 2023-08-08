import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:little_paper/common/models/image.dart';
import 'package:little_paper/common/widgets/api_image.dart';

import 'package:little_paper/common/widgets/errors/check_internet_connection.dart';
import 'package:little_paper/common/widgets/errors/nothing_to_view.dart';
import 'package:little_paper/common/widgets/loading_indicator.dart';

import 'package:little_paper/pages/explore/controller.dart';

class ExploreImages extends StatelessWidget {
  final AsyncSnapshot<List<ImageModel>> exploreImagesSnapshot;
  const ExploreImages({required this.exploreImagesSnapshot, super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExploreController>(
      builder: ((controller) {
        if (exploreImagesSnapshot.hasError) {
          if (exploreImagesSnapshot.error is DioException &&
              !exploreImagesSnapshot.error
                  .toString()
                  .contains("Request Cancelled")) {
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
            child: LoadingIndicator(controller: controller),
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
