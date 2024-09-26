import 'package:quds_formula_parser/quds_formula_parser.dart';

/// Represents a function that counts the number of provided values.
///
/// This class extends [ListFunction] and implements the logic for
/// counting the number of input parameters.
class CountFunction extends ListFunction {
  CountFunction() : super(functionNotations: ['Count']);

  @override
  FormulaValue calculate(List<ValueWrapper> parameters) {
    // Return the count of the provided parameters as a RealNumberWrapper
    return RealNumberWrapper(parameters.length);
  }

  @override
  bool checkParameters(List<FormulaTerm> terms) {
    // No specific parameter validation; any number of terms is valid
    return true;
  }
}
