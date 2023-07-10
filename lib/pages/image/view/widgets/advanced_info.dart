import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:little_paper/pages/image/controller.dart';

TextStyle _advancedInfoTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w500,
  fontSize: 14.sp,
);

class AdvancedInfo extends StatelessWidget {
  const AdvancedInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImageController>(
        builder: ((controller) => Container(
              margin: EdgeInsets.only(left: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.check_circle),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        controller.state.imageModel.status,
                        style: _advancedInfoTextStyle,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.w,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.child_care_rounded),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        controller.state.imageModel.hasChildren ? "YES" : "NO",
                        style: _advancedInfoTextStyle,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.w,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.date_range),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        "Created at ${controller.state.imageModel.createdAt}",
                        style: _advancedInfoTextStyle,
                      )
                    ],
                  )
                ],
              ),
            )));
  }
}
