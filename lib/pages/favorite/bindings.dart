import 'package:get/get.dart';

import 'controller.dart';

class FavoriteBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavoriteController>(() => FavoriteController());
  }
}
