import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckInternetConnection extends StatelessWidget {
  final Function() reloadFunction;
  const CheckInternetConnection({required this.reloadFunction, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          textAlign: TextAlign.center,
          "Any problems. Check Internet Connection",
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
    );
  }
}
