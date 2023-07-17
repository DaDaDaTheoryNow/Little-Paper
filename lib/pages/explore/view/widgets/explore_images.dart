import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:little_paper/common/models/image.dart';
import 'package:little_paper/common/widgets/check_internet_connection.dart';
import 'package:little_paper/common/widgets/hurry_warning.dart';
import 'package:little_paper/common/widgets/nothing_to_view.dart';
import 'package:little_paper/pages/explore/controller.dart';

import '../../../../common/widgets/api_image.dart';

class ExploreImages extends StatelessWidget {
  final AsyncSnapshot<List<ImageModel>> exploreSnapshot;
  const ExploreImages({required this.exploreSnapshot, super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExploreController>(
      builder: ((controller) {
        if (exploreSnapshot.hasError) {
          if (exploreSnapshot.error is DioException &&
              exploreSnapshot.error.toString().contains("Request Cancelled")) {
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
            exploreSnapshot.connectionState == ConnectionState.done) {
          return SliverToBoxAdapter(
            child: NothingToView(
                reloadFunction: () => controller.handleReloadData()),
          );
        }

        if (controller.state.exploreImages.isEmpty &&
            exploreSnapshot.connectionState == ConnectionState.waiting) {
          return SliverToBoxAdapter(
            child: _buildLoading(),
          );
        }

        if (exploreSnapshot.hasData &&
            exploreSnapshot.connectionState == ConnectionState.done) {
          return Obx(
            () => _buildExploreImages(controller),
          );
        }

        return const SliverToBoxAdapter(child: Text("Something don't work :("));
      }),
    );
  }

  _buildLoading() {
    return Container(
        margin: EdgeInsets.only(top: 50.h, bottom: 50.h),
        child: const Center(child: CircularProgressIndicator()));
  }

  _buildExploreImages(ExploreController controller) {
    return SliverGrid(
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
    );
  }
}
