import 'dart:async';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:little_paper/models/image.dart';
import 'package:little_paper/pages/explore/controller.dart';
import 'package:little_paper/services/api_service.dart';
import 'package:little_paper/services/shared_preferences/shared_favorite_image.dart';

import 'state.dart';

class FavoriteController extends GetxController {
  final state = FavoriteState();
  FavoriteController();

  final SharedFavoriteImage sharedFavoriteImage =
      SharedFavoriteImage(); // custom class for convenient saving favorite images

  final ApiService apiService = ApiService();

  final DefaultCacheManager manager = DefaultCacheManager();

  final ExploreController exploreController = Get.find<ExploreController>();

  void handleReloadData() async {
    await manager.emptyCache(); // clear images cache

    // update favorite page
    state.imagesCountToView = 0;
    state.fetchDataFuture = fetchData();
  }

  Future<void> handleFavoriteButton(int id) async {
    List<ImageModel> updatedImages = List.from(state.favoriteImages);

    final index = updatedImages.indexWhere((element) => element.id == id);

    if (index != -1 && id != 0) {
      ImageModel updatedImage = updatedImages[index].copyWith(
        isFavorite: !updatedImages[index].isFavorite,
      );

      updatedImages[index] = updatedImage;

      state.favoriteImages = updatedImages; // update favorite button
    }
  }

  Future<List<ImageModel>> fetchData() async {
    apiService.cancelFetchingData(); // cancel other request if we had

    state.favoriteImages = exploreController.state.favoriteImages;

    // set images count to view
    state.imagesCountToView = state.favoriteImages.length;

    return state.favoriteImages;
  }

  void scrollPositionListener() {
    state.scrollPosition = state.scrollController.position.pixels;
  }

  @override
  void onInit() async {
    state.fetchDataFuture = fetchData();
    state.scrollController.addListener(scrollPositionListener);

    super.onInit();
  }
}
