import 'package:get/get.dart';
import 'package:little_paper/common/services/getx_service/little_paper_service.dart';
import 'package:little_paper/common/services/parse/parse_tags_to_list.dart';
import 'package:little_paper/pages/explore/controller.dart';
import 'package:little_paper/pages/favorite/controller.dart';
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
    LittlePaperService.to.changeShowFavorite(value);
  }

  void handleShowTags() {
    state.showTags = true;
  }

  void handleDownloadButton() {
    Get.toNamed("/wallpaper", arguments: state.imageModel);
  }

  @override
  void onInit() {
    state.imageModel = Get.arguments;
    state.tags = parseTagsToList(state.imageModel.tags);

    super.onInit();
  }

  @override
  void onReady() {
    LittlePaperService.to.changeShowFavorite(false);
    super.onReady();
  }

  @override
  void onClose() {
    LittlePaperService.to.changeShowFavorite(true);
    super.onClose();
  }
}