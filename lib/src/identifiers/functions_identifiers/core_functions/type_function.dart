import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A function that retrieves the type of a value.
///
/// This class extends [CoreFunction] and provides an implementation
/// for the Type function, which returns the type of the input parameter.
class TypeFunction extends CoreFunction {
  TypeFunction() : super(functionNotations: ['Type', 'ValueType']);

  /// Calculates the type of the first parameter.
  ///
  /// Returns the value type as a string (e.g., 'Number', 'String', 'Null', etc.).
  @override
  calculate(List<ValueWrapper> parameters) {
    return parameters.first.valueType;
  }

  /// Checks if the number of parameters passed is valid.
  ///
  /// The Type function requires exactly one parameter.
  @override
  bool checkParameters(List<ValueWrapper> terms) {
    return terms.length == 1;
  }
}
