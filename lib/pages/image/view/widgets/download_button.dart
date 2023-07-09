import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class DownloadButton extends StatelessWidget {
  const DownloadButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 3.h),
      height: 40.h,
      width: 250.w,
      child: ElevatedButton(
          onPressed: () {},
          child: const Text(
            "Download & Set Wallpapers",
            style: TextStyle(
              color: Colors.black,
            ),
          )),
    );
  }
}
