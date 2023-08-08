String parseCombinedTags(List tagsList) {
  String combinedTags = tagsList
      .where((item) => item.isSelected == true)
      .map((item) => item.name)
      .join("+");

  return combinedTags;
}
