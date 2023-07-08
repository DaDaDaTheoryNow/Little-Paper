import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:little_paper/common/widgets/interactive_app_bar.dart';

import '../../../../common/theme/app_colors.dart';

class BackAppBarImage extends StatelessWidget {
  //final ExploreController exploreController;

  const BackAppBarImage({super.key});

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
        Container(
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
            onPressed: () {},
            icon: Icon(
              Icons.ios_share,
              color: Colors.white,
              size: 18.sp,
            ),
          ),
        ),
        SizedBox(
          width: 5.w,
        ),
        Container(
          margin: EdgeInsets.fromLTRB(5.w, 2.h, 5.w, 2.h),
          height: 30.h,
          width: 33.w,
          decoration: BoxDecoration(
            color: AppColors.grey,
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            alignment: Alignment.center,
            onPressed: () {},
            icon: Icon(
              Icons.star_border_outlined,
              color: Colors.white,
              size: 18.sp,
            ),
          ),
        ),
      ],
    );
  }

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
                "Favorite Images",
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
}
