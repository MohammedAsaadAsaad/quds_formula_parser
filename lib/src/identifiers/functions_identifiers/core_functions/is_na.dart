import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A function that checks if a value is 'Not Available' (N/A).
///
/// This class extends [CoreFunction] and provides an implementation
/// for the IsNA function, which evaluates whether the input parameter
/// is an instance of [NAValue].
class IsNAFunction extends CoreFunction {
  IsNAFunction() : super(functionNotations: ['IsNA', 'Type.IsNA']);

  /// Calculates whether the first parameter is an N/A value.
  ///
  /// Returns `true` if the parameter is of type [NAValue], otherwise returns `false`.
  @override
  calculate(List<ValueWrapper> parameters) {
    return parameters.first is NAValue;
  }

  /// Checks if the number of parameters passed is valid.
  ///
  /// The IsNA function requires exactly one parameter.
  @override
  bool checkParameters(List<ValueWrapper> terms) {
    return terms.length == 1;
  }

  @override
  String get toTexNotation => '\$IsNA';
}

/// A function that checks if a value is null.
///
/// This class extends [CoreFunction] and provides an implementation
/// for the IsNull function, which evaluates whether the input parameter
/// is an instance of [NullValue].
class IsNullFunction extends CoreFunction {
  IsNullFunction() : super(functionNotations: ['IsNull', 'Type.IsNull']);

  /// Calculates whether the first parameter is null.
  ///
  /// Returns `true` if the parameter is of type [NullValue], otherwise returns `false`.
  @override
  calculate(List<ValueWrapper> parameters) {
    return parameters.first is NullValue;
  }

  /// Checks if the number of parameters passed is valid.
  ///
  /// The IsNull function requires exactly one parameter.
  @override
  bool checkParameters(List<ValueWrapper> terms) {
    return terms.length == 1;
  }

  @override
  String get toTexNotation => '\$IsNull';
}
