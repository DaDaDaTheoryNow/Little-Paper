import 'package:get/get.dart';

class HomeState {
  final Rx<int> _currentIndex = 0.obs;
  int get currentIndex => _currentIndex.value;
  set currentIndex(value) => _currentIndex.value = value;
}
