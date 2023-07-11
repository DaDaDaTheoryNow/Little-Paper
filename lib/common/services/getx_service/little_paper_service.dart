import 'package:get/get.dart';
import 'package:little_paper/pages/wallpaper/controller.dart';

import '../../../pages/home/controller.dart';

class LittlePaperService extends GetxService {
  static LittlePaperService get to => Get.find<LittlePaperService>();

  void changeShowFavorite(bool value) {
    Get.find<HomeController>().state.showFavorite = value;
  }

  void setDonwloadWallpaperImageProgress(int value) {
    Get.find<WallpaperController>().state.downloadProgress = value;
  }

  void resetDonwloadWallpaperImageProgress() {
    Get.back();
    Get.find<WallpaperController>().state.downloadProgress = 0;
  }
}
