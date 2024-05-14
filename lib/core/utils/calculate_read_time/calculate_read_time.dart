int calcReadingTime(String content) {
  final wordCount = content.split(RegExp(r'\s+')).length;
  // speed = distance / time
  // 250 Avg Human reading speed
  final readingTime = wordCount / 250;
  return readingTime.ceil();
}
