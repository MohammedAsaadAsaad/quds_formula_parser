import 'package:quds_formula_parser/quds_formula_parser.dart';

class Fraction {
  final int numerator;
  final int denominator;

  // Constructor for creating a fraction, with simplification.
  Fraction(int num, int den)
      : assert(den != 0, 'Denominator cannot be zero'),
        numerator = num ~/ gcd(num, den),
        denominator = den ~/ gcd(num, den);

  // Named constructor for creating from an integer
  Fraction.fromInteger(int value) : this(value, 1);

  // Named constructor for creating from a num
  factory Fraction.fromNum(num value) => value is int
      ? Fraction.fromInteger(value)
      : Fraction.fromDouble(value.toDouble());

  // Named constructor for creating from a decimal
  factory Fraction.fromDouble(double value) {
    const precision = 1000000; // Customize precision as needed
    final scaledValue = (value * precision).round();
    return Fraction(scaledValue, precision).simplify();
  }

  // Getters for important properties
  double get toDouble => numerator / denominator;
  bool get isWhole => denominator == 1;
  bool get isProper => numerator.abs() < denominator.abs();

  // Addition operator with Fractions and numbers
  Fraction operator +(dynamic other) {
    if (other is Fraction) {
      final newNum =
          numerator * other.denominator + other.numerator * denominator;
      final newDen = denominator * other.denominator;
      return Fraction(newNum, newDen).simplify();
    } else if (other is int) {
      return this + Fraction.fromInteger(other);
    } else if (other is double) {
      return this + Fraction.fromDouble(other);
    } else {
      throw ArgumentError('Unsupported operand type: ${other.runtimeType}');
    }
  }

  // Subtraction operator with Fractions and numbers
  Fraction operator -(dynamic other) {
    if (other is Fraction) {
      final newNum =
          numerator * other.denominator - other.numerator * denominator;
      final newDen = denominator * other.denominator;
      return Fraction(newNum, newDen).simplify();
    } else if (other is int) {
      return this - Fraction.fromInteger(other);
    } else if (other is double) {
      return this - Fraction.fromDouble(other);
    } else {
      throw ArgumentError('Unsupported operand type: ${other.runtimeType}');
    }
  }

  // Multiplication operator with Fractions and numbers
  Fraction operator *(dynamic other) {
    if (other is Fraction) {
      return Fraction(
              numerator * other.numerator, denominator * other.denominator)
          .simplify();
    } else if (other is int) {
      return this * Fraction.fromInteger(other);
    } else if (other is double) {
      return this * Fraction.fromDouble(other);
    } else {
      throw ArgumentError('Unsupported operand type: ${other.runtimeType}');
    }
  }

  // Division operator with Fractions and numbers
  Fraction operator /(dynamic other) {
    if (other is Fraction) {
      return Fraction(
              numerator * other.denominator, denominator * other.numerator)
          .simplify();
    } else if (other is int) {
      return this / Fraction.fromInteger(other);
    } else if (other is double) {
      return this / Fraction.fromDouble(other);
    } else {
      throw ArgumentError('Unsupported operand type: ${other.runtimeType}');
    }
  }

  // Simplifies the fraction
  Fraction simplify() {
    final divisor = gcd(numerator, denominator);
    return Fraction(numerator ~/ divisor, denominator ~/ divisor);
  }

  // Negation (invert sign)
  Fraction operator -() {
    return Fraction(-numerator, denominator);
  }

  // Inverse (reciprocal)
  Fraction inverse() {
    return Fraction(denominator, numerator);
  }

  // Convert fraction to mixed number (whole part and fractional part)
  String toMixedString() {
    final wholePart = numerator ~/ denominator;
    final fractionalPart = numerator % denominator;
    return wholePart != 0
        ? fractionalPart != 0
            ? '$wholePart ${fractionalPart.abs()}/$denominator'
            : '$wholePart'
        : '$numerator/$denominator';
  }

  // Comparison operators
  @override
  bool operator ==(Object other) =>
      other is Fraction &&
      numerator * other.denominator == other.numerator * denominator;
  bool operator <(Fraction other) =>
      numerator * other.denominator < other.numerator * denominator;
  bool operator >(Fraction other) =>
      numerator * other.denominator > other.numerator * denominator;

  @override
  int get hashCode => numerator.hashCode ^ denominator.hashCode;

  // String representation for printing
  @override
  String toString() =>
      denominator == 1 ? '$numerator' : '$numerator/$denominator';
}

class FractionWrapper extends ValueWrapper<Fraction> {
  FractionWrapper(super.value);

  @override
  String get valueType => 'Fraction';

  @override
  String get stringToView => 'f(${value.numerator}/${value.denominator})';

  @override
  String get toTexNotation =>
      '\\frac{${value.numerator}}{${value.denominator}}';
}
