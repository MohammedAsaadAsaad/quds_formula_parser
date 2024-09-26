import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A function to calculate the modulus (remainder) of two numbers.
///
/// This function calculates the modulus (remainder) of the first number divided by the second.
/// It is commonly used in mathematical operations involving divisibility and remainders.
///
/// Function notations:
/// - 'Mod'
/// - 'Modulus'
/// - 'Math.Mod'
class ModFunction extends RealFunction {
  ModFunction()
      : super(functionNotations: [
          'Mod',
          'Modulus',
          'Math.Mod',
        ]);

  /// Calculates the modulus (remainder) of the given parameters.
  ///
  /// Takes a list of two [ValueWrapper] parameters. The first parameter is divided
  /// by the second, and the remainder is returned as a [FormulaValue].
  @override
  calculate(List<ValueWrapper> parameters) {
    return toFormulaValue(parameters.first.value % parameters[1].value);
  }

  /// Checks if the provided parameters are valid for modulus calculation.
  ///
  /// Validates that there are exactly two parameters, and that both are real numbers.
  @override
  bool checkParameters(List<ValueWrapper> terms) =>
      terms.length == 2 && terms[0].isRealNumber && terms[1].isRealNumber;
}
