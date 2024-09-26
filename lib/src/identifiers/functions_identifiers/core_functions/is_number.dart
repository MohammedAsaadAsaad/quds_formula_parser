import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A function that checks if a value is a number.
///
/// This class extends [CoreFunction] and provides an implementation
/// for the IsNumber function, which evaluates whether the input parameter
/// is either a numeric value or a complex number.
class IsNumberFunction extends CoreFunction {
  IsNumberFunction() : super(functionNotations: ['IsNumber', 'Type.IsNumber']);

  /// Calculates whether the first parameter is a number.
  ///
  /// Returns `true` if the parameter is of type [num] or [ComplexNumber],
  /// otherwise returns `false`.
  @override
  calculate(List<ValueWrapper> parameters) {
    return parameters.first.value is num ||
        parameters.first.value is ComplexNumber;
  }

  /// Checks if the number of parameters passed is valid.
  ///
  /// The IsNumber function requires exactly one parameter.
  @override
  bool checkParameters(List<ValueWrapper> terms) {
    return terms.length == 1;
  }
}

/// A function that checks if a value is a real number.
///
/// This class extends [CoreFunction] and provides an implementation
/// for the IsReal function, which evaluates whether the input parameter
/// is a real number.
class IsRealFunction extends CoreFunction {
  IsRealFunction() : super(functionNotations: ['IsReal', 'Type.IsReal']);

  /// Calculates whether the first parameter is a real number.
  ///
  /// Returns `true` if the parameter is of type [num], otherwise returns `false`.
  @override
  calculate(List<ValueWrapper> parameters) {
    return parameters.first.value is num;
  }

  /// Checks if the number of parameters passed is valid.
  ///
  /// The IsReal function requires exactly one parameter.
  @override
  bool checkParameters(List<ValueWrapper> terms) {
    return terms.length == 1;
  }
}

/// A function that checks if a value is a complex number.
///
/// This class extends [CoreFunction] and provides an implementation
/// for the IsComplex function, which evaluates whether the input parameter
/// is an instance of [ComplexNumber].
class IsComplexFunction extends CoreFunction {
  IsComplexFunction()
      : super(functionNotations: ['IsComplex', 'Type.IsComplex']);

  /// Calculates whether the first parameter is a complex number.
  ///
  /// Returns `true` if the parameter is of type [ComplexNumber], otherwise returns `false`.
  @override
  calculate(List<ValueWrapper> parameters) {
    return parameters.first.value is ComplexNumber;
  }

  /// Checks if the number of parameters passed is valid.
  ///
  /// The IsComplex function requires exactly one parameter.
  @override
  bool checkParameters(List<ValueWrapper> terms) {
    return terms.length == 1;
  }
}
