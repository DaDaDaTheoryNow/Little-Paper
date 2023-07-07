import 'dart:async';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:little_paper/models/image.dart';
import 'package:little_paper/services/api_service.dart';
import 'package:little_paper/services/shared_preferences/shared_favorite_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/cache/clear_image_cache.dart';
import '../../services/parse/parse_combined_tags_to_string.dart';
import '../../services/parse/parse_xml_to_models.dart';
import 'state.dart';

class ExploreController extends GetxController {
  final state = ExploreState();
  ExploreController();

  final SharedFavoriteImage sharedFavoriteImage =
      SharedFavoriteImage(); // custom class for convenient saving favorite images
  final DefaultCacheManager _manager = DefaultCacheManager();
  Timer? _timer;

  void handleTagButton(int index) async {
    List<dynamic> updatedTags = List.from(state.tags);
    updatedTags[index] = [state.tags[index][0], !state.tags[index][1]];
    state.tags = updatedTags;

    await _manager.emptyCache(); // clear images cache

    // update explore page
    state.currentPage = 0;
    state.fetchingMoreImages = false;
    state.imagesCountToView = 0;
    state.exploreImages.clear();
    state.exploreImagesCache.clear();
    state.fetchDataFuture = fetchData(state.currentPage);
  }

  Future<void> handleFavoriteButton(int id) async {
    List<ImageModel> updatedImages = List.from(state.exploreImages);

    final index = updatedImages.indexWhere((element) => element.id == id);

    if (index != -1 && id != 0) {
      ImageModel updatedImage = updatedImages[index].copyWith(
        isFavorite: !updatedImages[index].isFavorite,
      );

      updatedImages[index] = updatedImage;

      state.exploreImages = updatedImages; // update favorite button

      // adding in favorite state
      (state.exploreImages[index].isFavorite)
          ? {
              await sharedFavoriteImage
                  .saveFavoriteImageList(state.exploreImages[index]),
              state.favoriteImages.add(state.exploreImages[index])
            }
          : {
              await sharedFavoriteImage
                  .removeFavoriteImage(state.exploreImages[index]),
              state.favoriteImages.removeWhere(
                  (element) => element.id == state.exploreImages[index].id)
            };
    }
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
    String parsedCombinedTags = parseCombinedTags(state.tags);
    // fetch images in explore
    String xmlResponse =
        await ApiService().fetchData(42, parsedCombinedTags, state.currentPage);

    // parse response
    final parsedXmlResponse = await parseXml(xmlResponse);
    state.exploreImages.addAll(List<ImageModel>.from(parsedXmlResponse));
    state.exploreImagesCache.addAll(List<ImageModel>.from(parsedXmlResponse));

    // set images count to view
    state.imagesCountToView += 42;

    if (state.exploreImages.length < state.imagesCountToView &&
        state.exploreImages.isNotEmpty) {
      state.imagesCountToView = state.exploreImages.length;
      Get.snackbar("Warning", "It's all in current tags");
    }

    return state.exploreImages;
  }

  void scrollPositionListener() {
    state.scrollPosition = state.scrollController.position.pixels;
  }

  void deleteImagesFromCache() async {
    final deletedCache =
        await deleteFirstThirdImagesFromCache(state.exploreImagesCache);
    if (deletedCache != null) {
      state.exploreImagesCache = deletedCache;
    }
  }

  @override
  void onInit() async {
    await _manager.emptyCache();

    state.tags = [
      ["1girl", false],
      ["original", false],
      ["red_eyes", false],
      ["genshin_impact", false],
      ["skirt", false],
      ["smile", false]
    ];

    state.fetchDataFuture = fetchData(state.currentPage);
    state.scrollController.addListener(scrollPositionListener);
    state.favoriteImages = await sharedFavoriteImage.getFavoriteImageList();

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
