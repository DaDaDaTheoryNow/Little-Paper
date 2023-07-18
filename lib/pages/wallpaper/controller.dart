import 'package:get/get.dart';
import 'package:little_paper/common/services/wallpaper/wallpaper_service.dart';
import 'package:little_paper/pages/wallpaper/state.dart';
import 'package:little_paper/pages/wallpaper/view/widgets/get_dialog_choice.dart';
import 'package:little_paper/common/widgets/get_dialog_download_progress.dart';
import 'package:little_paper/common/services/android_native/android_native_wallpaper.dart';

class WallpaperController extends GetxController {
  final state = WallpaperState();
  final WallpaperService wallpaperService = WallpaperService();
  final AndroidNativeWallpaperService androidNativeWallpaperService =
      AndroidNativeWallpaperService();

  void saveWallpaperToGallery(String url) async {
    bool permissionsIsGranted =
        await androidNativeWallpaperService.permissionsForWallpaper();

    if (permissionsIsGranted) {
      Get.close(1); // close choice dialog
      getWallpaperDialogDownloadProgress(
          cancelFunction: () => wallpaperService.cancelFetchingImage());
      wallpaperService.saveWallpaperToGalleryFromUrl(url);
    } else {
      Get.snackbar("Error", "You wasn't granted permissions");
    }
  }

  void setWallpaper(String url) async {
    bool permissionsIsGranted =
        await androidNativeWallpaperService.permissionsForWallpaper();

    if (permissionsIsGranted) {
      Get.close(1); // close choice dialog
      getWallpaperDialogDownloadProgress(
          cancelFunction: () => wallpaperService.cancelFetchingImage());
      wallpaperService.setWallpaperFromUrl(url);
    } else {
      Get.snackbar("Error", "You wasn't granted permissions");
    }
  }

  void handleSetWallpaper() async {
    bool permissionsIsGranted =
        await androidNativeWallpaperService.permissionsForWallpaper();

    if (permissionsIsGranted) {
      // dialog with choice what to do
      getWallpaperDialogChoice(
        saveToGalleryFunction: () =>
            saveWallpaperToGallery(state.imageModel.fileUrl),
        setWallpaperFunction: () => setWallpaper(state.imageModel.fileUrl),
      );
    } else {
      Get.snackbar("Error", "You wasn't granted permissions");
    }
  }

  @override
  void onInit() {
    state.imageModel = Get.arguments;
    super.onInit();
  }
}
