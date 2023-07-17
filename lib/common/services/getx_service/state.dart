import 'package:get/get.dart';

import '../../models/image.dart';

class LittlePaperState {
  // list state for favorite images
  final RxList<ImageModel> _favoriteImages = <ImageModel>[].obs;
  List<ImageModel> get favoriteImages => _favoriteImages;
  set favoriteImages(value) => _favoriteImages.value = value;
}
