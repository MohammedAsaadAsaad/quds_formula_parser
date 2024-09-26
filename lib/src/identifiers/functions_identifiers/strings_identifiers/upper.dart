import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A function to convert a string to uppercase.
///
/// This function takes a string as input and returns a new string with all characters
/// converted to uppercase.
///
/// Function notations:
/// - 'Upper'
/// - 'ToUpper'
/// - 'Str.Upper'
class ToUpperFunction extends StringFunction {
  ToUpperFunction()
      : super(functionNotations: ['Upper', 'ToUpper', 'Str.Upper']);

  /// Converts the given string to uppercase.
  ///
  /// Takes a list of [ValueWrapper] parameters, where the first parameter is expected
  /// to be a string. It returns the string in uppercase as a [FormulaValue].
  @override
  calculate(List<ValueWrapper> parameters) {
    return toFormulaValue((parameters.first.value as String).toUpperCase());
  }

  /// Checks if the provided parameters are valid for the uppercase operation.
  ///
  /// Validates that there is exactly one parameter and that it is a string.
  @override
  bool checkParameters(List<ValueWrapper> terms) {
    return terms.length == 1 && terms.first.isString;
  }
}
