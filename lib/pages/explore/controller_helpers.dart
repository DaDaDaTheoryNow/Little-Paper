import 'dart:async';

import 'package:get/get.dart';
import 'package:little_paper/common/models/tag.dart';
import 'package:little_paper/common/services/cache/clear_image_cache.dart';
import 'package:little_paper/common/services/getx_service/little_paper_service.dart';
import 'package:little_paper/common/services/parse/parse_combined_tags_to_string.dart';
import 'package:little_paper/common/services/parse/parse_xml_to_models.dart';
import '../../common/models/image.dart';
import 'controller.dart';

extension ExploreControllerHelpers on ExploreController {
  void resetExploreState() {
    state.currentPage = 0;
    state.imagesCountToView = 0;
    state.exploreImages.clear();
  }

  void toggleTagSelection(int index) {
    List<TagModel> updatedTags = List.from(state.tags);
    updatedTags[index] =
        TagModel(state.tags[index].name, !state.tags[index].isSelected);
    state.tags = updatedTags;
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
    String parsedCombinedTags = parseCombinedTags(state.tags);
    String xmlResponse =
        await apiService.fetchData(39, parsedCombinedTags, state.currentPage);
    final parsedXmlResponse = parseXml(xmlResponse);
    await LittlePaperService.to.updateFavoriteImages();
    return updateImagesWithFavorites(parsedXmlResponse as List<ImageModel>);
  }

  void updateImagesCount() {
    state.imagesCountToView += 39;

    if (state.exploreImages.length < state.imagesCountToView &&
        state.exploreImages.isNotEmpty) {
      state.imagesCountToView = state.exploreImages.length;
      Get.snackbar("Warning", "It's all in current tags");
    }
  }

  Future<void> deleteExploreImagesFromCache() async {
    final deletedCache =
        await deleteFirstThirdImagesFromCache(state.exploreImagesCache);
    if (deletedCache != null) {
      state.exploreImagesCache = deletedCache;
    }
  }

  void startCacheDeletionTimer() {
    timer = Timer.periodic(
        const Duration(seconds: 30), (timer) => deleteExploreImagesFromCache());
  }

  void setupInitialState() {
    state.exploreImagesFuture = fetchData(state.currentPage);
    state.scrollController.addListener(scrollPositionListener);
  }
}
