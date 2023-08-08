import 'dart:convert';
import 'package:little_paper/common/models/image.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedFavoriteImageService {
  Future<void> saveFavoriteImage(ImageModel imageModel) async {
    final saveImageModel = imageModel.copyWith(isFavorite: true);
    final String imageJson = jsonEncode(saveImageModel.toJson());

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> imageListJson =
        prefs.getStringList('favoriteImages') ?? [];
    imageListJson.add(imageJson);
    await prefs.setStringList('favoriteImages', imageListJson);
  }

  Future<void> removeFavoriteImage(ImageModel imageModel) async {
    final deleteImageModel =
        imageModel.copyWith(id: imageModel.id, isFavorite: true);
    final String favoriteImageJson = jsonEncode(deleteImageModel.toJson());

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> favoriteImages =
        prefs.getStringList("favoriteImages") ?? [];
    favoriteImages.remove(favoriteImageJson);
    prefs.setStringList("favoriteImages", favoriteImages);
  }

  Future<List<ImageModel>> getFavoriteImagesList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? imageListJson = prefs.getStringList('favoriteImages');

    return imageListJson?.map((imageJson) {
          final Map<String, dynamic> json = jsonDecode(imageJson);
          return ImageModel.fromJson(json);
        }).toList() ??
        [];
  }
}
