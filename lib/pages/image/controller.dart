import 'package:get/get.dart';
import 'package:little_paper/common/services/getx_service/little_paper_service.dart';
import 'package:little_paper/common/services/parse/parse_tags_to_list.dart';

import '../../common/services/android_native/android_native_wallpaper.dart';
import '../../common/services/wallpaper/wallpaper_service.dart';
import '../../common/widgets/get_dialog_download_progress.dart';
import 'state.dart';

class ImageController extends GetxController {
  final state = ImageState();
  ImageController();

  final WallpaperService wallpaperService = WallpaperService();
  final AndroidNativeWallpaperService androidNativeWallpaperService =
      AndroidNativeWallpaperService();

  void handleFavoriteButton() =>
      LittlePaperService.to.favoriteButton(state.imageModel.id);

  void handleShareButton() async {
    bool permissionsIsGranted =
        await androidNativeWallpaperService.permissionsForWallpaper();

    if (permissionsIsGranted) {
      getWallpaperDialogDownloadProgress(
          cancelFunction: () => wallpaperService.cancelFetchingImage());
      wallpaperService.shareWallpaperFromUrl(state.imageModel.fileUrl);
    } else {
      Get.snackbar("Error", "You wasn't granted permissions");
    }
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
