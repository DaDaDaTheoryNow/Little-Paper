import 'package:flutter/material.dart';

import '../../../../common/models/image.dart';

class FavoriteImages extends StatelessWidget {
  final AsyncSnapshot<List<ImageModel>> favoriteSnapshot;
  const FavoriteImages({required this.favoriteSnapshot, super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
