import 'dart:async';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';

import 'controller_helpers.dart'; // Import the helper methods

import '../../common/models/image.dart';
import '../../common/services/api/api_service.dart';
import '../../common/services/shared_preferences/shared_favorite_image_service.dart';
import 'state.dart';

class ExploreController extends GetxController {
  final state = ExploreState();
  ExploreController();

  final SharedFavoriteImageService sharedFavoriteImage =
      SharedFavoriteImageService();
  final ApiService apiService = ApiService();
  final DefaultCacheManager manager = DefaultCacheManager();
  late Timer timer;

  Future<void> handleReloadData() async {
    await deleteExploreImagesFromCache();
    resetExploreState();
    state.exploreImagesFuture = fetchData(state.currentPage);
  }

  void handleTagSelectButton(int index) {
    toggleTagSelection(index);
    handleReloadData();
  }

  Future<void> handleFetchingMoreImages() async {
    state.fetchingMoreImages = true;
    state.currentPage++;
    await fetchData(state.currentPage);
    state.fetchingMoreImages = false;
  }

  Future<List<ImageModel>> fetchData(int page) async {
    final List<ImageModel> images = await fetchImagesFromApi(page);

    state.exploreImages.addAll(images);
    state.exploreImagesCache.addAll(images);

    updateImagesCount();

    return state.exploreImages;
  }

  void scrollPositionListener() {
    state.scrollPosition = state.scrollController.position.pixels;
  }

  @override
  void onInit() async {
    await manager.emptyCache();
    setupInitialState();
    startCacheDeletionTimer();
    super.onInit();
  }

  @override
  void onClose() {
    timer.cancel();
    super.onClose();
  }
}
