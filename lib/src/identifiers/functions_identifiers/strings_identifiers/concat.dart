import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A function to concatenate multiple strings.
///
/// This function takes multiple string inputs and concatenates them into a single string.
///
/// Function notations:
/// - 'Concat'
/// - 'Str.Concat'
class StringConcatFunction extends StringFunction {
  StringConcatFunction()
      : super(functionNotations: [
          'Concat',
          'Str.Concat',
        ]);

  /// Concatenates the given string parameters.
  ///
  /// Takes a list of [ValueWrapper] parameters, where each parameter is expected
  /// to be a string. It concatenates the strings and returns the result as a [FormulaValue].
  @override
  calculate(List<ValueWrapper> parameters) {
    return toFormulaValue(
        parameters.map((e) => (e as StringWrapper).value).join());
  }

  /// Checks if the provided parameters are valid for concatenation.
  ///
  /// Validates that there is at least one parameter and that all parameters are strings.
  @override
  bool checkParameters(List<ValueWrapper> terms) {
    if (terms.isEmpty) return false;
    for (var t in terms) {
      if (!t.isString) return false;
    }
    return true;
  }
}
