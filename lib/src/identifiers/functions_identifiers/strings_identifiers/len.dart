import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A function to return the length of a string.
///
/// This function takes a string as input and returns the number of characters in the string.
///
/// Function notations:
/// - 'Len'
/// - 'Str.Len'
/// - 'Length'
/// - 'Str.Length'
class StringLength extends StringFunction {
  StringLength()
      : super(functionNotations: [
          'Len',
          'Str.Len',
          'Length',
          'Str.Length',
        ]);

  /// Calculates the length of the given string.
  ///
  /// Takes a list of [ValueWrapper] parameters, where the first parameter is expected
  /// to be a string. It returns the length of the string as a [FormulaValue].
  @override
  calculate(List<ValueWrapper> parameters) {
    return toFormulaValue((parameters.first.value as String).length);
  }

  /// Checks if the provided parameters are valid for string length calculation.
  ///
  /// Validates that there is exactly one parameter and that it is a string.
  @override
  bool checkParameters(List<ValueWrapper> terms) {
    return terms.length == 1 && terms.first is StringWrapper;
  }
}
