/// An extension on [RegExp] to provide additional functionality.
extension RegexExtension on RegExp {
  /// Returns the first matched substring from the input string, or null if no match is found.
  String? firstMatchString(String input) {
    var match = firstMatch(input);
    if (match == null) return null;
    return input.substring(match.start, match.end);
  }
}

/// An extension on [RegExpMatch] to provide easy access to the matched substring.
extension RegexMatchExtension on RegExpMatch {
  /// Returns the matched substring from the input string.
  String get result => input.substring(start, end);
}

/// A regex pattern to match one or more whitespace characters.
const String kSpacePattern = r'[\s]+';

/// A regex pattern to optionally match one or more whitespace characters.
const String kSpacePatternOptional = r'([\s]+)?';
