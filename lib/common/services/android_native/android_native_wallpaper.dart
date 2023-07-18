import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AndroidNativeWallpaperService {
  static const MethodChannel _channel = MethodChannel('wallpaper_channel');

  Future<void> setWallpaper({required String savePath}) async {
    try {
      await _channel.invokeMethod('setWallpaper', {'imageUri': savePath});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<bool> permissionsForWallpaper() async {
    try {
      // bool result
      return await _channel.invokeMethod('permissionsForWallpaper');
    } catch (e) {
      debugPrint(e.toString());
    }

    return false;
  }

  Future<void> shareWallpaper({required String savePath}) async {
    try {
      await _channel.invokeMethod('shareWallpaper', {'imageUri': savePath});
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
