import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:little_paper/common/services/getx_service/little_paper_service.dart';
import 'package:little_paper/common/theme/app_colors.dart';

import 'package:little_paper/common/widgets/interactive_app_bar.dart';
import 'package:little_paper/pages/searcher/controller.dart';
import 'package:little_paper/pages/searcher/view/widgets/go_button.dart';

class SearcherAppBar extends StatelessWidget {
  const SearcherAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearcherController>(
      builder: (controller) => InteractiveAppBar(
        pinned: true,
        widget: Row(
          children: [
            Expanded(
                child: Obx(
              () => TextField(
                controller: controller.state.textEditingController,
                textInputAction: TextInputAction.search,
                focusNode: controller.state.focusNode,
                onSubmitted: (value) {
                  controller.handleSearchImages(value);
                  LittlePaperService.to.unfocusSearcherAppBar();
                },
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
            )),
            GoButton(() {
              controller.handleSearchImages(
                  controller.state.textEditingController.text);
              LittlePaperService.to.unfocusSearcherAppBar();
            }),
          ],
        ),
      ),
    );
  }
}
