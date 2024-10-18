import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A class representing the subtraction (`-`) operator in a formula.
///
/// This operator handles subtraction for different types of operands, including numbers and complex numbers.
class SubtractOperator extends Operator {
  /// Creates an instance of the `SubtractOperator`.
  SubtractOperator();

  /// Calculates the result of subtracting the right operand from the left operand.
  ///
  /// The method checks the types of the operands (`leftOperand` and `rightOperand`) and performs
  /// subtraction accordingly. Supported types include:
  /// - Numbers: subtracts two numbers.
  /// - Complex numbers: subtracts a number and a complex number, or two complex numbers.
  ///
  /// Returns the result wrapped in a [FormulaValue].
  @override
  calculate(ValueWrapper leftOperand, ValueWrapper rightOperand) {
    dynamic aValue = leftOperand.value;
    dynamic bValue = rightOperand.value;

    var a = aValue;
    var b = bValue;

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

  /// Performs subtraction between two numeric values.
  num _performNums(num a, num b) {
    return a - b;
  }

  /// Performs subtraction between two complex numbers.
  ComplexNumber _performComplices(ComplexNumber a, ComplexNumber b) {
    return a - b;
  }

  /// Performs subtraction of a complex number from a numeric value.
  ComplexNumber _performNumWithComplex(num a, ComplexNumber b) {
    return ComplexNumber(a - b.realPart, -b.imaginaryPart);
  }

  /// Performs subtraction of a numeric value from a complex number.
  ComplexNumber _performComplexWithNum(ComplexNumber a, num b) {
    return a - b;
  }

  Fraction _performFractions(Fraction a, Fraction b) {
    return a - b;
  }

  Fraction _performFractionWithReal(Fraction a, num b) {
    return a - b;
  }

  Fraction _performRealWithFraction(num a, Fraction b) {
    return Fraction.fromNum(a) * b;
  }

  /// Returns the string representation of the operator, which is `-`.
  @override
  String get stringToView => '-';

  @override
  String get toTexNotation => '-';
}
