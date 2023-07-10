List<String> parseTagsToList(String tags) {
  List<String> parsedTagsToList = tags.split(" ");

  parsedTagsToList.removeWhere((tag) => tag.isEmpty);

  return parsedTagsToList;
}
