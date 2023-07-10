import 'package:get/get.dart';

import '../../../pages/home/controller.dart';

class LittlePaperService extends GetxService {
  static LittlePaperService get to => Get.find<LittlePaperService>();

  void changeShowFavorite(bool value) {
    Get.find<HomeController>().state.showFavorite = value;
  }
}
