import 'package:get/get.dart';

import 'controller.dart';

class SearcherBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearcherController>(() => SearcherController());
  }
}
