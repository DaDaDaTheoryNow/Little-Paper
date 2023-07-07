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

  // list value with images data for convenient use images cache
  List<ImageModel> _exploreImagesCache = [];
  List<ImageModel> get exploreImagesCache => _exploreImagesCache;
  set exploreImagesCache(value) => _exploreImagesCache = value;

  // list state for favorite images
  final RxList<ImageModel> _favoriteImages = <ImageModel>[].obs;
  List<ImageModel> get favoriteImages => _favoriteImages;
  set favoriteImages(value) => _favoriteImages.value = value;

  // int state for count of images to view
  final RxInt _imagesCountToView = 0.obs;
  int get imagesCountToView => _imagesCountToView.value;
  set imagesCountToView(value) => _imagesCountToView.value = value;

  // int value for current page (using in fetching images from api)
  int _currentPage = 0;
  int get currentPage => _currentPage;
  set currentPage(value) => _currentPage = value;

  // bool state for fetching more images
  final RxBool _fetchingMoreImages = false.obs;
  bool get fetchingMoreImages => _fetchingMoreImages.value;
  set fetchingMoreImages(value) => _fetchingMoreImages.value = value;

  // future state for future builder (fixes futurebuilder rebuild)
  final Rx<Future<List<ImageModel>>> _fetchDataFuture =
      Rx<Future<List<ImageModel>>>(Future.value([]));
  Future<List<ImageModel>> get fetchDataFuture => _fetchDataFuture.value;
  set fetchDataFuture(Future<List<ImageModel>> value) =>
      _fetchDataFuture.value = value;

  // states for save current scroll position
  ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;
  set scrollController(value) => _scrollController = value;

  final RxDouble _scrollPosition = 0.0.obs;
  double get scrollPosition => _scrollPosition.value;
  set scrollPosition(value) => _scrollPosition.value = value;
}
