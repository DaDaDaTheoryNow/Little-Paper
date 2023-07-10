import 'package:get/get.dart';
import 'package:little_paper/pages/wallpaper/controller.dart';

class WallpaperBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WallpaperController>(() => WallpaperController());
  }
}
