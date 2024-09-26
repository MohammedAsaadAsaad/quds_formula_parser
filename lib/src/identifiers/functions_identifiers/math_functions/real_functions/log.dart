import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A function to calculate the logarithm of a number.
///
/// This function calculates the logarithm of a given number with an optional base.
/// If no base is provided, the natural logarithm (base `e`) is used.
///
/// Function notations:
/// - 'Log'
/// - 'Logarithm'
/// - 'Math.Log'
class LogFunction extends RealFunction {
  LogFunction()
      : super(functionNotations: [
          'Log',
          'Logarithm',
          'Math.Log',
        ]);

  /// Calculates the logarithm of the given parameter.
  ///
  /// Takes a list of [ValueWrapper] parameters. If two parameters are provided,
  /// it calculates the logarithm with the given base. If only one parameter is
  /// provided, it calculates the natural logarithm (base `e`). The result is
  /// returned as a [FormulaValue].
  @override
  calculate(List<ValueWrapper> parameters) {
    var power = parameters.first.value;
    var base = parameters.length == 2 ? parameters[1].value : e;
    return toFormulaValue(log(power) / log(base));
  }

  /// Checks if the provided parameters are valid for logarithm calculation.
  ///
  /// Validates that the number of parameters is either one or two, and that
  /// the second parameter (if provided) is a real number.
  @override
  bool checkParameters(List<ValueWrapper> terms) =>
      (terms.length == 1 || terms.length == 2) &&
      (terms.length == 1 || terms[1].isRealNumber);
}
