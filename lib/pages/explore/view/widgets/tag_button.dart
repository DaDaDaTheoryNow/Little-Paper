import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common/theme/app_colors.dart';
import '../../controller.dart';

class TagButton extends StatelessWidget {
  final String tag;
  final ExploreController exploreController;
  final int index;
  final BuildContext context;
  const TagButton(
      {required this.tag,
      required this.exploreController,
      required this.index,
      required this.context,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5.w),
        child: Obx(
          () => ElevatedButton(
            onPressed: () {
              exploreController.handleTagButton(index);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: (exploreController.state.tags[index][1] == true)
                  ? const Color.fromARGB(255, 8, 52, 128)
                  : AppColors.grey,
            ),
            child: Text(
              tag,
              style: TextStyle(
                color: Colors.white,
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ));
  }
}
