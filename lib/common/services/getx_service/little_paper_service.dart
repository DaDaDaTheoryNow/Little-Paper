import 'package:get/get.dart';
import 'package:little_paper/common/services/getx_service/services/favorite_service.dart';
import 'package:little_paper/common/services/getx_service/state.dart';
import 'package:little_paper/pages/home/controller.dart';
import 'package:little_paper/pages/searcher/controller.dart';

class LittlePaperService extends GetxService {
  static LittlePaperService get to => Get.find<LittlePaperService>();

  final state = LittlePaperState();

  void changeShowFavorite(bool value) {
    final homeController = Get.find<HomeController>();
    homeController.changeShowFavorite(value);
  }

  void setDonwloadWallpaperImageProgress(int value) {
    state.downloadProgress = value;
  }

  void resetImageDonwloadProgress() {
    closeDownloadDialog();
    state.downloadProgress = 0;
  }

  void closeDownloadDialog() {
    Get.until((route) => !Get.isDialogOpen!);
  }

  void unfocusSearcherAppBar() {
    final searcherController = Get.find<SearcherController>();
    searcherController.unfocusSearcherAppBar();
  }

  bool checkInternetConnection() {
    final homeController = Get.find<HomeController>();
    return homeController.checkInternetConnection();
  }

  Future<void> updateFavoriteImages() async =>
      await FavoriteService().updateFavorite();

  Future<void> favoriteButton(int id) async =>
      await FavoriteService().favoriteButton(id);

  void tagButton(String tag) {
    navigateToHome();
    navigateToSearcher();
    putTagInSearchField(tag);
  }

  void navigateToHome() {
    Get.until((route) => route.settings.name == "/home");
  }

  void navigateToSearcher() {
    final homeController = Get.find<HomeController>();
    homeController.navigateToSearcherPage();
  }

  void putTagInSearchField(String tag) {
    final searcherController = Get.find<SearcherController>();
    searcherController.putTagFromImageToTextField(tag);
  }
}
