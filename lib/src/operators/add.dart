import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A class representing the addition (`+`) operator in a formula.
///
/// This operator handles addition for different types of operands, including numbers,
/// complex numbers, strings, and 2D points. It performs the appropriate operation based
/// on the types of the left and right operands.
class AddOperator extends Operator {
  /// Creates an instance of the `AddOperator`.
  AddOperator();

  /// Calculates the result of adding two operands.
  ///
  /// The method checks the types of the operands (`leftOperand` and `rightOperand`) and performs
  /// addition accordingly. Supported types include:
  /// - Strings: concatenates the two strings.
  /// - Numbers: adds two numbers.
  /// - Complex numbers: adds a number and a complex number or two complex numbers.
  /// - 2D Points: adds two [Point2D] objects.
  ///
  /// Returns the result wrapped in a [FormulaValue].
  @override
  calculate(ValueWrapper leftOperand, ValueWrapper rightOperand) {
    dynamic aValue = leftOperand.value;
    dynamic bValue = rightOperand.value;

    var a = aValue;
    var b = bValue;

    dynamic result;

    if (a is String || b is String) {
      result = '$a$b';
    } else if (a is num && b is num) {
      result = _performNums(a, b);
    } else if (a is ComplexNumber && b is num) {
      result = _performComplexWithNum(a, b);
    } else if (a is ComplexNumber && b is ComplexNumber) {
      result = _performComplices(a, b);
    } else if (a is num && b is ComplexNumber) {
      result = _performNumWithComplex(a, b);
    } else if (a is Point2D && b is Point2D) {
      result = _perform2dPoints(a, b);
    } else if (a is Fraction && b is Fraction) {
      result = _performFractions(a, b);
    } else if (a is Fraction && b is num) {
      result = _performFractionWithReal(a, b);
    } else if (a is num && b is Fraction) {
      result = _performRealWithFraction(a, b);
    }

    return toFormulaValue(result);
  }

  /// Performs addition of two numeric values.
  num _performNums(num a, num b) {
    return a + b;
  }

  /// Performs addition of two complex numbers.
  ComplexNumber _performComplices(ComplexNumber a, ComplexNumber b) {
    return a + b;
  }

  /// Performs addition of a number and a complex number.
  ComplexNumber _performNumWithComplex(num a, ComplexNumber b) {
    return b + a;
  }

  /// Performs addition of a complex number and a numeric value.
  ComplexNumber _performComplexWithNum(ComplexNumber a, num b) {
    return a + b;
  }

  /// Performs addition of two 2D points.
  Point2D _perform2dPoints(Point2D a, Point2D b) {
    return a + b;
  }

  /// Performs addition of two fractions.
  Fraction _performFractions(Fraction a, Fraction b) {
    return a + b;
  }

  /// Performs addition of fraction with real number.
  Fraction _performFractionWithReal(Fraction a, num b) {
    return a + b;
  }

  /// Performs addition of fraction with real number.
  Fraction _performRealWithFraction(num a, Fraction b) {
    return b + a;
  }

  /// Returns the string representation of the operator, which is `+`.
  @override
  String get stringToView => '+';

  @override
  String get toTexNotation => '+';
}
