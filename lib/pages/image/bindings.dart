import 'package:get/get.dart';

import 'controller.dart';

class ImageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImageController>(() => ImageController());
  }
}
