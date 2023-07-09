import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:little_paper/common/models/image.dart';
import 'package:little_paper/common/widgets/interactive_app_bar.dart';
import 'package:little_paper/pages/explore/controller.dart';

import '../../../../common/theme/app_colors.dart';

class BackAppBar extends StatelessWidget {
  final String title;
  final void Function()? shareFunction;

  final ImageModel? imageModel;
  final void Function()? favoriteFunction;

  const BackAppBar(
      {required this.title,
      required this.shareFunction,
      required this.imageModel,
      required this.favoriteFunction,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InteractiveAppBar(
      widget: ClipRRect(
        borderRadius: BorderRadius.circular(46),
        child: Row(
          children: [
            _buildBackButton(),
            Expanded(
              child: Text(
                textAlign: TextAlign.center,
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500),
              ),
            ),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Container(
      width: 60.w,
      margin: EdgeInsets.all(5.w),
      child: ElevatedButton(
        onPressed: () => Get.back(),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.grey,
          padding: EdgeInsets.zero,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 3.w,
            ),
            Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 18.sp,
            ),
            SizedBox(
              width: 2.w,
            ),
            Text(
              "Back",
              style: TextStyle(
                color: Colors.white,
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildActionButtons() {
    return Row(
      children: [
        (shareFunction != null)
            ? Container(
                margin: EdgeInsets.symmetric(
                  vertical: 2.h,
                ),
                height: 30.h,
                width: 33.w,
                decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: IconButton(
                  alignment: Alignment.center,
                  onPressed: shareFunction,
                  icon: Icon(
                    Icons.ios_share,
                    color: Colors.white,
                    size: 18.sp,
                  ),
                ),
              )
            : Container(),
        SizedBox(
          width: 5.w,
        ),
        (favoriteFunction != null && imageModel != null)
            ? Container(
                margin: EdgeInsets.fromLTRB(5.w, 2.h, 5.w, 2.h),
                height: 30.h,
                width: 33.w,
                decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: IconButton(
                  onPressed: favoriteFunction,
                  icon: Obx(() {
                    final favoriteImages =
                        Get.find<ExploreController>().state.favoriteImages;

                    final favoriteImage = favoriteImages.firstWhereOrNull(
                        (element) => element.id == imageModel!.id);
                    final isFavorite = favoriteImage?.isFavorite ?? false;

                    return Icon(
                      isFavorite ? Icons.star : Icons.star_border,
                      color: isFavorite ? Colors.yellow : Colors.white,
                    );
                  }),
                  iconSize: 16.h,
                ),
              )
            : Container(),
      ],
    );
  }
}
