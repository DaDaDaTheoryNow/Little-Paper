String parseSearcherTags(String tags) {
  return tags.replaceAll(RegExp(r'[^\w\s]+'), '');
}
