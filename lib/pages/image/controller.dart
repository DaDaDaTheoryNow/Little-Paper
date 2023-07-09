import 'package:get/get.dart';
import 'package:little_paper/pages/explore/controller.dart';
import 'package:little_paper/pages/favorite/controller.dart';
import 'package:little_paper/pages/home/controller.dart';

import 'state.dart';

class ImageController extends GetxController {
  final state = ImageState();
  ImageController();

  void handleFavoriteButton() {
    bool favoriteControllerRegistered = Get.isRegistered<FavoriteController>();
    if (favoriteControllerRegistered) {
      Get.find<FavoriteController>().handleFavoriteButton(state.imageModel.id);
    }

    Get.find<ExploreController>().handleFavoriteButton(state.imageModel.id);
  }

  void handleChangeImageView(bool value) {
    state.isFillImage = value;
  }

  void changeShowFavorite(bool value) {
    Get.find<HomeController>().state.showFavorite = value;
  }

  @override
  void onInit() {
    state.imageModel = Get.arguments;
    super.onInit();
  }

  @override
  void onReady() {
    changeShowFavorite(false);
    super.onReady();
  }

  @override
  void onClose() {
    changeShowFavorite(true);
    super.onClose();
  }
}
