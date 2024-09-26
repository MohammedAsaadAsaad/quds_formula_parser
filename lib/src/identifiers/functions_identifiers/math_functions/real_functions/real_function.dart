import 'package:quds_formula_parser/quds_formula_parser.dart';

/// An abstract class representing functions that operate on real numbers.
///
/// This class serves as a base for real number functions such as absolute value,
/// modulus, rounding, power, square root, logarithm, and exponentiation.
///
/// Functions that inherit from this class include:
/// - AbsFunction
/// - ModFunction
/// - RoundFunction
/// - IntFunction
/// - PowerFunction
/// - SqRtFunction
/// - LogFunction
/// - ExpFunction
abstract class RealFunction extends FormulaFunction {
  RealFunction({required super.functionNotations});

  /// Generates a list of real number functions.
  ///
  /// These functions include:
  /// - `AbsFunction`: Returns the absolute value of a number.
  /// - `ModFunction`: Returns the remainder of a division.
  /// - `RoundFunction`: Rounds a number to the nearest integer or specified decimal place.
  /// - `IntFunction`: Converts a number to an integer.
  /// - `PowerFunction`: Raises a number to a specified power.
  /// - `SqRtFunction`: Calculates the square root of a number.
  /// - `LogFunction`: Computes the logarithm of a number with an optional base.
  /// - `ExpFunction`: Calculates `e` raised to the power of a number.
  static List<RealFunction> generateFunctions() => [
        AbsFunction(),
        ModFunction(),
        RoundFunction(),
        IntFunction(),
        PowerFunction(),
        SqRtFunction(),
        LogFunction(),
        ExpFunction(),
      ];
}
