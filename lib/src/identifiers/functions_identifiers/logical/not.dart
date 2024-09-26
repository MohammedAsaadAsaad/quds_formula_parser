import 'package:quds_formula_parser/quds_formula_parser.dart';

/// Represents the NOT function in formulas.
///
/// This function evaluates a Boolean value and returns its negation.
class NotFunction extends LogicalFunction {
  NotFunction() : super(functionNotations: ['Not']);

  /// Calculates the result of the NOT function.
  ///
  /// It takes one parameter:
  /// - The parameter must be a Boolean value.
  /// Returns the negation of the Boolean value.
  /// If the parameter is not provided or is not a Boolean, it returns an NA value.
  @override
  FormulaValue calculate(List<ValueWrapper> parameters) {
    if (parameters.length != 1 || parameters[0] is! BooleanWrapper) {
      return NAValue();
    }

    return BooleanWrapper(!(parameters[0] as BooleanWrapper).value);
  }

  /// Checks if the parameters passed to the NOT function are valid.
  ///
  /// The parameter must be exactly one, and it must be a Boolean.
  @override
  bool checkParameters(List<FormulaTerm> terms) {
    if (terms.length != 1) return false;
    if (terms[0] is! BooleanWrapper) return false;
    return true;
  }
}
