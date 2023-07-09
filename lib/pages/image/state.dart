import 'package:get/get.dart';
import 'package:little_paper/common/models/image.dart';

class ImageState {
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

  final RxBool _isFillImage = false.obs;
  bool get isFillImage => _isFillImage.value;
  set isFillImage(value) => _isFillImage.value = value;
}
