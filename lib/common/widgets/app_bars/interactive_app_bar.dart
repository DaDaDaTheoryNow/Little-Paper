import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:little_paper/common/theme/app_colors.dart';

class InteractiveAppBar extends StatelessWidget {
  final Widget widget;
  final bool pinned;

  const InteractiveAppBar(
      {required this.widget, required this.pinned, super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      floating: true,
      snap: true,
      pinned: pinned,
      toolbarHeight: 41.h,
      backgroundColor: AppColors.opacityGrey,
      flexibleSpace: Padding(
        padding: EdgeInsets.only(right: 7.w, left: 7.w, top: 4.h, bottom: 4.h),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(46), color: Colors.black),
            child: widget),
      ),
    );
  }
}
