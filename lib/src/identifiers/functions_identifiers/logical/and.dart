import 'package:quds_formula_parser/quds_formula_parser.dart';

/// Represents the logical AND function in formulas.
///
/// This function evaluates two boolean values and returns true if both
/// values are true; otherwise, it returns false. If the parameters
/// do not meet the expected criteria, it returns a NA value.
class AndFunction extends LogicalFunction {
  AndFunction() : super(functionNotations: ['And']);

  /// Calculates the logical AND of two boolean values.
  ///
  /// Returns a [BooleanWrapper] containing the result of the logical
  /// AND operation if valid parameters are provided; otherwise,
  /// returns an [NAValue].
  @override
  FormulaValue calculate(List<ValueWrapper> parameters) {
    if (parameters.length != 2 ||
        parameters[0] is! BooleanWrapper ||
        parameters[1] is! BooleanWrapper) {
      return NAValue();
    }

    var aValue = parameters[0].value;
    var bValue = parameters[1].value;

    return BooleanWrapper(aValue && bValue);
  }

  /// Checks if the parameters passed to the AND function are valid.
  ///
  /// The parameters must be exactly two boolean values.
  @override
  bool checkParameters(List<FormulaTerm> terms) {
    if (terms.length != 2) return false;

    if (terms[0] is! BooleanWrapper || terms[1] is! BooleanWrapper) {
      return false;
    }

    return true;
  }
}
