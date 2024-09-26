import 'package:quds_formula_parser/quds_formula_parser.dart';

/// An abstract class representing functions that operate on strings.
///
/// This class serves as a base for string-related functions, such as string length,
/// concatenation, and various trimming or case-changing operations.
///
/// Functions that inherit from this class include:
/// - StringLength
/// - StringConcatFunction
/// - ToUpperFunction
/// - ToLowerFunction
/// - TrimFunction
/// - TrimLeftFunction
/// - TrimRightFunction
abstract class StringFunction extends FormulaFunction {
  StringFunction({required super.functionNotations});

  /// Generates a list of string-related functions.
  ///
  /// These functions include:
  /// - `StringLength`: Returns the length of a string.
  /// - `StringConcatFunction`: Concatenates multiple strings.
  /// - `ToUpperFunction`: Converts a string to uppercase.
  /// - `ToLowerFunction`: Converts a string to lowercase.
  /// - `TrimFunction`: Removes spaces from both sides of a string.
  /// - `TrimLeftFunction`: Removes spaces from the left side of a string.
  /// - `TrimRightFunction`: Removes spaces from the right side of a string.
  static List<StringFunction> generateFunctions() => [
        StringLength(),
        StringConcatFunction(),
        ToUpperFunction(),
        ToLowerFunction(),
        TrimFunction(),
        TrimLeftFunction(),
        TrimRightFunction(),
      ];
}
