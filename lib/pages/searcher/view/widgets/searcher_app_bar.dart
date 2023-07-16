import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:little_paper/common/theme/app_colors.dart';

import 'package:little_paper/common/widgets/interactive_app_bar.dart';
import 'package:little_paper/pages/searcher/controller.dart';
import 'package:little_paper/pages/searcher/view/widgets/go_button.dart';

class SearcherAppBar extends StatelessWidget {
  const SearcherAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final SearcherController searcherController =
        Get.find<SearcherController>();
    String? tags;

    return InteractiveAppBar(
      widget: Row(
        children: [
          Expanded(
            child: TextField(
              onSubmitted: (value) =>
                  searcherController.handleSearchImages(value),
              onChanged: (value) => tags = value,
              textAlign: TextAlign.start,
              cursorColor: AppColors.blue,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
              ),
              cursorOpacityAnimates: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10.w),
                hintText: "for example: 1girl red_eyes",
                hintStyle: TextStyle(
                  color: AppColors.grey,
                  fontSize: 13.sp,
                ),
                hintMaxLines: 1,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(46),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(46),
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(46),
                  borderSide: const BorderSide(
                    color: AppColors.grey,
                  ),
                ),
              ),
            ),
          ),
          GoButton(() => searcherController.handleSearchImages(tags ?? "")),
        ],
      ),
    );
  }
}
