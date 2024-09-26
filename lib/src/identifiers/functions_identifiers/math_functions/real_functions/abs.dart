import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A function to calculate the absolute value of a number.
///
/// This function supports both real and complex numbers. If the input is a real number,
/// it returns the absolute value of the number. If the input is a complex number,
/// it returns the magnitude (absolute value) of the complex number.
///
/// Function notations:
/// - 'Abs'
/// - 'Math.Abs'
/// - 'Absolute'
class AbsFunction extends RealFunction {
  AbsFunction()
      : super(functionNotations: [
          'Abs',
          'Math.Abs',
          'Absolute',
        ]);

  /// Calculates the absolute value of the given parameter.
  ///
  /// Takes a list of [ValueWrapper] parameters. If the list does not contain exactly
  /// one parameter, it returns [NAValue]. It supports both [ComplexNumberWrapper]
  /// and [RealNumberWrapper], and calculates the absolute value accordingly.
  @override
  calculate(List<ValueWrapper> parameters) {
    if (parameters.length != 1) return NAValue();

    var p = parameters.first;
    dynamic result;
    if (p is ComplexNumberWrapper) {
      result = p.value.abs;
    } else if (p is RealNumberWrapper) {
      result = p.value.abs();
    }

    return toFormulaValue(result);
  }

  /// Checks if the provided parameters are valid for absolute value calculation.
  ///
  /// Validates that there is exactly one parameter and that it is a number.
  @override
  bool checkParameters(List<ValueWrapper> terms) =>
      terms.length == 1 && terms.first.isNumber;
}
