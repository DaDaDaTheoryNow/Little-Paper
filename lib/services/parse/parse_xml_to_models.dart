import 'package:xml/xml.dart' as xml;

import '../../models/image.dart';
import '../shared_preferences/shared_favorite_image.dart';

Future<List> parseXml(String xmlString) async {
  // custom class for convenient saving favorite images
  final SharedFavoriteImage sharedFavoriteImage = SharedFavoriteImage();

  final document = xml.XmlDocument.parse(xmlString);
  final postsElement = document.getElement('posts');

  if (postsElement != null) {
    final postElements = postsElement.findElements('post');
    final imageModels = await Future.wait(postElements.map((postElement) async {
      final isFavorite = await sharedFavoriteImage.getFavoriteImageBool(
          ImageModel.fromXml(postElement, false)); // get isFavorite
      return ImageModel.fromXml(postElement, isFavorite);
    }).toList());

    return imageModels;
  }

  // if error or null answer
  return [];
}
