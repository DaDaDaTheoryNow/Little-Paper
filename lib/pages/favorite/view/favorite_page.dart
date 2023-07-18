import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:little_paper/pages/favorite/view/widgets/favorite_images.dart';

import '../../../common/widgets/back_app_bar.dart';
import '../controller.dart';

class FavoritePage extends GetView<FavoriteController> {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => FutureBuilder(
          future: controller.state.favoriteImagesFuture,
          builder: (context, favoriteImagesSnapshot) {
            return CustomScrollView(
                cacheExtent: 3000,
                key: const PageStorageKey("favoriteImages"),
                controller: controller.state.scrollController,
                slivers: [
                  _buildBackAppBar(),
                  FavoriteImages(favoriteImagesSnapshot: favoriteImagesSnapshot)
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
}
