import 'package:xml/xml.dart' as xml;

import '../../models/image.dart';

List parseXml(String xmlString) {
  final document = xml.XmlDocument.parse(xmlString);
  final postsElement = document.getElement('posts');

  if (postsElement != null) {
    final postElements = postsElement.findElements('post');
    final imageModels = postElements.map((postElement) {
      return ImageModel.fromXml(postElement);
    }).toList();

    return imageModels;
  }

  // if error or null answer
  return [];
}
