import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:little_paper/common/theme/app_colors.dart';
import 'package:little_paper/pages/explore/controller.dart';

class FavoriteIconButton extends StatelessWidget {
  const FavoriteIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ExploreController exploreController = Get.find<ExploreController>();
    return Stack(
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.favorite),
        ),
        Positioned(
          left: 3.w,
          top: 4.h,
          child: Container(
            height: 15.h,
            width: 15.w,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.black,
                  offset: Offset(
                    1.0.w,
                    1.0.h,
                  )),
            ], borderRadius: BorderRadius.circular(100), color: AppColors.blue),
            child: Center(
              child: Obx(
                () => Text(
                  exploreController.state.favoriteImages.length.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 12.sp),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
