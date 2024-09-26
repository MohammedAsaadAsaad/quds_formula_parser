import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A function to convert a string to lowercase.
///
/// This function takes a string as input and returns a new string with all characters
/// converted to lowercase.
///
/// Function notations:
/// - 'Lower'
/// - 'ToLower'
/// - 'Str.Lower'
class ToLowerFunction extends StringFunction {
  ToLowerFunction()
      : super(functionNotations: ['Lower', 'ToLower', 'Str.Lower']);

  /// Converts the given string to lowercase.
  ///
  /// Takes a list of [ValueWrapper] parameters, where the first parameter is expected
  /// to be a string. It returns the string in lowercase as a [FormulaValue].
  @override
  calculate(List<ValueWrapper> parameters) {
    return toFormulaValue((parameters.first.value as String).toLowerCase());
  }

  /// Checks if the provided parameters are valid for the lowercase operation.
  ///
  /// Validates that there is exactly one parameter and that it is a string.
  @override
  bool checkParameters(List<ValueWrapper> terms) {
    return terms.length == 1 && terms.first.isString;
  }
}
