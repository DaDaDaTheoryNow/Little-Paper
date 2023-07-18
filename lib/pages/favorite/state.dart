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

  // future state for future builder
  final Rx<Future<List<ImageModel>>> _favoriteImagesFuture =
      Rx<Future<List<ImageModel>>>(Future.value([]));
  Future<List<ImageModel>> get favoriteImagesFuture =>
      _favoriteImagesFuture.value;
  set favoriteImagesFuture(Future<List<ImageModel>> value) =>
      _favoriteImagesFuture.value = value;

  // states for save current scroll position
  ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;
  set scrollController(value) => _scrollController = value;
}
