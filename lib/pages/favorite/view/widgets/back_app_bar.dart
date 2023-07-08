import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:little_paper/common/widgets/interactive_app_bar.dart';

import '../../../../common/theme/app_colors.dart';
import '../../../explore/controller.dart';

class BackAppBar extends StatelessWidget {
  const BackAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ExploreController exploreController = Get.find<ExploreController>();

    return InteractiveAppBar(
      widget: ClipRRect(
        borderRadius: BorderRadius.circular(46),
        child: Row(
          children: [
            _buildBackButton(),
            Expanded(
                child: Obx(
              () => Text(
                textAlign: TextAlign.center,
                "Favorite Images - ${exploreController.state.favoriteImages.length}",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500),
              ),
            )),
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
}
