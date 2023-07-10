import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowTagsButton extends StatelessWidget {
  final void Function() showFunction;
  const ShowTagsButton(this.showFunction, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      child: ElevatedButton(
          onPressed: showFunction,
          child: const Text(
            "Show Tags",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic,
            ),
          )),
    );
  }
}
