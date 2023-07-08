import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:little_paper/common/widgets/interactive_app_bar.dart';
import 'package:little_paper/pages/explore/controller.dart';

import '../../../../common/theme/app_colors.dart';

class TagsAppBar extends StatelessWidget {
  final ExploreController exploreController;

  const TagsAppBar(this.exploreController, {super.key});

  @override
  Widget build(BuildContext context) {
    final tags = exploreController.state.tags;

    return InteractiveAppBar(
      widget: ClipRRect(
        borderRadius: BorderRadius.circular(46),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              tags.length,
              (index) => _buildTagButton(
                  tags[index][0], exploreController, index, context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTagButton(String tag, ExploreController exploreController,
      int index, BuildContext context) {
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
