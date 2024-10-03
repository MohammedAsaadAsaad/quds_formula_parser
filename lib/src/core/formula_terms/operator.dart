import '../../../quds_formula_parser.dart';

/// An abstract class representing an operator in a formula.
/// Operators perform calculations between two operands, typically of type `ValueWrapper`.
abstract class Operator extends FormulaTerm {
  /// Constructs a generic operator.
  Operator();

  /// Performs the calculation based on the given left and right operands.
  /// Subclasses must implement this method to define specific operator behavior.
  calculate(ValueWrapper leftOperand, ValueWrapper rightOperand);

  /// Returns the precedence level of the operator.
  /// Higher values indicate higher precedence.
  /// The default precedence levels are:
  /// - PowerOperator: 3
  /// - MultiplyOperator, DivisionOperator, ReminderOperator: 2
  /// - AddOperator, SubtractOperator: 1
  int get precedence {
    if (this is PowerOperator) return 3;

    if (this is MultiplyOperator) return 2;
    if (this is DivisionOperator) return 2;
    if (this is ReminderOperator) return 2;

    if (this is AddOperator) return 1;
    if (this is SubtractOperator) return 1;
    return -1; // Default for unrecognized operators
  }

  /// Checks if the current operator has higher precedence than another operator.
  bool hasHigherPrecedence(Operator other) => precedence > other.precedence;

  /// Checks if the current operator has equal precedence with another operator.
  bool hasEqualPrecedence(Operator other) => precedence == other.precedence;

  /// Indicates if the operator is right associative (e.g., exponentiation).
  bool get isRightAssociative => this is PowerOperator;
}
