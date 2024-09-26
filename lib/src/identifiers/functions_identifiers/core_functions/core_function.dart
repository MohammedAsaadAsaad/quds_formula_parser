import 'package:quds_formula_parser/quds_formula_parser.dart';

/// An abstract class representing core functions in the formula processing system.
///
/// This class extends [FormulaFunction] and provides a mechanism to define
/// core functions that can be used in formulas. The static method
/// [generateFunctions] returns a list of commonly used core functions.
abstract class CoreFunction extends FormulaFunction {
  CoreFunction({required super.functionNotations});

  /// Generates a list of core functions available in the formula processing system.
  ///
  /// This method returns a list containing instances of core functions such as:
  /// - [TypeFunction]: Checks the type of a value.
  /// - [IsNumberFunction]: Checks if a value is a number.
  /// - [IsRealFunction]: Checks if a value is a real number.
  /// - [IsComplexFunction]: Checks if a value is a complex number.
  /// - [IsTextFunction]: Checks if a value is text.
  /// - [IsNAFunction]: Checks if a value is a 'Not Available' value.
  /// - [IsNullFunction]: Checks if a value is null.
  static List<CoreFunction> generateFunctions(FormulaProvider provider) => [
        TypeFunction(),
        IsNumberFunction(),
        IsRealFunction(),
        IsComplexFunction(),
        IsTextFunction(),
        IsNAFunction(),
        IsNullFunction(),
        SetVariable(provider),
      ];
}
