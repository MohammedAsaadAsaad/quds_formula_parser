import 'package:quds_formula_parser/quds_formula_parser.dart';

/// Represents a function that calculates the median of a list of numbers.
///
/// This class extends [ListFunction] and implements the logic for
/// finding the median value from the provided parameters.
class MedianFunction extends ListFunction {
  MedianFunction() : super(functionNotations: ['Median']);

  @override
  FormulaValue calculate(List<ValueWrapper> parameters) {
    // Map the parameters to their numeric values and calculate the median
    var result = parameters
        .map((e) => e
            as RealNumberWrapper) // Ensure the parameter is a RealNumberWrapper
        .map((e) => e.value) // Extract the numeric values
        .median(); // Calculate the median

    return toFormulaValue(result); // Convert result to FormulaValue and return
  }

  @override
  bool checkParameters(List<ValueWrapper> terms) {
    // Ensure there is at least one parameter and all are RealNumberWrapper
    if (terms.isEmpty) return false;

    return terms.every((e) => e.isRealNumber);
  }
}
