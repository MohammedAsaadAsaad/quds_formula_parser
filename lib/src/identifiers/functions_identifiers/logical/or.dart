import 'package:quds_formula_parser/quds_formula_parser.dart';

/// Represents the OR function in formulas.
///
/// This function evaluates two Boolean values and returns their disjunction.
class OrFunction extends LogicalFunction {
  OrFunction() : super(functionNotations: ['Or']);

  /// Calculates the result of the OR function.
  ///
  /// It takes two parameters:
  /// - Both parameters must be Boolean values.
  /// Returns true if at least one of the parameters is true; otherwise, returns false.
  /// If the parameters are not provided correctly, it returns an NA value.
  @override
  FormulaValue calculate(List<ValueWrapper> parameters) {
    if (parameters.length != 2 ||
        parameters[0] is! BooleanWrapper ||
        parameters[1] is! BooleanWrapper) {
      return NAValue();
    }

    var aValue = (parameters[0] as BooleanWrapper).value;
    var bValue = (parameters[1] as BooleanWrapper).value;
    return BooleanWrapper(aValue || bValue);
  }

  /// Checks if the parameters passed to the OR function are valid.
  ///
  /// Both parameters must be Boolean values.
  @override
  bool checkParameters(List<FormulaTerm> terms) {
    if (terms.length != 2) return false;

    if (terms[0] is! BooleanWrapper || terms[1] is! BooleanWrapper) {
      return false;
    }

    return true;
  }
}
