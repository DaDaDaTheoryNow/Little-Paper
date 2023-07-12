import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AndroidNativeWallpaper {
  static const MethodChannel _channel = MethodChannel('wallpaper_channel');

  Future<void> setWallpaper({required String savePath}) async {
    try {
      await _channel.invokeMethod('setWallpaper', {'imageUri': savePath});
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
