import '../../../../../quds_formula_parser.dart';

/// A function to calculate the sine of an angle.
///
/// This function calculates the sine of a given angle in radians.
///
/// Function notations:
/// - 'Sin'
/// - 'Sine'
/// - 'Math.Sin'
/// - 'Math.Sine'
class SinFunction extends TriangleFunctionSingleParameter {
  SinFunction()
      : super(
            calculationMethod: sin,
            functionNotations: ['Sin', 'Sine', 'Math.Sin', 'Math.Sine']);
}

/// A function to calculate the cosine of an angle.
///
/// This function calculates the cosine of a given angle in radians.
///
/// Function notations:
/// - 'Cos'
/// - 'Cosine'
/// - 'Math.Cos'
/// - 'Math.Cosine'
class CosFunction extends TriangleFunctionSingleParameter {
  CosFunction()
      : super(
            calculationMethod: cos,
            functionNotations: ['Cos', 'Cosine', 'Math.Cos', 'Math.Cosine']);
}

/// A function to calculate the tangent of an angle.
///
/// This function calculates the tangent of a given angle in radians.
///
/// Function notations:
/// - 'Tan'
/// - 'Tangent'
/// - 'Math.Tan'
/// - 'Math.Tangent'
class TanFunction extends TriangleFunctionSingleParameter {
  TanFunction()
      : super(
            calculationMethod: tan,
            functionNotations: ['Tan', 'Tangent', 'Math.Tan', 'Math.Tangent']);
}
