class TextFormatter {
  static final TextFormatter _singleton = TextFormatter._internal();
  factory TextFormatter() => _singleton;
  TextFormatter._internal();

  String extractProductLink(String link) {
    final regexp = RegExp('<(.*?)>');
    final match = regexp.allMatches(link).elementAt(0);
    String matchedText = match.group(0) ?? '0';
    if (matchedText != '0') {
      matchedText = matchedText.replaceAll('<', '');
      matchedText = matchedText.replaceAll('>', '');
      return matchedText;
    }
    return '';
  }

  int extractProductId(String text) {
    String codeString = text.split('/').elementAt(text.split('/').length - 1);
    try {
      return int.parse(codeString);
    } catch (ex) {
      return 0;
    }
  }
}
