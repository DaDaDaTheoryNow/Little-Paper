import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WallpaperNativeService {
  static const MethodChannel _channel = MethodChannel('wallpaper_channel');

  setFromBytes({required imageBytes}) async {
    try {
      _channel.invokeMethod('setWallpaper', {'imageBytes': imageBytes});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  shareWallpaper({required imageBytes}) async {
    try {
      _channel.invokeMethod('shareWallpaper', {'imageBytes': imageBytes});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<bool> permissionsForWallpaper() async {
    try {
      return await _channel.invokeMethod('permissionsForWallpaper');
    } catch (e) {
      debugPrint(e.toString());
    }

    return false;
  }
}
