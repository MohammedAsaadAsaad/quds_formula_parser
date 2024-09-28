import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A function to calculate the standard deviation of a list of numbers.
///
/// This function computes the standard deviation for a list of real numbers
/// provided as parameters. If the input is invalid or empty, it returns [NAValue].
///
/// Function notations:
/// - 'StDev'
class StandardDeviationFunction extends ListFunction {
  /// Creates an instance of [StandardDeviationFunction] with the notation 'STDEV'.
  StandardDeviationFunction() : super(functionNotations: ['StDev']);

  /// Calculates the standard deviation of the given parameters.
  ///
  /// Takes a list of [ValueWrapper] parameters, which are expected to be
  /// instances of [RealNumberWrapper]. It computes the standard deviation
  /// and returns the result as a [FormulaValue].
  ///
  /// Returns [NAValue] if the input is invalid or empty.
  @override
  calculate(List<ValueWrapper> parameters) {
    var result = parameters
        .map((e) => e as RealNumberWrapper)
        .map((e) => e.value)
        .standardDeviation();

    return toFormulaValue(result);
  }

  /// Checks if the provided parameters are valid for standard deviation calculation.
  ///
  /// Validates that the number of parameters is not empty and that each
  /// parameter is an instance of [RealNumberWrapper].
  ///
  /// Returns true if the parameters are valid, otherwise false.
  @override
  bool checkParameters(List<ValueWrapper> terms) {
    if (terms.isEmpty) return false;
    return terms.every((e) => e.isRealNumber);
  }
}
