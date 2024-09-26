import 'package:quds_formula_parser/quds_formula_parser.dart';

/// Represents a function that returns the maximum value from a list of numbers.
///
/// This class extends [ListFunction] and implements the logic for
/// finding the maximum value among the provided parameters.
class MaxFunction extends ListFunction {
  MaxFunction() : super(functionNotations: ['Max', 'Math.Max']);

  @override
  FormulaValue calculate(List<ValueWrapper> parameters) {
    // Return NA if no parameters are provided
    if (parameters.isEmpty) return NAValue();

    // Initialize the maximum value with the first parameter
    var v = (parameters.first as RealNumberWrapper).value;

    // Iterate through the parameters to find the maximum value
    for (int i = 1; i < parameters.length; i++) {
      var curr = (parameters[i] as RealNumberWrapper).value;

      if (curr > v) {
        v = curr; // Update the maximum value if a larger one is found
      }
    }
    return RealNumberWrapper(
        v); // Return the maximum value wrapped in a RealNumberWrapper
  }

  @override
  bool checkParameters(List<FormulaTerm> terms) {
    // Ensure there is at least one parameter and all are RealNumberWrapper
    if (terms.isEmpty) return false;
    for (var t in terms) {
      if (t is! RealNumberWrapper) return false; // Validate parameter types
    }
    return true; // Valid parameters
  }
}
