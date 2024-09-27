import '../../../../quds_formula_parser.dart';

/// An abstract class for functions that take a single real number as input and return a real number as output.
///
/// This class serves as a base for mathematical functions that operate on a single real number,
/// such as trigonometric functions (sine, cosine, tangent) and others that need similar behavior.
///
/// It extends the [SingleParameterFunction] class, where the input and output types are both real numbers.
abstract class SingleRealNumberFunction
    extends SingleParameterFunction<num, num> {
  /// Creates a single real number function with the given notations, calculation method, and title.
  ///
  /// The `functionNotations` define the various names for the function (e.g., 'Sin', 'Cos').
  /// The `calculationMethod` defines the specific mathematical function to be applied (e.g., `sin`, `cos`).
  /// The `functionTitle` specifies the title of the function (e.g., 'Sine', 'Cosine').
  SingleRealNumberFunction(
      {required super.functionNotations,
      required super.calculationMethod,
      super.manipulateOutput});

  /// Calculates the result of applying the function to the given parameter.
  ///
  /// Takes a list of [ValueWrapper] parameters, where the first parameter is expected
  /// to be a real number. It applies the specified calculation method (e.g., `sin`, `cos`)
  /// and returns the result as a [RealNumberWrapper].
  @override
  dynamic calculate(List<ValueWrapper> parameters) {
    return calculationMethod(parameters.first.value);
  }

  /// Checks if the provided parameters are valid for the function.
  ///
  /// Validates that there is exactly one parameter.
  @override
  bool checkParameters(List<FormulaTerm> terms) {
    return terms.length == 1;
  }

  /// Returns the first function notation as the string representation to view.
  @override
  String get stringToView {
    return functionNotations.first;
  }
}
