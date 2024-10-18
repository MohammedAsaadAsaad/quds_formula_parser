import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A class representing the multiplication (`*`) operator in a formula.
///
/// This operator handles multiplication for different types of operands, including numbers
/// and complex numbers. It performs the appropriate multiplication based on the types of the operands.
class MultiplyOperator extends Operator {
  /// Creates an instance of the `MultiplyOperator`.
  MultiplyOperator();

  /// Calculates the result of multiplying two operands.
  ///
  /// The method checks the types of the operands (`leftOperand` and `rightOperand`) and performs
  /// multiplication accordingly. Supported types include:
  /// - Numbers: multiplies two numbers.
  /// - Complex numbers: multiplies a number and a complex number, or two complex numbers.
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

  /// Performs multiplication between two numeric values.
  num _performNums(num a, num b) {
    return a * b;
  }

  /// Performs multiplication between two complex numbers.
  ComplexNumber _performComplices(ComplexNumber a, ComplexNumber b) {
    return a * b;
  }

  /// Performs multiplication of a number and a complex number.
  ComplexNumber _performNumWithComplex(num a, ComplexNumber b) {
    return ComplexNumber(a * b.realPart, a * b.imaginaryPart);
  }

  /// Performs multiplication of a complex number and a numeric value.
  ComplexNumber _performComplexWithNum(ComplexNumber a, num b) {
    return a * b;
  }

  /// Performs multiply of two fractions.
  Fraction _performFractions(Fraction a, Fraction b) {
    return a * b;
  }

  /// Performs multiply of fraction with real number.
  Fraction _performFractionWithReal(Fraction a, num b) {
    return a * b;
  }

  /// Performs multiply of fraction with real number.
  Fraction _performRealWithFraction(num a, Fraction b) {
    return Fraction.fromNum(a) * b;
  }

  /// Returns the string representation of the operator, which is `*`.
  @override
  String get stringToView => '*';

  @override
  String get toTexNotation => '\\cdot';
}
