import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';

import 'package:little_paper/pages/explore/controller.dart';

import '../../common/models/image.dart';
import '../../common/services/api/api_service.dart';

import '../../common/services/getx_service/little_paper_service.dart';
import '../../common/services/shared_preferences/shared_favorite_image_service.dart';
import 'state.dart';

import 'controller_helpers.dart';

class FavoriteController extends GetxController {
  final state = FavoriteState();
  FavoriteController();

  final SharedFavoriteImageService sharedFavoriteImage =
      SharedFavoriteImageService();
  final ApiService apiService = ApiService();
  final DefaultCacheManager manager = DefaultCacheManager();
  final ExploreController exploreController = Get.find<ExploreController>();

  void handleReloadData() async {
    resetImagesCount();
    state.favoriteImagesFuture = fetchData();
  }

  Future<List<ImageModel>> fetchData() async {
    await updateFavoriteImages();
    state.favoriteImages = LittlePaperService.to.state.favoriteImages;
    updateImagesCount();
    return state.favoriteImages;
  }

  @override
  void onInit() async {
    setupInitialState();
    super.onInit();
  }
}
