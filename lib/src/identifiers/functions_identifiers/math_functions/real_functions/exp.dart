import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A function to calculate the exponential of a number.
///
/// This function calculates `e` raised to the power of the given real number.
/// It is often used in mathematical calculations involving exponentials.
///
/// Function notations:
/// - 'Exp'
/// - 'Math.Exp'
class ExpFunction extends RealFunction {
  ExpFunction()
      : super(functionNotations: [
          'Exp',
          'Math.Exp',
        ]);

  /// Calculates the exponential of the given parameter.
  ///
  /// Takes a list of [ValueWrapper] parameters. It computes `e` raised to the power
  /// of the provided number. The result is returned as a [FormulaValue].
  @override
  calculate(List<ValueWrapper> parameters) {
    var power = parameters.first.value;
    return toFormulaValue(pow(e, power));
  }

  /// Checks if the provided parameters are valid for the exponential calculation.
  ///
  /// Validates that there is exactly one parameter and that it is a real number.
  @override
  bool checkParameters(List<ValueWrapper> terms) =>
      (terms.length == 1 && terms.first.isRealNumber);
}
