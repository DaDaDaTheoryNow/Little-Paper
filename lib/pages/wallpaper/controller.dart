import 'package:get/get.dart';
import 'package:little_paper/common/services/wallpaper/wallpaper_native_service.dart';
import 'package:little_paper/common/services/wallpaper/wallpaper_service.dart';

import 'package:little_paper/common/widgets/dialogs/dialog_with_image_download_progress.dart';
import 'package:little_paper/common/widgets/dialogs/dialog_with_wallpaper_action_choice.dart';
import 'package:little_paper/pages/wallpaper/state.dart';

class WallpaperController extends GetxController {
  final state = WallpaperState();

  final WallpaperService wallpaperService = WallpaperService();
  final WallpaperNativeService wallpaperNativeService =
      WallpaperNativeService();

  void handleSetWallpaper() {
    // dialog with choice what to do
    dialogWithWallpaperActionChoice(
      saveToGalleryFunction: () =>
          saveWallpaperToGallery(state.imageModel.fileUrl),
      setFunction: () => setWallpaper(state.imageModel.fileUrl),
    );
  }

  void saveWallpaperToGallery(String url) {
    Get.until((route) => !Get.isDialogOpen!); // close choice dialog
    dialogWithImageDownloadProgress(
        function: () => wallpaperService.saveToGalleryFromUrl(url),
        cancelFunction: () => wallpaperService.cancelFetchingImage());
  }

  void setWallpaper(String url) {
    Get.until((route) => !Get.isDialogOpen!); // close choice dialog
    dialogWithImageDownloadProgress(
        function: () => wallpaperService.setFromUrl(url),
        cancelFunction: () => wallpaperService.cancelFetchingImage());
  }

  @override
  void onInit() {
    state.imageModel = Get.arguments;
    super.onInit();
  }
}
