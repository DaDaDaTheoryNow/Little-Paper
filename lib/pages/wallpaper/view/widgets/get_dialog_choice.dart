import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

getWallpaperDialogChoice(
    {required Function() saveToGalleryFunction,
    required Function() setWallpaperFunction}) {
  return Get.defaultDialog(
      backgroundColor: Colors.black,
      title: "Choise",
      titleStyle: const TextStyle(
        color: Colors.white,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 6.h),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: saveToGalleryFunction,
            child: Text("Save Full Image To Gallery",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                )),
          ),
          Container(
            margin: EdgeInsets.only(top: 4.h),
            child: ElevatedButton(
                onPressed: setWallpaperFunction,
                child: Text("Set Wallpaper",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ))),
          ),
        ],
      ));
}
