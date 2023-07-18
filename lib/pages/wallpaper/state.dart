import 'package:get/get.dart';

import '../../common/models/image.dart';

class WallpaperState {
  final Rx<ImageModel> _imageModel = ImageModel(
          id: 0,
          previewUrl: "",
          sampleUrl: "",
          fileUrl: "",
          tags: "",
          rating: "",
          score: 0,
          hasChildren: false,
          status: "",
          createdAt: "",
          isFavorite: false)
      .obs;
  ImageModel get imageModel => _imageModel.value;
  set imageModel(ImageModel value) => _imageModel.value = value;
}
