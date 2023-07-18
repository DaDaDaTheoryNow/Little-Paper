import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Rating extends StatelessWidget {
  final String rating;
  const Rating(this.rating, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 30.h,
        width: 70.w,
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(46)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Rating - ",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              rating,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ));
  }
}
