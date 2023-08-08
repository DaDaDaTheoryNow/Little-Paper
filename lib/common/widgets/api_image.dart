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

class ApiImage extends StatefulWidget {
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
  State<ApiImage> createState() => _ApiImageState();
}

class _ApiImageState extends State<ApiImage> {
  bool _imageError = false;

  @override
  Widget build(BuildContext context) {
    return _imageError
        ? Column(
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
                    CachedNetworkImageProvider(widget.imageModel.sampleUrl)
                        .resolve(ImageConfiguration.empty);
                    setState(() {
                      _imageError = false;
                    });
                  },
                  child: const Text("Reload",
                      style: TextStyle(
                        color: Colors.black,
                      ))),
            ],
          )
        : CachedNetworkImage(
            imageUrl: widget.imageModel.sampleUrl,
            progressIndicatorBuilder: (context, url, downloadProgress) {
              return Center(
                  child: CircularProgressIndicator(
                      value: downloadProgress.progress));
            },
            errorWidget: (context, url, error) {
              Future.microtask(() => setState(() {
                    _imageError = true;
                  }));

              return Container();
            },
            imageBuilder: (context, imageProvider) {
              return Stack(children: [
                Container(
                  margin: EdgeInsets.fromLTRB(5.w, 9.h, 5.w, 3.h),
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      image: DecorationImage(
                        scale: 0.8,
                        image: CachedNetworkImageProvider(
                            widget.imageModel.sampleUrl),
                        fit: (widget.isFillImage) ? BoxFit.fill : BoxFit.cover,
                      ),
                    ),
                    child: (!widget.isOpened)
                        ? InkWell(
                            onTap: () {
                              Get.toNamed("/image",
                                  arguments: widget.imageModel);
                              if (widget.searcherController != null) {
                                LittlePaperService.to.unfocusSearcherAppBar();
                              }
                            },
                            borderRadius: BorderRadius.circular(13),
                          )
                        : null,
                  ),
                ),
                (!widget.isOpened)
                    ? Positioned(
                        top: 10.h,
                        right: 5.w,
                        child: IconButton(
                          onPressed: () {
                            LittlePaperService.to
                                .favoriteButton(widget.imageModel.id);
                          },
                          icon: Obx(() {
                            bool? favorite;

                            final favoriteImage = LittlePaperService
                                .to.state.favoriteImages
                                .firstWhereOrNull((element) =>
                                    element.id == widget.imageModel.id);
                            favorite = favoriteImage?.isFavorite ?? false;

                            return Icon(
                              favorite ? Icons.star : Icons.star_border,
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
