import 'package:quds_formula_parser/quds_formula_parser.dart';

/// An abstract class representing core functions in the formula processing system.
///
/// This class extends [FormulaFunction] and provides a structure to define core
/// functions that are commonly used in formulas.
abstract class CoreFunction extends FormulaFunction {
  CoreFunction({required super.functionNotations});

  /// Generates a list of core functions available in the formula processing system.
  ///
  /// The following core functions are included:
  /// - [IsNAFunction]: A function to check if a value is a 'Not Available' (NA) value.
  /// - [IsNullFunction]: A function to check if a value is `null`.
  ///
  /// **Parameters**:
  /// - [provider]: The `FormulaProvider` to which the functions will be registered.
  ///
  /// **Returns**:
  /// - A list of core functions (`List<CoreFunction>`) that are available for use.
  static List<CoreFunction> generateFunctions(FormulaProvider provider) => [
        IsNAFunction(),
        IsNullFunction(),
      ];
}

/// Registers core functions with the provided formula provider.
///
/// This function defines several common core functions, such as checking if a
/// value is a number, complex number, date, time, or a point, and registers them
/// with the formula provider.
///
/// **Parameters**:
/// - [provider]: The `FormulaProvider` instance where the core functions are registered.
void registerCoreFunctions(FormulaProvider provider) {
  // Helper method to define a value-checking function.
  void defineValueChecker(
      List<String> notations, bool Function(dynamic v) checkerMethod) {
    provider.registerFunction(
        notations: notations,
        evaluator: (params) => checkerMethod(params.first),
        checkParameters: (params) => params.isSingle);
  }

  // Register functions to check if a value is a number, real, complex, or point.
  defineValueChecker(
      ['IsNumber', 'Type.IsNumber'], (v) => v is num || v is ComplexNumber);
  defineValueChecker(['IsReal', 'Type.IsReal'], (v) => v is num);
  defineValueChecker(
      ['IsComplex', 'Type.IsComplex'], (v) => v is ComplexNumber);
  defineValueChecker(
      ['IsPoint', 'Type.IsPoint'], (v) => v is Point2D || v is Point3D);

  // Register functions to check if a value is a 2D or 3D point.
  defineValueChecker(['IsPoint2D', 'Type.IsPoint2D'], (v) => v is Point2D);
  defineValueChecker(['IsPoint3D', 'Type.IsPoint3D'], (v) => v is Point3D);

  // Register functions to check if a value is a Date, Time, DateTime, or Duration.
  defineValueChecker(['IsDate', 'Type.IsDate'], (v) => v is Date);
  defineValueChecker(['IsTime', 'Type.IsTime'], (v) => v is Time);
  defineValueChecker(
      ['IsDateTime', 'Type.IsDateTime'], (v) => v is QudsDateTime);
  defineValueChecker(['IsDuration', 'Type.IsDuration'], (v) => v is Duration);

  // Register functions to check if a value is Boolean, Fraction, Atom, or String.
  defineValueChecker(['IsBool', 'Type.IsBool', 'IsBoolean', 'Type.IsBoolean'],
      (v) => v is bool);
  defineValueChecker(['IsFraction', 'Type.IsFraction'], (v) => v is Fraction);
  defineValueChecker(['IsAtom', 'Type.IsAtom'], (v) => v is Atom);
  defineValueChecker(['IsText', 'Type.IsText', 'IsString', 'Type.IsString'],
      (v) => v is String);

  // Register a function to determine the type of a value.
  provider.registerFunction(
      notations: ['Type', 'ValueType'],
      evaluator: (params) => toFormulaValue(params.first).valueType,
      checkParameters: (params) => params.isSingle);

  // Register a function to set a variable's value.
  provider.registerFunction(
      notations: ['SetVariable', 'Variable'],
      evaluator: (params) =>
          provider.setVariableValue(params.first, params.second),
      checkParameters: (params) => params.isCouple && params.first is String);
}
