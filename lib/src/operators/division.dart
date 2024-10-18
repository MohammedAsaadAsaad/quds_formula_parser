import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A class representing the division (`/`) operator in a formula.
///
/// This operator handles division for different types of operands, including numbers
/// and complex numbers. It performs the appropriate division based on the types of the operands.
class DivisionOperator extends Operator {
  /// Creates an instance of the `DivisionOperator`.
  DivisionOperator();

  /// Calculates the result of dividing two operands.
  ///
  /// The method checks the types of the operands (`leftOperand` and `rightOperand`) and performs
  /// division accordingly. Supported types include:
  /// - Numbers: divides two numbers.
  /// - Complex numbers: divides a complex number and a number, or two complex numbers.
  ///
  /// Returns the result wrapped in a [FormulaValue].
  @override
  calculate(ValueWrapper leftOperand, ValueWrapper rightOperand) {
    var a = leftOperand.value;
    var b = rightOperand.value;

    dynamic result;

    if (a is num && b is num) {
      result = _performNums(a, b);
    } else if (a is ComplexNumber && b is num) {
      result = _performComplexWithNum(a, b);
    } else if (a is ComplexNumber && b is ComplexNumber) {
      result = _performComplices(a, b);
    } else if (a is num && b is ComplexNumber) {
      result = _performNumWithComplex(a, b);
    } else if (a is Fraction && b is Fraction) {
      result = _performFractions(a, b);
    } else if (a is Fraction && b is num) {
      result = _performFractionWithReal(a, b);
    } else if (a is num && b is Fraction) {
      result = _performRealWithFraction(a, b);
    }

    return toFormulaValue(result);
  }

  /// Performs division between two numeric values.
  num _performNums(num a, num b) {
    return a / b;
  }

  /// Performs division between two complex numbers.
  ComplexNumber _performComplices(ComplexNumber a, ComplexNumber b) {
    return a / b;
  }

  /// Performs division of a number by a complex number.
  ComplexNumber _performNumWithComplex(num a, ComplexNumber b) {
    num realPart = b.realPart;
    num imagPart = b.imaginaryPart;
    num denominator = realPart * realPart + imagPart * imagPart;

    return ComplexNumber(
        a * realPart / denominator, -a * imagPart / denominator);
  }

  /// Performs division of a complex number by a numeric value.
  ComplexNumber _performComplexWithNum(ComplexNumber a, num b) {
    return a / b;
  }

  /// Performs division of two fractions.
  Fraction _performFractions(Fraction a, Fraction b) {
    return a / b;
  }

  /// Performs division of fraction with real number.
  Fraction _performFractionWithReal(Fraction a, num b) {
    return a / b;
  }

  /// Performs division of fraction with real number.
  Fraction _performRealWithFraction(num a, Fraction b) {
    return Fraction.fromNum(a) / b;
  }

  /// Returns the string representation of the operator, which is `/`.
  @override
  String get stringToView => '/';

  @override
  String get toTexNotation => '/';
}

/// A class representing the modulus (`%`) operator in a formula.
///
/// This operator handles the modulus operation between two numeric operands.
class ReminderOperator extends Operator {
  /// Creates an instance of the `ReminderOperator`.
  ReminderOperator();

  /// Calculates the remainder of dividing two numeric operands.
  ///
  /// The method checks if both operands are numeric and returns the modulus (`a % b`).
  /// If the operands are not numeric, it returns [NAValue].
  ///
  /// Returns the result wrapped in a [FormulaValue].
  @override
  calculate(ValueWrapper leftOperand, ValueWrapper rightOperand) {
    var a = leftOperand.value;
    var b = rightOperand.value;

    if (a is! num || b is! num) return NAValue();
    return toFormulaValue(a % b);
  }

  /// Returns the string representation of the operator, which is `%`.
  @override
  String get stringToView => '%';

  @override
  String get toTexNotation => '\\bmod';
}
