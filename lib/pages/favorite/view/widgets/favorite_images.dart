import 'package:flutter/material.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:little_paper/common/widgets/errors/nothing_to_view.dart';
import 'package:little_paper/pages/favorite/controller.dart';

import '../../../../common/models/image.dart';
import '../../../../common/widgets/api_image.dart';

class FavoriteImages extends StatelessWidget {
  final AsyncSnapshot<List<ImageModel>> favoriteImagesSnapshot;
  const FavoriteImages({required this.favoriteImagesSnapshot, super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavoriteController>(
      builder: ((controller) {
        if (controller.state.favoriteImages.isEmpty &&
            favoriteImagesSnapshot.connectionState == ConnectionState.done) {
          return const SliverToBoxAdapter(
            child: NothingToView(
                title: "Nothing To View, try add your favorite images",
                reloadFunction: null),
          );
        }

        if (favoriteImagesSnapshot.hasData &&
            favoriteImagesSnapshot.connectionState == ConnectionState.done) {
          return _buildFavoriteImages(controller);
        }

        return const SliverToBoxAdapter(child: Text("Something don't work :("));
      }),
    );
  }

  _buildFavoriteImages(FavoriteController controller) {
    return Obx(() => SliverGrid(
          delegate: SliverChildBuilderDelegate(
            childCount: controller.state.imagesCountToView,
            (context, index) => ApiImage(
              controller.state.favoriteImages[index],
              exploreController: null,
              favoriteController: controller,
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
              QuiltedGridTile(2, 2),
              QuiltedGridTile(2, 2),
            ],
          ),
        ));
  }
}
