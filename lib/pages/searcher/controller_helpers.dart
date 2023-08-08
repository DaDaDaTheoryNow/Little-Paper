import 'dart:async';

import 'package:get/get.dart';
import 'package:little_paper/common/models/image.dart';
import 'package:little_paper/common/services/cache/clear_image_cache.dart';
import 'package:little_paper/common/services/getx_service/little_paper_service.dart';
import 'package:little_paper/common/services/parse/parse_searcher_tags.dart';
import 'package:little_paper/common/services/parse/parse_xml_to_models.dart';

import 'controller.dart';

extension SearcherControllerHelpers on SearcherController {
  void resetSearcherState() {
    state.currentPage = 0;
    state.fetchingMoreImages = false;
    state.imagesCountToView = 0;
    state.searcherImages.clear();
    state.fetchDataFuture = fetchData(state.currentPage);
  }

  List<ImageModel> updateImagesWithFavorites(List<ImageModel> images) {
    return images.map((image) {
      final matchingElement = LittlePaperService.to.state.favoriteImages
          .firstWhere((x) => x.id == image.id,
              orElse: () => image.copyWith(isFavorite: false));
      return image.copyWith(isFavorite: matchingElement.isFavorite);
    }).toList();
  }

  Future<List<ImageModel>> fetchImagesFromApi(int page) async {
    apiService.cancelFetchingData();
    final parsedSearcherTags = parseSearcherTags(state.searcherTags);
    String xmlResponse =
        await apiService.fetchData(39, parsedSearcherTags, state.currentPage);
    final parsedXmlResponse = parseXml(xmlResponse);
    await LittlePaperService.to.updateFavoriteImages();
    return updateImagesWithFavorites(parsedXmlResponse as List<ImageModel>);
  }

  void updateImagesCount() {
    state.imagesCountToView += 39;

    if (state.searcherImages.length < state.imagesCountToView &&
        state.searcherImages.isNotEmpty) {
      state.imagesCountToView = state.searcherImages.length;
      Get.snackbar("Warning", "It's all in current tags");
    }
  }

  Future<void> deleteSearcherImagesFromCache() async {
    final deletedCache =
        await deleteFirstThirdImagesFromCache(state.searcherImagesCache);

    if (deletedCache != null) {
      state.searcherImagesCache = deletedCache;
    }
  }

  void startCacheDeletionTimer() {
    timer = Timer.periodic(const Duration(seconds: 30),
        (timer) => deleteSearcherImagesFromCache());
  }

  void setupInitialState() {
    state.scrollController.addListener(scrollPositionListener);
  }
}
