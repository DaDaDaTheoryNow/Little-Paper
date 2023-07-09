import 'package:get/get.dart';

class HomeState {
  final RxInt _currentIndex = 0.obs;
  int get currentIndex => _currentIndex.value;
  set currentIndex(value) => _currentIndex.value = value;

  final RxBool _internetConnection = false.obs;
  bool get internetConnection => _internetConnection.value;
  set internetConnection(bool value) => _internetConnection.value = value;

  final RxBool _showFavorite = true.obs;
  bool get showFavorite => _showFavorite.value;
  set showFavorite(bool value) => _showFavorite.value = value;
}
