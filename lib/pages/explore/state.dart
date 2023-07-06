import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:little_paper/models/image.dart';

class ExploreState {
  // list state for tags
  final RxList<dynamic> _tags = [].obs;
  List<dynamic> get tags => _tags;
  set tags(value) => _tags.value = value;

  // list state for all images data
  final RxList<ImageModel> _exploreImages = <ImageModel>[].obs;
  List<ImageModel> get exploreImages => _exploreImages;
  set exploreImages(value) => _exploreImages.value = value;

  // int state for count of images to view
  final RxInt _imagesCount = 42.obs;
  int get imagesCount => _imagesCount.value;
  set imagesCount(value) => _imagesCount.value = value;

  // int state for current page (using in fetching images on next page api)
  final RxInt _currentPage = 1.obs;
  int get currentPage => _currentPage.value;
  set currentPage(value) => _currentPage.value = value;

  // bool state for fetching more images button
  final RxBool _fetchingMoreImages = false.obs;
  bool get fetchingMoreImages => _fetchingMoreImages.value;
  set fetchingMoreImages(value) => _fetchingMoreImages.value = value;

  // future state for future builder (fixes rebuild futurebuilder)
  final Rx<Future<List<ImageModel>>> _fetchDataFuture =
      Rx<Future<List<ImageModel>>>(Future.value([]));
  Future<List<ImageModel>> get fetchDataFuture => _fetchDataFuture.value;
  set fetchDataFuture(Future<List<ImageModel>> value) =>
      _fetchDataFuture.value = value;

  // states for save current scroll position
  final Rx<ScrollController> _scrollController = ScrollController().obs;
  ScrollController get scrollController => _scrollController.value;
  set scrollController(value) => _scrollController.value = value;

  final RxDouble _scrollPosition = 0.0.obs;
  double get scrollPosition => _scrollPosition.value;
  set scrollPosition(value) => _scrollPosition.value = value;
}
