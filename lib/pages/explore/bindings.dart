import 'package:get/get.dart';

import 'controller.dart';

class ExploreBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExploreController>(() => ExploreController());
  }
}
