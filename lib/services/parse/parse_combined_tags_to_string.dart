String parseCombinedTags(List tagsList) {
  String combinedTags = tagsList
      .where((item) => item[1] == true)
      .map((item) => item[0])
      .join("+");

  return combinedTags;
}
