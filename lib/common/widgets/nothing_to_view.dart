import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NothingToView extends StatelessWidget {
  final Function() reloadFunction;
  const NothingToView({required this.reloadFunction, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Text(
          "Nothing To View, try other tags",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        ElevatedButton(
          onPressed: reloadFunction,
          child: const Text(
            "Reload",
            style: TextStyle(color: Colors.black),
          ),
        )
      ],
    ));
  }
}
