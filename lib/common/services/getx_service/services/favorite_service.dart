import 'package:get/get.dart';
import 'package:little_paper/common/services/getx_service/little_paper_service.dart';

import '../../../../pages/explore/controller.dart';
import '../../../../pages/explore/state.dart';
import '../../../../pages/favorite/controller.dart';
import '../../../../pages/favorite/state.dart';
import '../../../../pages/searcher/controller.dart';
import '../../../../pages/searcher/state.dart';
import '../../../models/image.dart';
import '../../shared_preferences/shared_favorite_image_service.dart';

class FavoriteService {
  final state = LittlePaperService.to.state;

  final SharedFavoriteImageService sharedFavoriteImage =
      SharedFavoriteImageService(); // custom class for convenient saving favorite images

  Future<void> updateFavorite() async {
    state.favoriteImages = await sharedFavoriteImage.getFavoriteImagesList();
  }

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
