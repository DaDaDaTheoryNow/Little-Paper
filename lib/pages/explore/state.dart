import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:little_paper/common/models/image.dart';
import 'package:little_paper/common/models/tag.dart';

class ExploreState {
  // List of tags for image filtering
  final RxList<TagModel> _tags = <TagModel>[
    TagModel("1girl", false),
    TagModel("original", false),
    TagModel("red_eyes", false),
    TagModel("genshin_impact", false),
    TagModel("skirt", false),
    TagModel("smile", false),
  ].obs;
  List<TagModel> get tags => _tags;
  set tags(List<TagModel> value) => _tags.value = value;

  // List of images for display
  final RxList<ImageModel> _exploreImages = <ImageModel>[].obs;
  List<ImageModel> get exploreImages => _exploreImages;
  set exploreImages(value) => _exploreImages.value = value;

  // Cache for conveniently storing images
  List<ImageModel> _exploreImagesCache = [];
  List<ImageModel> get exploreImagesCache => _exploreImagesCache;
  set exploreImagesCache(value) => _exploreImagesCache = value;

  // Count of images to view
  final RxInt _imagesCountToView = 0.obs;
  int get imagesCountToView => _imagesCountToView.value;
  set imagesCountToView(value) => _imagesCountToView.value = value;

  // Current page (used for fetching images from API)
  int _currentPage = 0;
  int get currentPage => _currentPage;
  set currentPage(value) => _currentPage = value;

  // Flag for indicating loading of more images
  final RxBool _fetchingMoreImages = false.obs;
  bool get fetchingMoreImages => _fetchingMoreImages.value;
  set fetchingMoreImages(value) => _fetchingMoreImages.value = value;

  // Future for use with FutureBuilder
  final Rx<Future<List<ImageModel>>> _exploreImagesFuture =
      Rx<Future<List<ImageModel>>>(Future.value([]));
  Future<List<ImageModel>> get exploreImagesFuture =>
      _exploreImagesFuture.value;
  set exploreImagesFuture(Future<List<ImageModel>> value) =>
      _exploreImagesFuture.value = value;

  // Scrolling controller
  ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;
  set scrollController(value) => _scrollController = value;

  // Scrolling position
  final RxDouble _scrollPosition = 0.0.obs;
  double get scrollPosition => _scrollPosition.value;
  set scrollPosition(value) => _scrollPosition.value = value;
}
