import 'package:quds_formula_parser/quds_formula_parser.dart';

/// Registers trigonometric functions with the provided formula provider.
///
/// This function defines and registers various trigonometric operations such as
/// sine, cosine, tangent, and their inverse functions. It also includes additional
/// trigonometric functions like secant, cosecant, and cotangent.
///
/// **Parameters**:
/// - [provider]: The `FormulaProvider` instance where the trigonometric functions are registered.
void registerTrigFunctions(FormulaProvider provider) {
  // Helper function to define single-parameter trigonometric functions.
  void defineMethod(
      List<String> notations, num Function(num v) calculationMethod,
      [dynamic Function(dynamic)? manipulateResult]) {
    provider.registerFunction(
        manipulateResult: manipulateResult,
        notations: notations,
        evaluator: (params) => calculationMethod(params.first),
        checkParameters: (params) => params.isSingle && params.first is num);
  }

  // Helper function to handle very small values and set them to 0 for precision.
  num declineTrivialValues(num d) => d.abs() < 1e-10 ? 0.0 : d;

  // Register trigonometric functions for sine, cosine, and tangent.
  defineMethod(['Sin', 'Sine', 'Math.Sin', 'Math.Sine'], sin,
      (v) => declineTrivialValues(v));
  defineMethod(['Cos', 'Cosine', 'Math.Cos', 'Math.Cosine'], cos,
      (v) => declineTrivialValues(v));
  defineMethod(['Tan', 'Tangent', 'Math.Tan', 'Math.Tangent'], tan,
      (v) => declineTrivialValues(v));

  // Register additional trigonometric functions like cotangent, secant, and cosecant.
  defineMethod(['Cot', 'Cotangent', 'Math.Cot', 'Math.Cotangent'],
      (v) => 1 / tan(v), (v) => declineTrivialValues(v));
  defineMethod(['Sec', 'Secant', 'Math.Sec', 'Math.Secant'], (v) => 1 / cos(v),
      (v) => declineTrivialValues(v));
  defineMethod(['Csc', 'Cosecant', 'Math.Csc', 'Math.Cosecant'],
      (v) => 1 / sin(v), (v) => declineTrivialValues(v));

  // Register inverse trigonometric functions for sine, cosine, and tangent.
  defineMethod(['ASin', 'Math.ASin'], asin);
  defineMethod(['ACos', 'Math.ACos'], acos);
  defineMethod(['ATan', 'Math.ATan'], atan);

  // Register the ATan2 function for calculating the arctangent of two parameters.
  provider.registerFunction(
      manipulateResult: (v) => declineTrivialValues(v),
      notations: ['ATan2'],
      evaluator: (params) => atan2(params.first, params.second),
      checkParameters: (params) =>
          params.isCouple && params.every((e) => e is num));
}
