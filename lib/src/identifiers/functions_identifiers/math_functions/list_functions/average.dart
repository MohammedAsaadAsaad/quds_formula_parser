import 'package:quds_formula_parser/quds_formula_parser.dart';

/// Represents a function that calculates the average of a list of values.
///
/// This class extends [ListFunction] and implements the logic for
/// calculating the average (mean) value of the provided parameters.
class AverageFunction extends ListFunction {
  AverageFunction()
      : super(functionNotations: [
          'Avg',
          'Math.Avg',
          'Average',
          'Math.Average',
          'Mean',
          'Math.Mean',
        ]);

  /// The sum function used to calculate the total of the provided values.
  late final _sumFunction = SumFunction();

  @override
  FormulaValue calculate(List<ValueWrapper> parameters) {
    // Calculate the sum of the provided parameters
    var sum = _sumFunction.calculate(parameters) as FormulaValue;

    // Check if the sum is NA or null; if so, return the same
    if (sum.isNAValue || sum.isNull) return sum;

    // Calculate and return the average
    return DivisionOperator()
        .calculate(sum, RealNumberWrapper(parameters.length));
  }

  @override
  bool checkParameters(List<FormulaTerm> terms) {
    // Ensure that there is at least one parameter
    return terms.isNotEmpty;
  }
}
