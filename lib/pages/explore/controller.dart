import 'dart:async';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:little_paper/models/image.dart';
import 'package:little_paper/pages/favorite/controller.dart';
import 'package:little_paper/services/api_service.dart';
import 'package:little_paper/services/shared_preferences/shared_favorite_image.dart';

import '../../services/cache/clear_image_cache.dart';
import '../../services/parse/parse_combined_tags_to_string.dart';
import '../../services/parse/parse_xml_to_models.dart';
import 'state.dart';

class ExploreController extends GetxController {
  final state = ExploreState();
  ExploreController();

  final SharedFavoriteImage sharedFavoriteImage =
      SharedFavoriteImage(); // custom class for convenient saving favorite images

  final ApiService apiService = ApiService();

  final DefaultCacheManager manager = DefaultCacheManager();

  Timer? _timer;

  Future<void> handleReloadData() async {
    await manager.emptyCache(); // clear images cache

    // update explore page
    state.currentPage = 0;
    state.fetchingMoreImages = false;
    state.imagesCountToView = 0;
    state.exploreImages.clear();
    state.exploreImagesCache.clear();
    state.fetchDataFuture = fetchData(state.currentPage);
  }

  void handleTagButton(int index) {
    List<dynamic> updatedTags = List.from(state.tags);
    updatedTags[index] = [state.tags[index][0], !state.tags[index][1]];
    state.tags = updatedTags;

    handleReloadData();
  }

  Future<void> handleFavoriteButton(int id) async {
    List<ImageModel> updatedImages;

    final indexInExploreImages =
        state.exploreImages.indexWhere((element) => element.id == id);
    final indexInFavoriteImages =
        state.favoriteImages.indexWhere((element) => element.id == id);

    if (indexInExploreImages != -1) {
      updatedImages = List.from(state.exploreImages);

      ImageModel updatedImage = updatedImages[indexInExploreImages].copyWith(
        isFavorite: !updatedImages[indexInExploreImages].isFavorite,
      );

      updatedImages[indexInExploreImages] = updatedImage;

      state.exploreImages = updatedImages;

      if (updatedImage.isFavorite) {
        await sharedFavoriteImage.saveFavoriteImage(updatedImage);
        state.favoriteImages.add(updatedImage);
      } else {
        await sharedFavoriteImage.removeFavoriteImage(updatedImage);
        state.favoriteImages
            .removeWhere((element) => element.id == updatedImage.id);
      }
    } else if (indexInFavoriteImages != -1) {
      await sharedFavoriteImage
          .removeFavoriteImage(state.favoriteImages[indexInFavoriteImages]);
      state.favoriteImages.removeWhere((element) => element.id == id);
    } else {
      final List oldFavoriteImages =
          Get.find<FavoriteController>().state.favoriteImages;
      final oldIndex =
          oldFavoriteImages.indexWhere((element) => element.id == id);

      if (oldIndex != -1) {
        await sharedFavoriteImage
            .saveFavoriteImage(oldFavoriteImages[oldIndex]);
        state.favoriteImages
            .add(oldFavoriteImages[oldIndex].copyWith(isFavorite: true));
      }
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
    apiService.cancelFetchingData(); // cancel other request if had

    String parsedCombinedTags = parseCombinedTags(state.tags);

    // fetch images in explore
    String xmlResponse =
        await apiService.fetchData(42, parsedCombinedTags, state.currentPage);

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
    state.exploreImages.addAll(List<ImageModel>.from(updatedImages));
    state.exploreImagesCache.addAll(List<ImageModel>.from(updatedImages));

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
    await manager.emptyCache();

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
    state.favoriteImages = await sharedFavoriteImage.getFavoriteImagesList();

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
