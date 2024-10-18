import 'package:quds_formula_parser/quds_formula_parser.dart';

/// Represents the IFERROR function in formulas.
///
/// This function checks if the first parameter is an NA (Not Available) value.
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
  ValueWrapper calculate(List<ValueWrapper> parameters) {
    // If the first parameter is not an NA value, return it.
    if (parameters.first is! NAValue) return parameters.first;

    // If the first parameter is an NA value, return the second parameter.
    return parameters[1];
  }

  /// Checks if the parameters passed to the IFERROR function are valid.
  ///
  /// The function requires exactly two parameters.
  @override
  bool checkParameters(List<ValueWrapper> terms) => terms.length == 2;

  @override
  String get toTexNotation => '\$IfError';
}
