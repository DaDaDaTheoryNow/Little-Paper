import 'package:get/get.dart';

import '../../models/image.dart';

class LittlePaperState {
  // list state for favorite images
  final RxList<ImageModel> _favoriteImages = <ImageModel>[].obs;
  List<ImageModel> get favoriteImages => _favoriteImages;
  set favoriteImages(value) => _favoriteImages.value = value;

  // int state for download progress (using in download wallpaper)
  final RxInt _downloadProgress = 0.obs;
  int get downloadProgress => _downloadProgress.value;
  set downloadProgress(value) => _downloadProgress.value = value;
}
