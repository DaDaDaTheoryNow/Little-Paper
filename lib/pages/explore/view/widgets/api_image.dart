import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:little_paper/models/image.dart';

class ApiImage extends StatefulWidget {
  final ImageModel imageModel;

  const ApiImage(this.imageModel, {super.key});

  @override
  State<ApiImage> createState() => _ApiImageState();
}

class _ApiImageState extends State<ApiImage> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      repeat: ImageRepeat.repeat,
      imageUrl: widget.imageModel.sampleUrl,
      progressIndicatorBuilder: (context, url, downloadProgress) {
        return Center(
            child: CircularProgressIndicator(value: downloadProgress.progress));
      },
      errorWidget: (context, url, error) => const Icon(Icons.error),
      imageBuilder: (context, imageProvider) {
        return Container(
          margin: EdgeInsets.fromLTRB(5.w, 9.h, 5.w, 3.h),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              image: DecorationImage(
                scale: 0.8,
                image: CachedNetworkImageProvider(widget.imageModel.sampleUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(13),
            ),
          ),
        );
      },
      fadeInDuration: const Duration(milliseconds: 600),
      fadeOutDuration: const Duration(milliseconds: 200),
    );
  }
}
