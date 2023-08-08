import 'package:little_paper/common/services/getx_service/little_paper_service.dart';
import 'package:little_paper/pages/favorite/controller.dart';

extension FavoriteControllerHelpers on FavoriteController {
  void resetImagesCount() {
    state.imagesCountToView = 0;
  }

  Future<void> updateFavoriteImages() async {
    await LittlePaperService.to.updateFavoriteImages();
  }

  void updateImagesCount() {
    state.imagesCountToView = state.favoriteImages.length;
  }

  void setupInitialState() {
    state.favoriteImagesFuture = fetchData();
  }
}
