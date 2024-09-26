import 'package:quds_formula_parser/quds_formula_parser.dart';

/// An abstract class that represents logical functions in formulas.
///
/// This class extends [FormulaFunction] and serves as a base class
/// for specific logical operations such as AND, OR, NOT, IF, and IFERROR.
abstract class LogicalFunction extends FormulaFunction<FormulaValue> {
  LogicalFunction({required super.functionNotations});

  /// Generates a list of logical functions.
  static List<FormulaFunction> generateFunctions() => [
        AndFunction(),
        IfErrorFunction(),
        IfFunction(),
        NotFunction(),
        OrFunction(),
      ];
}
