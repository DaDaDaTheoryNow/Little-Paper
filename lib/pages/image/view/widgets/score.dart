import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Score extends StatelessWidget {
  final int score;
  const Score(this.score, {super.key});

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
            Icon(
              Icons.favorite,
              color: Colors.red,
              size: 18.sp,
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              score.toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ));
  }
}
