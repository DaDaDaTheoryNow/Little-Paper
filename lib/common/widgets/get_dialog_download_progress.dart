import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:little_paper/common/services/getx_service/little_paper_service.dart';

getWallpaperDialogDownloadProgress({required Function() cancelFunction}) {
  return Get.defaultDialog(
      onWillPop: () async {
        return Future.value(false);
      },
      backgroundColor: Colors.black,
      title: "Download...",
      barrierDismissible: false,
      titleStyle: const TextStyle(
        color: Colors.white,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 6.h),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => Text(
              "Progress: ${LittlePaperService.to.state.downloadProgress}%",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          ElevatedButton(
              onPressed: cancelFunction,
              child: Text("Cancel",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ))),
        ],
      ));
}