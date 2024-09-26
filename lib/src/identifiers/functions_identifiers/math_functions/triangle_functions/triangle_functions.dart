import 'package:quds_formula_parser/quds_formula_parser.dart';
export 'single_paramters.dart';

/// An abstract class representing trigonometric functions with a single real number parameter.
///
/// This class serves as a base for trigonometric functions such as sine, cosine, and tangent.
/// It takes a real number as input (an angle in radians) and applies the specified
/// trigonometric calculation method (e.g., `sin`, `cos`, `tan`).
///
/// Functions that inherit from this class include:
/// - SinFunction
/// - CosFunction
/// - TanFunction
abstract class TriangleFunctionSingleParameter
    extends SingleRealNumberFunction {
  /// Creates a trigonometric function with the given notations, calculation method, and title.
  ///
  /// The `functionNotations` define the various names for the function, such as 'Sin', 'Cos', etc.
  /// The `calculationMethod` defines the specific trigonometric function to be applied (e.g., `sin`).
  /// The `functionTitle` specifies the title of the function (e.g., 'Sine', 'Cosine').
  TriangleFunctionSingleParameter(
      {required super.functionNotations, required super.calculationMethod});

  /// Generates a list of trigonometric functions (sine, cosine, and tangent).
  ///
  /// These functions include:
  /// - `SinFunction`: Calculates the sine of an angle.
  /// - `CosFunction`: Calculates the cosine of an angle.
  /// - `TanFunction`: Calculates the tangent of an angle.
  static List<TriangleFunctionSingleParameter> generateFunctions() =>
      [SinFunction(), CosFunction(), TanFunction()];
}
