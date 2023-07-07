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
  late final bool isFavorite;

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
      required this.isFavorite});

  factory ImageModel.fromXml(xml.XmlElement element, bool isFavorite) {
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
        isFavorite: isFavorite,
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
        isFavorite: isFavorite,
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'previewUrl': previewUrl,
      'sampleUrl': sampleUrl,
      'fileUrl': fileUrl,
      'tags': tags,
      'rating': rating,
      'score': score,
      'hasChildren': hasChildren,
      'status': status,
      'createdAt': createdAt,
      'isFavorite': isFavorite,
    };
  }

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'],
      previewUrl: json['previewUrl'],
      sampleUrl: json['sampleUrl'],
      fileUrl: json['fileUrl'],
      tags: json['tags'],
      rating: json['rating'],
      score: json['score'],
      hasChildren: json['hasChildren'],
      status: json['status'],
      createdAt: json['createdAt'],
      isFavorite: json['isFavorite'],
    );
  }

  ImageModel copyWith({
    int? id,
    bool? isFavorite,
  }) {
    return ImageModel(
      id: id ?? this.id,
      previewUrl: previewUrl,
      sampleUrl: sampleUrl,
      fileUrl: fileUrl,
      tags: tags,
      rating: rating,
      score: 0,
      hasChildren: hasChildren,
      status: status,
      createdAt: createdAt,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
