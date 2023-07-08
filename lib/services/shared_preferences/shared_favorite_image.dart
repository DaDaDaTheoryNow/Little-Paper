import 'dart:convert';

import 'package:little_paper/models/image.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedFavoriteImage {
  Future<void> saveFavoriteImage(ImageModel imageModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final saveImageModel = imageModel.copyWith(isFavorite: true);

    List<String> imageListJson = prefs.getStringList('favoriteImages') ?? [];
    imageListJson.add(jsonEncode(saveImageModel.toJson()));
    await prefs.setStringList('favoriteImages', imageListJson);
  }

  Future<void> removeFavoriteImage(ImageModel imageModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final deleteImageModel =
        imageModel.copyWith(id: imageModel.id, isFavorite: true);
    final String favoriteImageJson = jsonEncode(deleteImageModel.toJson());
    final favoriteImages = prefs.getStringList("favoriteImages") ?? [];
    favoriteImages.remove(favoriteImageJson);
    prefs.setStringList("favoriteImages", favoriteImages);
  }

  Future<List<ImageModel>> getFavoriteImagesList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? imageListJson = prefs.getStringList('favoriteImages');
    if (imageListJson != null) {
      List<ImageModel> imageList = imageListJson
          .map((imageJson) => ImageModel.fromJson(jsonDecode(imageJson)))
          .toList();
      return imageList;
    } else {
      return [];
    }
  }
}
