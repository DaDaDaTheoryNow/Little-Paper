import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';

class DownloadButton extends StatelessWidget {
  final void Function() downloadFunction;
  final bool decoration;
  const DownloadButton(this.downloadFunction,
      {required this.decoration, super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "downloadbtn",
      child: Container(
        padding: decoration ? null : EdgeInsets.only(top: 5.h),
        margin: decoration ? EdgeInsets.only(bottom: 10.h) : null,
        height: 40.h,
        width: 250.w,
        decoration: decoration
            ? BoxDecoration(
                color: AppColors.opacityGrey,
                borderRadius: BorderRadius.circular(46),
              )
            : null,
        child: decoration
            ? OutlinedButton(
                onPressed: downloadFunction,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white),
                ),
                child: Text(
                  "Download & Set Wallpapers",
                  style: TextStyle(
                    color: decoration ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                ))
            : ElevatedButton(
                onPressed: downloadFunction,
                child: Text(
                  "Download & Set Wallpapers",
                  style: TextStyle(
                    color: decoration ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                )),
      ),
    );
  }
}
