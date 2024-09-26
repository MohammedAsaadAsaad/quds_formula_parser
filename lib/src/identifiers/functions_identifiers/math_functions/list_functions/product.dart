import 'package:quds_formula_parser/quds_formula_parser.dart';

/// Represents a function that calculates the product of a list of numbers.
///
/// This class extends [ListFunction] and implements the logic for
/// multiplying together the provided parameters.
class ProductFunction extends ListFunction {
  ProductFunction() : super(functionNotations: ['Product']);

  @override
  FormulaValue calculate(List<ValueWrapper> parameters) {
    // Return NullValue if the list is empty
    if (parameters.isEmpty) return NullValue();

    // If there is only one parameter, return it as the product
    if (parameters.length == 1) return parameters.first;

    // Initialize the multiplication operator
    var multiOperator = MultiplyOperator();

    // Calculate the product of the first two parameters
    var result = multiOperator.calculate(parameters[0], parameters[1]);

    // Iterate through the remaining parameters to calculate the product
    for (int i = 2; i < parameters.length; i++) {
      if (result.isNAValue) return NAValue(); // Check for NA value
      if (result.isNull) return NullValue(); // Check for null value

      // Multiply the current result by the next parameter
      result = multiOperator.calculate(result, parameters[i]);
    }

    return result; // Return the final product
  }

  @override
  bool checkParameters(List<FormulaTerm> terms) {
    // Ensure there is at least one parameter
    return terms.isNotEmpty;
  }
}
