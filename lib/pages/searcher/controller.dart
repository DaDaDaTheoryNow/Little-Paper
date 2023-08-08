import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:little_paper/pages/searcher/controller_helpers.dart';

import '../../common/services/api/api_service.dart';
import '../../common/services/shared_preferences/shared_favorite_image_service.dart';

import '../../common/models/image.dart';

import 'state.dart';

class SearcherController extends GetxController {
  final state = SearcherState();
  final SharedFavoriteImageService sharedFavoriteImageService =
      SharedFavoriteImageService();
  final ApiService apiService = ApiService();
  final DefaultCacheManager cacheManager = DefaultCacheManager();

  Timer? timer;

  Future<void> handleReloadData() async {
    await deleteSearcherImagesFromCache();
    resetSearcherState();
  }

  void handleSearchImages(String tags) {
    state.searcherTags = tags;
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

    state.searcherImages.addAll(images);
    state.searcherImagesCache.addAll(images);

    updateImagesCount();

    return state.searcherImages;
  }

  void scrollPositionListener() {
    state.scrollPosition = state.scrollController.position.pixels;
  }

  void putTagFromImageToTextField(String tag) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 100), () {
        handleSearchImages(tag);
      });
    });
  }

  @override
  void onInit() {
    setupInitialState();
    startCacheDeletionTimer();

    super.onInit();
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}
