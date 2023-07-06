import 'package:cached_network_image/cached_network_image.dart';

deleteFirstThirdImagesFromCache(List cacheList) async {
  if (cacheList.isNotEmpty && cacheList.length > 50) {
    int length = (cacheList.length / 5).ceil();
    final deletedList = cacheList.sublist(0, length);

    for (var imageModel in deletedList) {
      await CachedNetworkImage.evictFromCache(imageModel.previewUrl);
      await CachedNetworkImage.evictFromCache(imageModel.sampleUrl);
      cacheList
        ..remove(imageModel)
        ..add(imageModel);
    }

    return cacheList;
  }
}
