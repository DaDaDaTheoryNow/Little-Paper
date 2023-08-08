import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingIndicator extends StatefulWidget {
  final dynamic controller;
  const LoadingIndicator({required this.controller, super.key});

  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator> {
  bool _isTimeout = false;
  Timer? _timer;

  @override
  void initState() {
    _timer = Timer(
        const Duration(seconds: 5),
        () => setState(() {
              _isTimeout = true;
            }));

    super.initState();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            margin: EdgeInsets.only(top: 50.h, bottom: 50.h),
            child: const Center(child: CircularProgressIndicator())),
        SizedBox(
          width: 15.w,
        ),
        _isTimeout
            ? ElevatedButton(
                onPressed: () => widget.controller.handleReloadData(),
                child: const Text("Reload",
                    style: TextStyle(
                      color: Colors.black,
                    )))
            : Container(),
      ],
    );
  }
}
