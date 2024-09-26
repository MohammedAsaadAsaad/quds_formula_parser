import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A class to identify and parse named values (constants or variables) in a formula.
///
/// This class identifies strings that represent either constants or variables, provided by a [FormulaProvider].
/// It checks the input string against the list of available constants and variables, and returns the corresponding [NamedValue].
class NamedValuesIdentifier extends FormulaTermIdentifier<NamedValue> {
  /// The [FormulaProvider] that supplies the constants and variables to match against.
  final FormulaProvider provider;

  /// Creates a [NamedValuesIdentifier] with the provided [FormulaProvider].
  NamedValuesIdentifier({required this.provider});

  /// Parses the input string to identify and extract a named value.
  ///
  /// The string is compared to the available constants and variables (case-insensitive).
  /// If a match is found, the corresponding [NamedValue] is returned. If no match is found, it returns `null`.
  @override
  NamedValue? parse(String str) {
    var s = str.toLowerCase();

    // Check if the string matches any of the constants.
    for (var f in provider.constants) {
      if (f.stringToView.toLowerCase() == s) return f;
    }

    // Check if the string matches any of the variables.
    for (var f in provider.variables) {
      if (f.stringToView.toLowerCase() == s) return f;
    }
    return null;
  }

  /// Returns the regular expression pattern used to identify named values.
  ///
  /// The pattern matches named values, including constants like `π` and variables using letters, underscores, and digits.
  @override
  String get pattern => r'[\π\w\_]+([\w\d\_]+)?';
}
