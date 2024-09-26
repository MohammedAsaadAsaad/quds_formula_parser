import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A function to round a number to a specified number of decimal places.
///
/// This function rounds the given number to the nearest integer or to a specified
/// number of decimal places if provided.
///
/// Function notations:
/// - 'Round'
class RoundFunction extends RealFunction {
  RoundFunction() : super(functionNotations: ['Round']);

  /// Rounds the given number to the specified number of decimal places.
  ///
  /// Takes a list of [ValueWrapper] parameters. If only one parameter is provided,
  /// it rounds to the nearest integer. If two parameters are provided, the second
  /// parameter specifies the number of decimal places. The result is returned as a [FormulaValue].
  @override
  calculate(List<ValueWrapper> parameters) {
    if (parameters.isEmpty) return NAValue();
    int digits = parameters.length == 1 ? 0 : parameters[1].value;
    var result = parameters.first.value as num;
    var resultText = result.toStringAsFixed(digits);
    return toFormulaValue(num.parse(resultText));
  }

  /// Checks if the provided parameters are valid for rounding.
  ///
  /// Validates that the first parameter is a real number, and if the second parameter
  /// is provided, it is an integer representing the number of decimal places.
  @override
  bool checkParameters(List<ValueWrapper> terms) {
    if (terms.isEmpty) return false;
    if (terms.first is! RealNumberWrapper) return false;
    if (terms.length > 1) {
      var dV = terms[1].value;
      if (dV is! int) return false;
    }
    return true;
  }
}

/// A function to convert a number to an integer.
///
/// This function converts a real number to its integer form by truncating the decimal part.
///
/// Function notations:
/// - 'Int'
/// - 'ToInt'
/// - 'ToInteger'
class IntFunction extends RealFunction {
  IntFunction() : super(functionNotations: ['Int', 'ToInt', 'ToInteger']);

  /// Converts the given real number to an integer.
  ///
  /// Takes a list of [ValueWrapper] parameters. The first parameter is expected to be
  /// a real number, and the result is the integer form of that number.
  @override
  calculate(List<ValueWrapper> parameters) {
    if (parameters.isEmpty) return NAValue();
    return (parameters[0].value as num).toInt();
  }

  /// Checks if the provided parameter is valid for conversion to an integer.
  ///
  /// Validates that there is exactly one parameter and that it is a number.
  @override
  bool checkParameters(List<ValueWrapper> terms) {
    return terms.length == 1 && terms.first.isNumber;
  }
}
