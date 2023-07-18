import 'dart:async';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';

import '../../common/models/image.dart';
import '../../common/services/api/api_service.dart';
import '../../common/services/cache/clear_image_cache.dart';
import '../../common/services/getx_service/little_paper_service.dart';
import '../../common/services/parse/parse_combined_tags_to_string.dart';
import '../../common/services/parse/parse_xml_to_models.dart';
import '../../common/services/shared_preferences/shared_favorite_image_service.dart';
import 'state.dart';

class ExploreController extends GetxController {
  final state = ExploreState();
  ExploreController();

  final SharedFavoriteImageService sharedFavoriteImage =
      SharedFavoriteImageService(); // custom class for convenient saving favorite images

  final ApiService apiService = ApiService();

  final DefaultCacheManager manager = DefaultCacheManager();

  Timer? _timer;

  Future<void> handleReloadData() async {
    await deleteImagesFromCache(); // clear images cache

    // update explore page
    state.currentPage = 0;
    state.fetchingMoreImages = false;
    state.imagesCountToView = 0;
    state.exploreImages.clear();
    state.exploreImagesFuture = fetchData(state.currentPage);
  }

  void handleTagButton(int index) {
    List<dynamic> updatedTags = List.from(state.tags);
    updatedTags[index] = [state.tags[index][0], !state.tags[index][1]];
    state.tags = updatedTags;

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

    String parsedCombinedTags = parseCombinedTags(state.tags);

    // fetch images in explore
    String xmlResponse =
        await apiService.fetchData(39, parsedCombinedTags, state.currentPage);

    // parse response
    final parsedXmlResponse = parseXml(xmlResponse);

    // check to favorite
    await LittlePaperService.to.updateFavoriteImages();

    final updatedImages = parsedXmlResponse.map((image) {
      final matchingElement = LittlePaperService.to.state.favoriteImages
          .firstWhere((x) => x.id == image.id,
              orElse: () => image.copyWith(isFavorite: false));

      return image.copyWith(isFavorite: matchingElement.isFavorite);
    }).toList();

    // add images to states
    state.exploreImages.addAll(List<ImageModel>.from(updatedImages));
    state.exploreImagesCache.addAll(List<ImageModel>.from(updatedImages));

    // set images count to view
    state.imagesCountToView += 39;

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

  Future<void> deleteImagesFromCache() async {
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

    state.exploreImagesFuture = fetchData(state.currentPage);
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
