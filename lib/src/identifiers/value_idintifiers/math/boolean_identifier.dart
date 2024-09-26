import '../../../../quds_formula_parser.dart';

/// A class to identify and parse boolean values in a formula.
///
/// This class identifies boolean strings (`true` or `false`) and converts them into [BooleanWrapper] objects.
class BooleanIdentifier extends ValueIdentifier<BooleanWrapper> {
  /// Parses the input string to identify and extract a boolean value.
  ///
  /// The string can be either `true` or `false` (case-insensitive). Returns a [BooleanWrapper]
  /// object representing the parsed boolean value.
  @override
  BooleanWrapper parse(String str) {
    str = str.trim().toLowerCase();
    return BooleanWrapper(str == 'true' ? true : false);
  }

  /// Returns the regular expression pattern used to identify boolean strings.
  ///
  /// The pattern matches either `true` or `false` (case-insensitive).
  @override
  String get pattern => '(true|false)';
}
