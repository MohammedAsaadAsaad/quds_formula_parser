import 'package:quds_formula_parser/quds_formula_parser.dart';

/// Represents a base class for functions that operate on lists in formulas.
///
/// This abstract class defines the structure for list-related functions
/// and provides a method to generate a list of supported functions.
abstract class ListFunction extends FormulaFunction {
  ListFunction({required super.functionNotations});

  /// Generates a list of all list functions.
  ///
  /// This method returns a list containing instances of various
  /// list-related functions, including:
  /// - SumFunction
  /// - AverageFunction
  /// - ProductFunction
  /// - CountFunction
  /// - MaxFunction
  /// - MinFunction
  /// - MedianFunction
  /// - StandardDeviationFunction
  /// - VarianceFunction
  static List<ListFunction> generateFunctions() => [
        SumFunction(),
        AverageFunction(),
        ProductFunction(),
        CountFunction(),
        MaxFunction(),
        MinFunction(),
        MedianFunction(),
        StandardDeviationFunction(),
        VarianceFunction(),
      ];
}
