import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A function to calculate the variance of a list of numbers.
///
/// This function computes the variance of the provided parameters, which are
/// expected to be real numbers. If the input is invalid or empty, it returns [NAValue].
///
/// Function notations:
/// - 'Var'
/// - 'Variance'
class VarianceFunction extends ListFunction {
  /// Creates an instance of [VarianceFunction] with the notations 'VAR' and 'VARIANCE'.
  VarianceFunction() : super(functionNotations: ['Var', 'Variance']);

  /// Calculates the variance of the given parameters.
  ///
  /// Takes a list of [ValueWrapper] parameters and maps each element
  /// to a [RealNumberWrapper], extracting their values. Then, it computes
  /// the variance of these values using a variance calculation method.
  /// The result is converted to a [FormulaValue] and returned.
  @override
  calculate(List<ValueWrapper> parameters) {
    var result = parameters
        .map((e) => e as RealNumberWrapper)
        .map((e) => e.value)
        .variance();

    return toFormulaValue(result);
  }

  /// Checks if the provided parameters are valid for variance calculation.
  ///
  /// Validates that the number of parameters is not empty. Returns false
  /// if there are no parameters. Additionally, checks that each parameter
  /// is of type [RealNumberWrapper]. Returns true if all checks pass.
  @override
  bool checkParameters(List<ValueWrapper> terms) {
    if (terms.isEmpty) return false;
    return terms.every((e) => e.isRealNumber);
  }
}
