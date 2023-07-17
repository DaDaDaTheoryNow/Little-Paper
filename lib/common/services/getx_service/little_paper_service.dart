import 'package:get/get.dart';
import 'package:little_paper/common/services/getx_service/state.dart';
import 'package:little_paper/pages/explore/controller.dart';
import 'package:little_paper/pages/explore/state.dart';
import 'package:little_paper/pages/favorite/state.dart';
import 'package:little_paper/pages/searcher/controller.dart';
import 'package:little_paper/pages/searcher/state.dart';
import 'package:little_paper/pages/wallpaper/controller.dart';

import '../../../pages/favorite/controller.dart';
import '../../../pages/home/controller.dart';
import '../../models/image.dart';
import '../shared_preferences/shared_favorite_image_service.dart';

class LittlePaperService extends GetxService {
  static LittlePaperService get to => Get.find<LittlePaperService>();

  final state = LittlePaperState();

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

  void unfocusSearcherAppBar() {
    if (Get.isRegistered<SearcherController>()) {
      Get.find<SearcherController>().state.focusNode.unfocus();
    }
  }

  bool checkInternetConnection() {
    return Get.find<HomeController>().state.internetConnection;
  }

  // favorite button service
  final SharedFavoriteImageService sharedFavoriteImage =
      SharedFavoriteImageService(); // custom class for convenient saving favorite images

  Future<void> favoriteButton(int id) async {
    bool actionWithFavorite = false;
    List<ImageModel> updatedImages;

    final ExploreState? exploreState = Get.isRegistered<ExploreController>()
        ? Get.find<ExploreController>().state
        : null;
    final SearcherState? searcherState = Get.isRegistered<SearcherController>()
        ? Get.find<SearcherController>().state
        : null;
    final FavoriteState? favoriteState = Get.isRegistered<FavoriteController>()
        ? Get.find<FavoriteController>().state
        : null;

    int findIndex(List<ImageModel>? images) {
      if (images != null) {
        return images.indexWhere((element) => element.id == id);
      }

      return -1;
    }

    int indexInExploreImages = findIndex(exploreState?.exploreImages);
    int indexInSearcherImages = findIndex(searcherState?.searcherImages);
    int indexInFavoriteImages = findIndex(favoriteState?.favoriteImages);

    if (indexInFavoriteImages != -1) {
      updatedImages = List.from(favoriteState!.favoriteImages);

      ImageModel updatedImage = updatedImages[indexInFavoriteImages].copyWith(
        isFavorite: !updatedImages[indexInFavoriteImages].isFavorite,
      );

      updatedImages[indexInFavoriteImages] = updatedImage;

      favoriteState.favoriteImages = updatedImages;

      if (!actionWithFavorite) {
        if (updatedImage.isFavorite) {
          state.favoriteImages.add(updatedImage);
          await sharedFavoriteImage.saveFavoriteImage(updatedImage);
        } else {
          state.favoriteImages
              .removeWhere((element) => element.id == updatedImage.id);
          await sharedFavoriteImage.removeFavoriteImage(updatedImage);
        }

        actionWithFavorite = true;
      }
    }

    if (indexInExploreImages != -1) {
      updatedImages = List.from(exploreState!.exploreImages);

      ImageModel updatedImage = updatedImages[indexInExploreImages].copyWith(
        isFavorite: !updatedImages[indexInExploreImages].isFavorite,
      );

      updatedImages[indexInExploreImages] = updatedImage;

      exploreState.exploreImages = updatedImages;

      if (!actionWithFavorite) {
        if (updatedImage.isFavorite) {
          await sharedFavoriteImage.saveFavoriteImage(updatedImage);
          state.favoriteImages.add(updatedImage);
        } else {
          await sharedFavoriteImage.removeFavoriteImage(updatedImage);
          state.favoriteImages
              .removeWhere((element) => element.id == updatedImage.id);
        }

        actionWithFavorite = true;
      }
    }

    if (indexInSearcherImages != -1) {
      updatedImages = List.from(searcherState!.searcherImages);

      ImageModel updatedImage = updatedImages[indexInSearcherImages].copyWith(
        isFavorite: !updatedImages[indexInSearcherImages].isFavorite,
      );

      updatedImages[indexInSearcherImages] = updatedImage;

      searcherState.searcherImages = updatedImages;

      if (!actionWithFavorite) {
        if (updatedImage.isFavorite) {
          await sharedFavoriteImage.saveFavoriteImage(updatedImage);
          state.favoriteImages.add(updatedImage);
        } else {
          await sharedFavoriteImage.removeFavoriteImage(updatedImage);
          state.favoriteImages
              .removeWhere((element) => element.id == updatedImage.id);
        }

        actionWithFavorite = true;
      }
    }
  }
}
