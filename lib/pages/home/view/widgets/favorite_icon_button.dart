import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteIconButton extends StatelessWidget {
  const FavoriteIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.favorite),
        ),
        Positioned(
          left: 3.w,
          top: 4.h,
          child: Container(
            height: 15.h,
            width: 15.w,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      offset: Offset(
                        1.0.w,
                        1.0.h,
                      )),
                ],
                borderRadius: BorderRadius.circular(100),
                color: const Color.fromARGB(255, 8, 52, 128)),
            child: Center(
              child: Text(
                "0",
                style: TextStyle(color: Colors.white, fontSize: 12.sp),
              ),
            ),
          ),
        )
      ],
    );
  }
}
