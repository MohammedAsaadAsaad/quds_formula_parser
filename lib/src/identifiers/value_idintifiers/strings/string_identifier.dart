import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A class to identify and parse string values in a formula.
///
/// This class identifies strings enclosed in double quotes (`"`) and converts them into [StringWrapper] objects.
class StringIdentifier extends ValueIdentifier<StringWrapper> {
  /// Parses the input string to identify and extract a string value.
  ///
  /// The string is expected to be enclosed in double quotes (e.g., `"Hello"`). The enclosing
  /// quotes are removed, and the content is returned as a [StringWrapper].
  @override
  StringWrapper? parse(String str) {
    if (str.startsWith('"')) str = str.substring(1, str.length);
    if (str.endsWith('"')) str = str.substring(0, str.length - 1);
    return toFormulaValue(str) as StringWrapper;
  }

  /// Returns the regular expression pattern used to identify string literals.
  ///
  /// The pattern matches any text enclosed in double quotes, allowing any characters inside
  /// except for other double quotes (e.g., `"Hello World!"`).
  @override
  String get pattern => r'"[^"]*"';
}
