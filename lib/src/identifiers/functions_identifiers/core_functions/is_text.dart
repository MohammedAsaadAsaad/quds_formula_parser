import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A function that checks if a value is a string (text).
///
/// This class extends [CoreFunction] and provides an implementation
/// for the IsText function, which evaluates whether the input parameter
/// is of type [String].
class IsTextFunction extends CoreFunction {
  IsTextFunction() : super(functionNotations: ['IsText', 'Type.IsText']);

  /// Calculates whether the first parameter is a string.
  ///
  /// Returns `true` if the parameter is of type [String], otherwise returns `false`.
  @override
  calculate(List<ValueWrapper> parameters) {
    return parameters.first.value is String;
  }

  /// Checks if the number of parameters passed is valid.
  ///
  /// The IsText function requires exactly one parameter.
  @override
  bool checkParameters(List<ValueWrapper> terms) {
    return terms.length == 1;
  }
}
