import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A singleton class to identify and parse brackets in a formula.
///
/// This class is responsible for identifying and distinguishing between opening and closing
/// brackets. It returns the corresponding [Bracket] object based on the input string.
class BracketIdentifier extends FormulaTermIdentifier<Bracket> {
  /// Private constructor for the singleton instance of [BracketIdentifier].
  BracketIdentifier._();

  /// Singleton instance of the [BracketIdentifier] class.
  static final BracketIdentifier _instance = BracketIdentifier._();

  /// Provides access to the singleton instance of the [BracketIdentifier] class.
  static BracketIdentifier get instance => _instance;

  /// Factory constructor to ensure that only one instance of the class is created.
  factory BracketIdentifier() => instance;

  /// Parses the input string to identify if it is an opening or closing bracket.
  ///
  /// Takes a string [str] and checks if it is an opening bracket. If so, it returns
  /// an [OpeningBracket]. Otherwise, it returns a [ClosingBracket].
  @override
  Bracket parse(String str) {
    if (openingBracketSymbols.contains(str)) {
      return OpeningBracket();
    } else {
      return ClosingBracket();
    }
  }

  /// Returns the regular expression pattern used to identify brackets.
  ///
  /// The pattern matches common bracket symbols, including opening brackets like `[` and `(`
  /// and closing brackets like `]` and `)`.
  @override
  String get pattern {
    String result = '[';
    for (var o in openingBracketSymbols.split('')) {
      result += '\\$o';
    }
    for (var o in closingBracketSymbols.split('')) {
      result += '\\$o';
    }
    result += ']';

    return result;
  }
}

/// Symbols representing opening brackets.
String openingBracketSymbols = '[(';

/// Symbols representing closing brackets.
String closingBracketSymbols = ')]';
