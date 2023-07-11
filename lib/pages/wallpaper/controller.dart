import 'package:get/get.dart';
import 'package:little_paper/common/services/wallpaper/wallpaper_service.dart';
import 'package:little_paper/pages/wallpaper/state.dart';
import 'package:little_paper/pages/wallpaper/view/widgets/get_dialog_choice.dart';
import 'package:little_paper/pages/wallpaper/view/widgets/get_dialog_download_progress.dart';

class WallpaperController extends GetxController {
  final state = WallpaperState();
  WallpaperController();

  final WallpaperService wallpaperService = WallpaperService();

  saveWallpaperToGallery(url) async {
    Get.back();
    getWallpaperDialogDownloadProgress(
        cancelFunction: () => wallpaperService.cancelFetchingImage());
    wallpaperService.saveWallpaperToGalleryFromUrl(url);
  }

  setWallpaper(url) async {
    Get.back();
    getWallpaperDialogDownloadProgress(
        cancelFunction: () => wallpaperService.cancelFetchingImage());
    wallpaperService.setWallpaperFromUrl(url);
  }

  void handleSetWallpaper() async {
    getWallpaperDialogChoice(
        saveToGalleryFunction: () =>
            saveWallpaperToGallery(state.imageModel.fileUrl),
        setWallpaperFunction: () => setWallpaper(state.imageModel.fileUrl));
  }

  @override
  void onInit() {
    state.imageModel = Get.arguments;
    super.onInit();
  }
}
