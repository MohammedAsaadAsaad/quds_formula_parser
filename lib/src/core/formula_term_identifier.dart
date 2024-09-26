import 'package:quds_formula_parser/quds_formula_parser.dart';

/// An abstract class that identifies and parses formula terms based on a specified pattern.
/// This class provides a mechanism to match strings against a regular expression
/// and extract relevant formula terms of type `T`.
abstract class FormulaTermIdentifier<T extends FormulaTerm> {
  /// Constructs a `FormulaTermIdentifier`.
  FormulaTermIdentifier();

  /// A string pattern used to define the regular expression for matching formula terms.
  String get pattern;

  /// A cached regular expression created from the pattern for matching terms.
  late final RegExp _patternRegex = RegExp(pattern, caseSensitive: false);

  /// Returns the compiled regular expression used for matching.
  RegExp get patternRegex => _patternRegex;

  /// Tries to find and return the matching string from the given input text.
  /// If the input text starts with the pattern, it returns the matched string.
  /// Returns `null` if no match is found.
  String? getMatchString(String allText) {
    if (allText.startsWith(_patternRegex)) {
      var result = _patternRegex.firstMatch(allText);
      return result!.input.substring(result.start, result.end);
    }
    return null;
  }

  /// Parses a string into a formula term of type `T`.
  /// Returns `null` if the string cannot be parsed into a valid term.
  T? parse(String str);
}
