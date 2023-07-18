import 'package:get/get.dart';
import 'package:little_paper/common/services/getx_service/services/favorite_service.dart';
import 'package:little_paper/common/services/getx_service/state.dart';

import 'package:little_paper/pages/searcher/controller.dart';

import '../../../pages/home/controller.dart';

class LittlePaperService extends GetxService {
  static LittlePaperService get to => Get.find<LittlePaperService>();

  final state = LittlePaperState();

  void changeShowFavorite(bool value) {
    Get.find<HomeController>().state.showFavorite = value;
  }

  void setDonwloadWallpaperImageProgress(int value) {
    state.downloadProgress = value;
  }

  void resetDonwloadWallpaperImageProgress() {
    Get.close(1);
    state.downloadProgress = 0;
  }

  void unfocusSearcherAppBar() {
    if (Get.isRegistered<SearcherController>()) {
      Get.find<SearcherController>().state.focusNode.unfocus();
    }
  }

  bool checkInternetConnection() {
    return Get.find<HomeController>().state.internetConnection;
  }

  Future<void> updateFavoriteImages() async =>
      await FavoriteService().updateFavorite();

  Future<void> favoriteButton(int id) async =>
      await FavoriteService().favoriteButton(id);
}
