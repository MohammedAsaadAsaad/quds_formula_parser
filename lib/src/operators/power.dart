import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A class representing the exponentiation (`^`) operator in a formula.
///
/// This operator handles raising one number to the power of another, typically used with numeric operands.
class PowerOperator extends Operator {
  /// Creates an instance of the `PowerOperator`.
  PowerOperator();

  /// Calculates the result of raising the left operand to the power of the right operand.
  ///
  /// The method checks if both operands are numeric ([RealNumberWrapper]) and performs the power
  /// operation using the `pow()` function. If the operands are not numeric, it returns [NAValue].
  ///
  /// Returns the result wrapped in a [RealNumberWrapper] or [NAValue] if the operation is invalid.
  @override
  calculate(ValueWrapper leftOperand, ValueWrapper rightOperand) {
    var a = leftOperand;
    var b = rightOperand;

    if (a is RealNumberWrapper && b is RealNumberWrapper) {
      return RealNumberWrapper(pow(a.value, b.value));
    }

    return NAValue();
  }

  /// Returns the string representation of the operator, which is `^`.
  @override
  String get stringToView => '^';
}
