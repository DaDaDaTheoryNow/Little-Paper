import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:little_paper/common/theme/app_colors.dart';

class GoButton extends StatelessWidget {
  final void Function() goFunction;
  const GoButton(this.goFunction, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.w),
      child: ElevatedButton(
        onPressed: goFunction,
        style: ElevatedButton.styleFrom(backgroundColor: AppColors.grey),
        child: Text(
          "Go",
          textAlign: TextAlign.center,
          maxLines: 1,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
