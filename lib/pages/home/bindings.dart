import 'package:get/get.dart';
import 'package:little_paper/pages/explore/controller.dart';
import 'package:little_paper/pages/home/controller.dart';
import 'package:little_paper/pages/searcher/controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ExploreController>(() => ExploreController());
    Get.lazyPut<SearcherController>(() => SearcherController());
  }
}
