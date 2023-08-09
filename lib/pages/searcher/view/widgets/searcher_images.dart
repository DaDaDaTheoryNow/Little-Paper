import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:little_paper/common/models/image.dart';
import 'package:little_paper/common/widgets/errors/check_internet_connection.dart';
import 'package:little_paper/common/widgets/errors/nothing_to_view.dart';
import 'package:little_paper/common/widgets/loading_indicator.dart';

import 'package:little_paper/pages/searcher/controller.dart';

import '../../../../common/widgets/api_image.dart';

class SearcherImages extends StatelessWidget {
  final AsyncSnapshot<List<ImageModel>> searcherImagesSnapshot;
  const SearcherImages({required this.searcherImagesSnapshot, super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearcherController>(
      builder: ((controller) {
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

        if (searcherImagesSnapshot.hasError) {
          if (searcherImagesSnapshot.error is DioException &&
              !searcherImagesSnapshot.error
                  .toString()
                  .contains("Request Cancelled")) {
            return SliverToBoxAdapter(
              child: CheckInternetConnection(
                reloadFunction: () => controller.handleReloadData(),
              ),
            );
          }
        }

        if (controller.state.searcherImages.isEmpty &&
            searcherImagesSnapshot.connectionState == ConnectionState.done) {
          return SliverToBoxAdapter(
            child: NothingToView(
              title: "Nothing To View, try other tags",
              reloadFunction: () => controller.handleReloadData(),
            ),
          );
        }

        if (controller.state.searcherImages.isEmpty &&
            searcherImagesSnapshot.connectionState == ConnectionState.waiting) {
          return SliverToBoxAdapter(
              child: LoadingIndicator(
            controller: controller,
          ));
        }

        if (searcherImagesSnapshot.hasData &&
            searcherImagesSnapshot.connectionState == ConnectionState.done) {
          return _buildSearcherImages(controller);
        }

        return SliverToBoxAdapter(child: Container());
      }),
    );
  }

  _buildSearcherImages(SearcherController controller) {
    return Obx(
      () => SliverGrid(
        delegate: SliverChildBuilderDelegate(
          childCount: controller.state.imagesCountToView,
          (context, index) => ApiImage(
            controller.state.searcherImages[index],
            favoriteController: null,
            exploreController: null,
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
}
