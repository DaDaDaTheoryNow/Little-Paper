import 'package:get/get.dart';
import 'package:little_paper/pages/explore/controller.dart';
import 'package:little_paper/pages/wallpaper/controller.dart';

import '../../../pages/favorite/controller.dart';
import '../../../pages/home/controller.dart';
import '../../models/image.dart';
import '../shared_preferences/shared_favorite_image_service.dart';

class LittlePaperService extends GetxService {
  static LittlePaperService get to => Get.find<LittlePaperService>();

  void changeShowFavorite(bool value) {
    Get.find<HomeController>().state.showFavorite = value;
  }

  void setDonwloadWallpaperImageProgress(int value) {
    Get.find<WallpaperController>().state.downloadProgress = value;
  }

  void resetDonwloadWallpaperImageProgress() {
    Get.close(1);
    Get.find<WallpaperController>().state.downloadProgress = 0;
  }

  // favorite button service
  Future<void> favoriteButton(int id) async {
    final SharedFavoriteImageService sharedFavoriteImage =
        SharedFavoriteImageService(); // custom class for convenient saving favorite images

    final exploreState = Get.find<ExploreController>().state;
    List<ImageModel> updatedImages;

    final indexInExploreImages =
        exploreState.exploreImages.indexWhere((element) => element.id == id);
    final indexInFavoriteImages =
        exploreState.favoriteImages.indexWhere((element) => element.id == id);

    if (indexInExploreImages != -1) {
      updatedImages = List.from(exploreState.exploreImages);

      ImageModel updatedImage = updatedImages[indexInExploreImages].copyWith(
        isFavorite: !updatedImages[indexInExploreImages].isFavorite,
      );

      updatedImages[indexInExploreImages] = updatedImage;

      exploreState.exploreImages = updatedImages;

      if (updatedImage.isFavorite) {
        await sharedFavoriteImage.saveFavoriteImage(updatedImage);
        exploreState.favoriteImages.add(updatedImage);
      } else {
        await sharedFavoriteImage.removeFavoriteImage(updatedImage);
        exploreState.favoriteImages
            .removeWhere((element) => element.id == updatedImage.id);
      }
    } else if (indexInFavoriteImages != -1) {
      await sharedFavoriteImage.removeFavoriteImage(
          exploreState.favoriteImages[indexInFavoriteImages]);
      exploreState.favoriteImages.removeWhere((element) => element.id == id);
    } else {
      final List oldFavoriteImages =
          Get.find<FavoriteController>().state.favoriteImages;
      final oldIndex =
          oldFavoriteImages.indexWhere((element) => element.id == id);

      if (oldIndex != -1) {
        await sharedFavoriteImage
            .saveFavoriteImage(oldFavoriteImages[oldIndex]);
        exploreState.favoriteImages
            .add(oldFavoriteImages[oldIndex].copyWith(isFavorite: true));
      }
    }
  }
}
