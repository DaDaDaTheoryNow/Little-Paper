import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:little_paper/common/services/android_native/android_native_wallpaper.dart';
import 'package:little_paper/common/services/getx_service/little_paper_service.dart';
import 'package:path_provider/path_provider.dart';

class WallpaperService {
  final Dio dio = Dio();
  CancelToken cancelToken = CancelToken();
  final androidNativeWallpaper = AndroidNativeWallpaper();

  Future<void> saveWallpaperToGalleryFromUrl(String url) async {
    final Directory tempDict = await getTemporaryDirectory();
    final uri = Uri.parse(url);
    String savePath = "${tempDict.path}/${uri.pathSegments[2]}";

    try {
      await dio.download(url, savePath, onReceiveProgress: (received, total) {
        int percentage = ((received / total) * 100).floor();
        LittlePaperService.to.setDonwloadWallpaperImageProgress(percentage);
      }, cancelToken: cancelToken);

      ImageGallerySaver.saveFile(savePath);

      LittlePaperService.to.resetDonwloadWallpaperImageProgress();
      Get.snackbar("Success", "Image was saved in your gallery!");
    } catch (e) {
      Get.snackbar("Error", "Cancelled");
    }
  }

  Future<void> setWallpaperFromUrl(String url) async {
    final Directory tempDict = await getTemporaryDirectory();
    final uri = Uri.parse(url);
    String savePath = "${tempDict.path}/${uri.pathSegments[2]}";

    try {
      await dio.download(url, savePath, onReceiveProgress: (received, total) {
        int percentage = ((received / total) * 100).floor();
        LittlePaperService.to.setDonwloadWallpaperImageProgress(percentage);
      }, cancelToken: cancelToken);

      // need set wallpaper
      androidNativeWallpaper.setWallpaper(savePath: savePath);

      LittlePaperService.to.resetDonwloadWallpaperImageProgress();
    } catch (e) {
      Get.snackbar("Error", "Cancelled");
    }
  }

  void cancelFetchingImage() {
    cancelToken.cancel("Request Cancelled");
    LittlePaperService.to.resetDonwloadWallpaperImageProgress();
    cancelToken = CancelToken();
  }
}