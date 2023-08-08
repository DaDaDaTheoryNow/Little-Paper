import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FetchMoreLoading extends StatefulWidget {
  final dynamic controller;
  const FetchMoreLoading({required this.controller, super.key});

  @override
  State<FetchMoreLoading> createState() => _FetchMoreLoadingState();
}

class _FetchMoreLoadingState extends State<FetchMoreLoading> {
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
        const Center(child: CircularProgressIndicator()),
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
