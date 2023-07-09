import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:little_paper/common/models/image.dart';

class FavoriteState {
  // list state for favorite images
  final RxList<ImageModel> _favoriteImages = <ImageModel>[].obs;
  List<ImageModel> get favoriteImages => _favoriteImages;
  set favoriteImages(value) => _favoriteImages.value = value;

  // int state for count of images to view
  final RxInt _imagesCountToView = 0.obs;
  int get imagesCountToView => _imagesCountToView.value;
  set imagesCountToView(value) => _imagesCountToView.value = value;

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
