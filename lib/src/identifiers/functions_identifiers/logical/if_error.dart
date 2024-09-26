import 'package:quds_formula_parser/quds_formula_parser.dart';

/// Represents the IFERROR function in formulas.
///
/// This function checks if the first parameter is an NA value.
/// If it is, it returns the second parameter; otherwise, it returns
/// the first parameter.
class IfErrorFunction extends LogicalFunction {
  IfErrorFunction() : super(functionNotations: ['IfError']);

  /// Calculates the result of the IFERROR function.
  ///
  /// If the first parameter is an NA value, it returns the second parameter.
  /// If the first parameter is not an NA value, it returns the first parameter.
  /// If the number of parameters is not exactly two, it returns an NA value.
  @override
  FormulaValue calculate(List<ValueWrapper> parameters) {
    if (parameters.length != 2) {
      return NAValue();
    }
    if (parameters[0] is! NAValue) return parameters[0];

    return parameters[1];
  }

  /// Checks if the parameters passed to the IFERROR function are valid.
  ///
  /// The parameters must be exactly two.
  @override
  bool checkParameters(List<ValueWrapper> terms) {
    if (terms.length != 2) return false;
    return true;
  }
}
