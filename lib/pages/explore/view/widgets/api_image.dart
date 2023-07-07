import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:little_paper/models/image.dart';
import 'package:little_paper/pages/explore/controller.dart';

import '../../../../common/theme/app_colors.dart';

class ApiImage extends StatelessWidget {
  final ImageModel imageModel;

  const ApiImage(this.imageModel, {super.key});

  @override
  Widget build(BuildContext context) {
    final ExploreController exploreController = Get.find<ExploreController>();

    return CachedNetworkImage(
      repeat: ImageRepeat.repeat,
      imageUrl: imageModel.sampleUrl,
      progressIndicatorBuilder: (context, url, downloadProgress) {
        return Center(
            child: CircularProgressIndicator(value: downloadProgress.progress));
      },
      errorWidget: (context, url, error) => const Icon(Icons.error),
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
                  fit: BoxFit.cover,
                ),
              ),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(13),
              ),
            ),
          ),
          Positioned(
            top: 10.h,
            right: 5.w,
            child: IconButton(
              onPressed: () {
                exploreController.handleFavoriteButton(imageModel.id);
              },
              icon: Obx(() {
                bool favorite = exploreController.state.exploreImages
                    .where((element) => element.id == imageModel.id)
                    .first
                    .isFavorite;
                return Icon(
                  favorite ? Icons.star : Icons.star_border,
                  color: favorite ? Colors.yellow : AppColors.blue,
                );
              }),
              iconSize: 25.h,
            ),
          ),
        ]);
      },
      fadeInDuration: const Duration(milliseconds: 600),
      fadeOutDuration: const Duration(milliseconds: 200),
    );
  }
}
