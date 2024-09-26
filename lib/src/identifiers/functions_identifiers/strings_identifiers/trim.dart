import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A function to trim spaces from both ends of a string.
///
/// This function removes leading and trailing whitespace from a string.
///
/// Function notations:
/// - 'Trim'
/// - 'Str.Trim'
class TrimFunction extends StringFunction {
  TrimFunction() : super(functionNotations: ['Trim', 'Str.Trim']);

  /// Trims the spaces from both ends of the given string.
  ///
  /// Takes a list of [ValueWrapper] parameters, where the first parameter is expected
  /// to be a string. It returns the trimmed string as a [FormulaValue].
  @override
  calculate(List<ValueWrapper> parameters) {
    return toFormulaValue((parameters.first.value as String).trim());
  }

  /// Checks if the provided parameters are valid for trimming.
  ///
  /// Validates that there is exactly one parameter and that it is a string.
  @override
  bool checkParameters(List<ValueWrapper> terms) {
    return terms.length == 1 && terms.first.isString;
  }
}

/// A function to trim spaces from the left side of a string.
///
/// This function removes leading whitespace from a string.
///
/// Function notations:
/// - 'TrimLeft'
/// - 'Str.TrimLeft'
class TrimLeftFunction extends StringFunction {
  TrimLeftFunction() : super(functionNotations: ['TrimLeft', 'Str.TrimLeft']);

  /// Trims the spaces from the left side of the given string.
  ///
  /// Takes a list of [ValueWrapper] parameters, where the first parameter is expected
  /// to be a string. It returns the left-trimmed string as a [FormulaValue].
  @override
  calculate(List<ValueWrapper> parameters) {
    return toFormulaValue((parameters.first.value as String).trimLeft());
  }

  /// Checks if the provided parameters are valid for left trimming.
  ///
  /// Validates that there is exactly one parameter and that it is a string.
  @override
  bool checkParameters(List<ValueWrapper> terms) {
    return terms.length == 1 && terms.first.isString;
  }
}

/// A function to trim spaces from the right side of a string.
///
/// This function removes trailing whitespace from a string.
///
/// Function notations:
/// - 'TrimRight'
/// - 'Str.TrimRight'
class TrimRightFunction extends StringFunction {
  TrimRightFunction()
      : super(functionNotations: ['TrimRight', 'Str.TrimRight']);

  /// Trims the spaces from the right side of the given string.
  ///
  /// Takes a list of [ValueWrapper] parameters, where the first parameter is expected
  /// to be a string. It returns the right-trimmed string as a [FormulaValue].
  @override
  calculate(List<ValueWrapper> parameters) {
    return toFormulaValue((parameters.first.value as String).trimRight());
  }

  /// Checks if the provided parameters are valid for right trimming.
  ///
  /// Validates that there is exactly one parameter and that it is a string.
  @override
  bool checkParameters(List<ValueWrapper> terms) {
    return terms.length == 1 && terms.first.isString;
  }
}
