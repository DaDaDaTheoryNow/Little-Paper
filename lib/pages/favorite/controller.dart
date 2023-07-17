import 'dart:async';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';

import 'package:little_paper/pages/explore/controller.dart';

import '../../common/models/image.dart';
import '../../common/services/api/api_service.dart';

import '../../common/services/getx_service/little_paper_service.dart';
import '../../common/services/shared_preferences/shared_favorite_image_service.dart';
import 'state.dart';

class FavoriteController extends GetxController {
  final state = FavoriteState();
  FavoriteController();

  final SharedFavoriteImageService sharedFavoriteImage =
      SharedFavoriteImageService(); // custom class for convenient saving favorite images

  final ApiService apiService = ApiService();

  final DefaultCacheManager manager = DefaultCacheManager();

  final ExploreController exploreController = Get.find<ExploreController>();

  void handleReloadData() async {
    await manager.emptyCache(); // clear images cache

    // update favorite page
    state.imagesCountToView = 0;
    state.fetchDataFuture = fetchData();
  }

  Future<List<ImageModel>> fetchData() async {
    apiService.cancelFetchingData(); // cancel other request if we had

    state.favoriteImages = LittlePaperService.to.state.favoriteImages;

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
