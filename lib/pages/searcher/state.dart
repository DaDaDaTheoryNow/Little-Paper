import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:little_paper/common/models/image.dart';

class SearcherState {
  // list state for tags
  final RxString _searcherTags = "".obs;
  String get searcherTags => _searcherTags.value;
  set searcherTags(value) => _searcherTags.value = value;

  // List of images for display
  final RxList<ImageModel> _searcherImages = <ImageModel>[].obs;
  List<ImageModel> get searcherImages => _searcherImages;
  set searcherImages(value) => _searcherImages.value = value;

  // Cache for conveniently storing images
  List<ImageModel> _searcherImagesCache = [];
  List<ImageModel> get searcherImagesCache => _searcherImagesCache;
  set searcherImagesCache(value) => _searcherImagesCache = value;

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
  final Rx<Future<List<ImageModel>>> _fetchDataFuture =
      Rx<Future<List<ImageModel>>>(Future.value([]));
  Future<List<ImageModel>> get fetchDataFuture => _fetchDataFuture.value;
  set fetchDataFuture(Future<List<ImageModel>> value) =>
      _fetchDataFuture.value = value;

  // Scrolling controller
  ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;
  set scrollController(value) => _scrollController = value;

  // Scrolling position
  final RxDouble _scrollPosition = 0.0.obs;
  double get scrollPosition => _scrollPosition.value;
  set scrollPosition(value) => _scrollPosition.value = value;

  // Focus node for searcher app bar
  FocusNode _focusNode = FocusNode();
  FocusNode get focusNode => _focusNode;
  set focusNode(value) => _focusNode = value;

  // Text edit controller for Text Field
  final Rx<TextEditingController> _textEditingController =
      TextEditingController().obs;
  TextEditingController get textEditingController =>
      _textEditingController.value;
  set textEditingController(value) => _textEditingController.value = value;
}
