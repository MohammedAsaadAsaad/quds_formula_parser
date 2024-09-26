import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A function to calculate the power of a number.
///
/// This function raises the first number (base) to the power of the second number (exponent).
/// It is commonly used for exponentiation calculations.
///
/// Function notations:
/// - 'Pow'
/// - 'Power'
/// - 'Math.Pow'
class PowerFunction extends RealFunction {
  PowerFunction()
      : super(functionNotations: [
          'Pow',
          'Power',
          'Math.Pow',
        ]);

  /// Calculates the power of the given parameters.
  ///
  /// Takes a list of two [ValueWrapper] parameters, where the first is the base and
  /// the second is the exponent. The result of the exponentiation is returned
  /// as a [FormulaValue].
  @override
  calculate(List<ValueWrapper> parameters) {
    return toFormulaValue(pow(parameters.first.value, parameters[1].value));
  }

  /// Checks if the provided parameters are valid for exponentiation.
  ///
  /// Validates that there are exactly two parameters, and that both are real numbers.
  @override
  bool checkParameters(List<ValueWrapper> terms) =>
      terms.length == 2 && terms[0].isRealNumber && terms[1].isRealNumber;
}

/// A function to calculate the square root of a number.
///
/// This function calculates the square root of the given real number. It is used
/// in mathematical operations that involve finding the root of a number.
///
/// Function notations:
/// - 'SqRt'
/// - 'SqRoot'
/// - 'Math.Sqrt'
class SqRtFunction extends RealFunction {
  SqRtFunction()
      : super(functionNotations: [
          'SqRt',
          'SqRoot',
          'Math.Sqrt',
        ]);

  /// Calculates the square root of the given parameter.
  ///
  /// Takes a list of one [ValueWrapper] parameter, which should be a real number,
  /// and returns the square root of the number as a [FormulaValue].
  @override
  calculate(List<ValueWrapper> parameters) {
    return toFormulaValue(sqrt(parameters.first.value));
  }

  /// Checks if the provided parameter is valid for square root calculation.
  ///
  /// Validates that there is exactly one parameter, and that it is a real number.
  @override
  bool checkParameters(List<ValueWrapper> terms) =>
      terms.length == 1 && terms.first.isRealNumber;
}
