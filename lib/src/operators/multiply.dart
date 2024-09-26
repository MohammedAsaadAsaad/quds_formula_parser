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
    dynamic aValue = (leftOperand is RealNumberWrapper)
        ? leftOperand.value
        : (leftOperand is ComplexNumberWrapper)
            ? leftOperand.value
            : leftOperand;

    dynamic bValue = (rightOperand is RealNumberWrapper)
        ? rightOperand.value
        : (rightOperand is ComplexNumberWrapper)
            ? rightOperand.value
            : rightOperand;

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

  /// Returns the string representation of the operator, which is `*`.
  @override
  String get stringToView => '*';
}
