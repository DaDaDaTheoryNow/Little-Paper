import 'package:xml/xml.dart' as xml;

class ImageModel {
  final int id;
  final String previewUrl;
  final String sampleUrl;
  final String fileUrl;
  final String tags;
  final String rating;
  final int score;
  final bool hasChildren;
  final String status;
  final String createdAt;
  final bool favorite;

  ImageModel(
      {required this.id,
      required this.previewUrl,
      required this.sampleUrl,
      required this.fileUrl,
      required this.tags,
      required this.rating,
      required this.score,
      required this.hasChildren,
      required this.status,
      required this.createdAt,
      required this.favorite});

  factory ImageModel.fromXml(xml.XmlElement element) {
    try {
      return ImageModel(
        id: int.parse(element.getAttribute('id') ?? '0'),
        previewUrl: element.getAttribute('preview_url') ?? '',
        sampleUrl: element.getAttribute('sample_url') ?? '',
        fileUrl: element.getAttribute('file_url') ?? '',
        tags: element.getAttribute('tags') ?? '',
        rating: element.getAttribute('rating') ?? '',
        score: int.parse(element.getAttribute('score') ?? "0"),
        hasChildren: element.getAttribute('has_children') == 'true',
        status: element.getAttribute('status') ?? '',
        createdAt: element.getAttribute('created_at') ?? '',
        favorite: false,
      );
    } catch (e) {
      return ImageModel(
        id: int.parse(element.getAttribute('id') ?? '0'),
        previewUrl: element.getAttribute('preview_url') ?? '',
        sampleUrl: element.getAttribute('sample_url') ?? '',
        fileUrl: element.getAttribute('file_url') ?? '',
        tags: element.getAttribute('tags') ?? '',
        rating: element.getAttribute('rating') ?? '',
        score: 0, // problem element in xml response
        hasChildren: element.getAttribute('has_children') == 'true',
        status: element.getAttribute('status') ?? '',
        createdAt: element.getAttribute('created_at') ?? '',
        favorite: false,
      );
    }
  }

  ImageModel copyWith({
    int? id,
    bool? favorite,
  }) {
    return ImageModel(
      id: id ?? this.id,
      previewUrl: previewUrl,
      sampleUrl: sampleUrl,
      fileUrl: fileUrl,
      tags: tags,
      rating: rating,
      score: 0, // problem element in xml response
      hasChildren: hasChildren,
      status: status,
      createdAt: createdAt,
      favorite: favorite ?? this.favorite,
    );
  }
}
