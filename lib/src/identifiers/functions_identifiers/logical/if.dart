import 'package:quds_formula_parser/quds_formula_parser.dart';

/// Represents the IF function in formulas.
///
/// This function evaluates a condition and returns one value if the condition is true,
/// and another value if the condition is false.
class IfFunction extends LogicalFunction {
  IfFunction() : super(functionNotations: ['If']);

  /// Calculates the result of the IF function.
  ///
  /// It takes three parameters:
  /// - The first parameter must be a Boolean value.
  /// - If the first parameter is true, it returns the second parameter;
  /// - If the first parameter is false, it returns the third parameter.
  /// If the number of parameters is not exactly three or the first parameter is not a Boolean,
  /// it returns an NA value.
  @override
  FormulaValue calculate(List<ValueWrapper> parameters) {
    if (parameters.length != 3 || parameters[0] is! BooleanWrapper) {
      return NAValue();
    }

    return parameters[0].value ? parameters[1] : parameters[2];
  }

  /// Checks if the parameters passed to the IF function are valid.
  ///
  /// The parameters must be exactly three, and the first parameter must be a Boolean.
  @override
  bool checkParameters(List<FormulaTerm> terms) {
    if (terms.length != 3) return false;
    if (terms[0] is! BooleanWrapper) return false;
    return true;
  }
}
