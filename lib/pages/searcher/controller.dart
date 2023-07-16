import 'dart:async';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:little_paper/common/services/parse/parse_searcher_tags.dart';
import '../../common/models/image.dart';
import '../../common/services/api/api_service.dart';
import '../../common/services/cache/clear_image_cache.dart';
import '../../common/services/parse/parse_xml_to_models.dart';
import '../../common/services/shared_preferences/shared_favorite_image_service.dart';
import 'state.dart';

class SearcherController extends GetxController {
  final state = SearcherState();

  final SharedFavoriteImageService sharedFavoriteImage =
      SharedFavoriteImageService(); // custom class for convenient saving favorite images

  final ApiService apiService = ApiService();

  final DefaultCacheManager manager = DefaultCacheManager();

  Timer? _timer;

  Future<void> handleReloadData() async {
    await manager.emptyCache(); // clear images cache

    // update search page
    state.currentPage = 0;
    state.fetchingMoreImages = false;
    state.imagesCountToView = 0;
    state.searcherImages.clear();
    state.searcherImagesCache.clear();
    state.fetchDataFuture = fetchData(state.currentPage);
  }

  void handleSearchImages(String tags) {
    state.searcherTags = tags;

    handleReloadData();
  }

  Future<void> handleFetchingMoreImages() async {
    // start loading
    state.fetchingMoreImages = true;

    state.currentPage++;
    await fetchData(state.currentPage);

    // finish loading
    state.fetchingMoreImages = false;
  }

  Future<List<ImageModel>> fetchData(int page) async {
    apiService.cancelFetchingData(); // cancel other request if had

    final parsedSearcherTags = parseSearcherTags(state.searcherTags);

    // fetch images in search
    String xmlResponse =
        await apiService.fetchData(39, parsedSearcherTags, state.currentPage);

    // parse response
    final parsedXmlResponse = parseXml(xmlResponse);

    // check to favorite
    final sharedFavoriteImageList =
        await sharedFavoriteImage.getFavoriteImagesList();

    final updatedImages = parsedXmlResponse.map((image) {
      final matchingElement = sharedFavoriteImageList.firstWhere(
          (x) => x.id == image.id,
          orElse: () => image.copyWith(isFavorite: false));

      return image.copyWith(isFavorite: matchingElement.isFavorite);
    }).toList();

    // add images to states
    state.searcherImages.addAll(List<ImageModel>.from(updatedImages));
    state.searcherImagesCache.addAll(List<ImageModel>.from(updatedImages));

    // set images count to view
    state.imagesCountToView += 39;

    if (state.searcherImages.length < state.imagesCountToView &&
        state.searcherImages.isNotEmpty) {
      state.imagesCountToView = state.searcherImages.length;
      Get.snackbar("Warning", "It's all in current tags");
    }

    return state.searcherImages;
  }

  void scrollPositionListener() {
    state.scrollPosition = state.scrollController.position.pixels;
  }

  void deleteImagesFromCache() async {
    final deletedCache =
        await deleteFirstThirdImagesFromCache(state.searcherImagesCache);

    if (deletedCache != null) {
      state.searcherImagesCache = deletedCache;
    }
  }

  @override
  void onInit() async {
    state.favoriteImages = await sharedFavoriteImage.getFavoriteImagesList();

    state.scrollController.addListener(scrollPositionListener);

    _timer = Timer.periodic(
        const Duration(seconds: 30), (timer) => deleteImagesFromCache());

    super.onInit();
  }

  @override
  void onClose() {
    _timer!.cancel();
    super.onClose();
  }
}
