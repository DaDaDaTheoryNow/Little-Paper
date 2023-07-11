import 'dart:io';

import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:little_paper/common/services/getx_service/little_paper_service.dart';
import 'package:path_provider/path_provider.dart';

class WallpaperService {
  Dio dio = Dio();
  CancelToken cancelToken = CancelToken();

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
    } catch (e) {
      LittlePaperService.to.resetDonwloadWallpaperImageProgress();
      Get.snackbar("Error", e.toString());
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

      AsyncWallpaper.setWallpaperFromFileNative(
        filePath: savePath,
      );

      LittlePaperService.to.resetDonwloadWallpaperImageProgress();
    } catch (e) {
      LittlePaperService.to.resetDonwloadWallpaperImageProgress();
      Get.snackbar("Error", e.toString());
    }
  }

  void cancelFetchingImage() {
    cancelToken.cancel("Request Cancelled");
    LittlePaperService.to.resetDonwloadWallpaperImageProgress();
    cancelToken = CancelToken();
  }
}
