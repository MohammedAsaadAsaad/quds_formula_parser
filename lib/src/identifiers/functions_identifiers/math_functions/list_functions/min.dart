import 'package:quds_formula_parser/quds_formula_parser.dart';

/// Represents a function that calculates the minimum value from a list of numbers.
///
/// This class extends [ListFunction] and implements the logic for
/// finding the minimum value from the provided parameters.
class MinFunction extends ListFunction {
  MinFunction() : super(functionNotations: ['Min', 'Math.Min']);

  @override
  FormulaValue calculate(List<ValueWrapper> parameters) {
    // Return NA if the list is empty
    if (parameters.isEmpty) return NAValue();

    // Initialize with the first value in the list
    var v = (parameters.first as RealNumberWrapper).value;

    // Loop through the remaining values to find the minimum
    for (int i = 1; i < parameters.length; i++) {
      var curr = (parameters[i] as RealNumberWrapper).value;

      // Update the minimum value if the current value is smaller
      if (curr < v) {
        v = curr;
      }
    }

    return toFormulaValue(v); // Return the minimum value as a FormulaValue
  }

  @override
  bool checkParameters(List<FormulaTerm> terms) {
    // Ensure there is at least one parameter
    if (terms.isEmpty) return false;

    // Check if all terms are of type RealNumberWrapper
    for (var t in terms) {
      if (t is! RealNumberWrapper) return false;
    }

    return true; // Valid parameters
  }
}
