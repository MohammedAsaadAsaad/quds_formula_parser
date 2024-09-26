import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A singleton class to identify and parse commas in a formula.
///
/// This class identifies commas and semicolons, which are often used as separators in formulas.
/// It returns a [Comma] object when a match is found.
class CommaIdentifier extends FormulaTermIdentifier<Comma> {
  /// Private constructor for the singleton instance of [CommaIdentifier].
  CommaIdentifier._();

  /// Singleton instance of the [CommaIdentifier] class.
  static final CommaIdentifier _instance = CommaIdentifier._();

  /// Provides access to the singleton instance of the [CommaIdentifier] class.
  static CommaIdentifier get instance => _instance;

  /// Factory constructor to ensure that only one instance of the class is created.
  factory CommaIdentifier() => instance;

  /// Parses the input string to identify a comma or semicolon.
  ///
  /// Takes a string [str] and returns a [Comma] object.
  @override
  Comma parse(String str) {
    return Comma();
  }

  /// Returns the regular expression pattern used to identify commas and semicolons.
  ///
  /// The pattern matches commas `,` and semicolons `;`.
  @override
  String get pattern {
    return r'[\,\;]';
  }
}
