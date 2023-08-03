import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:little_paper/common/services/getx_service/little_paper_service.dart';
import 'package:little_paper/common/services/wallpaper/wallpaper_native_service.dart';
import 'package:path_provider/path_provider.dart';

class WallpaperService {
  final Dio dio = Dio(
    BaseOptions(
      responseType: ResponseType.bytes,
    ),
  );

  CancelToken cancelToken = CancelToken();

  final WallpaperNativeService wallpaperNativeService =
      WallpaperNativeService();

  Future<bool> setFromUrl(String url) async {
    if (!await wallpaperNativeService.permissionsForWallpaper()) {
      LittlePaperService.to.resetImageDonwloadProgress();
      return false;
    }

    try {
      final response =
          await dio.get<Uint8List>(url, onReceiveProgress: (received, total) {
        int percentage = ((received / total) * 100).floor();
        LittlePaperService.to.setDonwloadWallpaperImageProgress(percentage);
      }, cancelToken: cancelToken);

      wallpaperNativeService.setFromBytes(imageBytes: response.data);

      LittlePaperService.to.resetImageDonwloadProgress();
      return true;
    } catch (e) {
      onError(e);
    }

    return false;
  }

  Future<bool> shareFromUrl(String url) async {
    if (!await wallpaperNativeService.permissionsForWallpaper()) {
      LittlePaperService.to.resetImageDonwloadProgress();
      return false;
    }

    try {
      final response =
          await dio.get<Uint8List>(url, onReceiveProgress: (received, total) {
        int percentage = ((received / total) * 100).floor();
        LittlePaperService.to.setDonwloadWallpaperImageProgress(percentage);
      }, cancelToken: cancelToken);

      wallpaperNativeService.shareWallpaper(imageBytes: response.data);

      LittlePaperService.to.resetImageDonwloadProgress();
      return true;
    } catch (e) {
      onError(e);
    }

    return false;
  }

  Future<bool> saveToGalleryFromUrl(String url) async {
    if (!await wallpaperNativeService.permissionsForWallpaper()) {
      LittlePaperService.to.resetImageDonwloadProgress();
      return false;
    }

    final Directory tempDict = await getTemporaryDirectory();
    final uri = Uri.parse(url);
    String savePath = "${tempDict.path}/${uri.pathSegments[2]}";

    try {
      await dio.download(url, savePath, onReceiveProgress: (received, total) {
        int percentage = ((received / total) * 100).floor();
        LittlePaperService.to.setDonwloadWallpaperImageProgress(percentage);
      }, cancelToken: cancelToken);

      ImageGallerySaver.saveFile(savePath);

      LittlePaperService.to.resetImageDonwloadProgress();
      Get.snackbar("Success", "Image was saved in your gallery!");
      return true;
    } catch (e) {
      onError(e);
    }

    return false;
  }

  void onError(e) {
    if (e.toString().contains("Request Cancelled")) {
      Get.snackbar("Error", "Cancelled");
    } else if (e.toString().contains("Failed host lookup")) {
      LittlePaperService.to.resetImageDonwloadProgress();
      Get.snackbar("Error", "Check your internet connection");
    } else {
      LittlePaperService.to.resetImageDonwloadProgress();
      Get.snackbar("Error", "$e");
      debugPrint(e);
    }
  }

  void cancelFetchingImage() {
    cancelToken.cancel("Request Cancelled");
    LittlePaperService.to.resetImageDonwloadProgress();
    cancelToken = CancelToken();
  }
}
