import 'package:get/get.dart';
import 'package:little_paper/pages/wallpaper/state.dart';

class WallpaperController extends GetxController {
  final state = WallpaperState();
  WallpaperController();

  @override
  void onInit() {
    state.imageModel = Get.arguments;
    super.onInit();
  }
}
