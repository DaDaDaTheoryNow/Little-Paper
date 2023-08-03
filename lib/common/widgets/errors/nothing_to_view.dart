import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NothingToView extends StatelessWidget {
  final String title;
  final Function()? reloadFunction;
  const NothingToView(
      {required this.title, required this.reloadFunction, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        SizedBox(
          height: 4.h,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 19.sp,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        (reloadFunction != null)
            ? ElevatedButton(
                onPressed: reloadFunction,
                child: const Text(
                  "Reload",
                  style: TextStyle(color: Colors.black),
                ),
              )
            : Container(),
      ],
    ));
  }
}
