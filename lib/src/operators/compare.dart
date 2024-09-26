import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A class representing comparison operators in a formula.
///
/// This operator handles various comparisons between two operands, including greater than, less than,
/// equal to, and not equal to. It supports comparison for numerical and other comparable types.
class CompareOperator extends Operator {
  /// The comparison symbol, such as `>`, `>=`, `<`, `<=`, `=`, or `<>`.
  final String symbol;

  /// Creates an instance of the `CompareOperator` with the given comparison symbol.
  CompareOperator(this.symbol);

  /// Calculates the result of comparing two operands.
  ///
  /// The method checks the comparison symbol and performs the corresponding operation:
  /// - `>`: Greater than
  /// - `>=`: Greater than or equal to
  /// - `<`: Less than
  /// - `<=`: Less than or equal to
  /// - `=`: Equal to
  /// - `<>`: Not equal to
  ///
  /// Returns a [BooleanWrapper] with the result of the comparison, or [NAValue] if the operands are invalid.
  @override
  calculate(ValueWrapper leftOperand, ValueWrapper rightOperand) {
    var a = leftOperand.value;
    var b = rightOperand.value;

    ValueWrapper? result;

    switch (symbol) {
      case '>':
        result = _performMore(a, b);
        break;
      case '>=':
        result = _performMoreOrEqual(a, b);
        break;
      case '<':
        result = _performLess(a, b);
        break;
      case '<=':
        result = _performLessOrEqual(a, b);
        break;
      case '=':
        result = _performEqual(a, b);
        break;
      case '<>':
        result = _performNotEqual(a, b);
        break;
    }

    return result ?? NAValue();
  }

  /// Performs a `>` (greater than) comparison for numeric values.
  ValueWrapper? _performMore(a, b) {
    if (a is num && b is num) return BooleanWrapper(a > b);
    return NAValue();
  }

  /// Performs a `>=` (greater than or equal to) comparison for numeric values.
  ValueWrapper? _performMoreOrEqual(a, b) {
    if (a is num && b is num) return BooleanWrapper(a >= b);
    return NAValue();
  }

  /// Performs a `<` (less than) comparison for numeric values.
  ValueWrapper? _performLess(a, b) {
    if (a is num && b is num) return BooleanWrapper(a < b);
    return NAValue();
  }

  /// Performs a `<=` (less than or equal to) comparison for numeric values.
  ValueWrapper? _performLessOrEqual(a, b) {
    if (a is num && b is num) return BooleanWrapper(a <= b);
    return NAValue();
  }

  /// Performs an `=` (equal to) comparison for any type of values.
  ValueWrapper? _performEqual(a, b) {
    return BooleanWrapper(a == b);
  }

  /// Performs a `<>` (not equal to) comparison for any type of values.
  ValueWrapper? _performNotEqual(a, b) {
    return BooleanWrapper(a != b);
  }

  /// Returns the string representation of the operator, which is the comparison symbol.
  @override
  String get stringToView => symbol;
}
