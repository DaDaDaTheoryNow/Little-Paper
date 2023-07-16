import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:little_paper/common/models/image.dart';
import 'package:little_paper/common/services/getx_service/little_paper_service.dart';
import 'package:little_paper/pages/favorite/controller.dart';
import 'package:little_paper/pages/searcher/controller.dart';

import '../theme/app_colors.dart';
import '../../pages/explore/controller.dart';

class ApiImage extends StatelessWidget {
  final ImageModel imageModel;
  final ExploreController? exploreController;
  final FavoriteController? favoriteController;
  final SearcherController? searcherController;
  final bool isOpened;
  final bool isFillImage;

  const ApiImage(this.imageModel,
      {required this.exploreController,
      required this.favoriteController,
      required this.searcherController,
      required this.isOpened,
      required this.isFillImage,
      super.key});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageModel.sampleUrl,
      progressIndicatorBuilder: (context, url, downloadProgress) {
        return Center(
            child: CircularProgressIndicator(value: downloadProgress.progress));
      },
      errorWidget: (context, url, error) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error,
          ),
          SizedBox(
            height: 10.h,
          ),
          ElevatedButton(
              onPressed: () {
                if (favoriteController != null) {
                  favoriteController!.handleReloadData();
                } else if (exploreController != null) {
                  exploreController!.handleReloadData();
                } else if (searcherController != null) {
                  searcherController!.handleReloadData();
                }
              },
              child: const Text("Reload",
                  style: TextStyle(
                    color: Colors.black,
                  ))),
        ],
      ),
      imageBuilder: (context, imageProvider) {
        return Stack(children: [
          Container(
            margin: EdgeInsets.fromLTRB(5.w, 9.h, 5.w, 3.h),
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                image: DecorationImage(
                  scale: 0.8,
                  image: CachedNetworkImageProvider(imageModel.sampleUrl),
                  fit: (isFillImage) ? BoxFit.fill : BoxFit.cover,
                ),
              ),
              child: (!isOpened)
                  ? InkWell(
                      onTap: () => Get.toNamed("/image", arguments: imageModel),
                      borderRadius: BorderRadius.circular(13),
                    )
                  : null,
            ),
          ),
          (!isOpened)
              ? Positioned(
                  top: 10.h,
                  right: 5.w,
                  child: IconButton(
                    onPressed: () {
                      if (exploreController != null) {
                        LittlePaperService.to.favoriteButton(imageModel.id);
                      }

                      if (favoriteController != null) {
                        favoriteController!.handleFavoriteButton(imageModel.id);
                      }

                      if (searcherController != null) {
                        // need something do
                      }
                    },
                    icon: Obx(() {
                      bool? favorite;

                      if (favoriteController != null) {
                        final favoriteImage = favoriteController!
                            .state.favoriteImages
                            .firstWhereOrNull(
                                (element) => element.id == imageModel.id);
                        favorite = favoriteImage?.isFavorite ?? false;
                      } else if (exploreController != null) {
                        final favoriteImage = exploreController!
                            .state.favoriteImages
                            .firstWhereOrNull(
                                (element) => element.id == imageModel.id);
                        favorite = favoriteImage?.isFavorite ?? false;
                      } else if (searcherController != null) {
                        final favoriteImage = searcherController!
                            .state.favoriteImages
                            .firstWhereOrNull(
                                (element) => element.id == imageModel.id);
                        favorite = favoriteImage?.isFavorite ?? false;
                      }

                      return Icon(
                        favorite! ? Icons.star : Icons.star_border,
                        color: favorite ? Colors.yellow : AppColors.blue,
                      );
                    }),
                    iconSize: 25.h,
                  ),
                )
              : Container(),
        ]);
      },
      fadeInDuration: const Duration(milliseconds: 600),
      fadeOutDuration: const Duration(milliseconds: 200),
    );
  }
}
