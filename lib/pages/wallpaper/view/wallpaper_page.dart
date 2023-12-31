import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:little_paper/common/widgets/app_bars/back_app_bar.dart';
import 'package:little_paper/common/widgets/buttons/download_button.dart';

import 'package:little_paper/pages/wallpaper/controller.dart';

class WallpaperPage extends GetView<WallpaperController> {
  const WallpaperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          imageUrl: controller.state.imageModel.sampleUrl,
          progressIndicatorBuilder: (context, url, downloadProgress) {
            return Center(
                child: CircularProgressIndicator(
                    value: downloadProgress.progress));
          },
          fit: BoxFit.cover,
        ),
        CustomScrollView(
          slivers: [
            _buildBackAppBar(),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: DownloadButton(() => controller.handleSetWallpaper(),
                    decoration: true),
              ),
            ),
          ],
        )
      ],
    );
  }

  _buildBackAppBar() {
    return BackAppBar(
        title: "id: ${controller.state.imageModel.id}",
        shareFunction: null,
        imageModel: null,
        favoriteFunction: null);
  }
}
