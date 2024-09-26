import '../../../../quds_formula_parser.dart';

/// Represents a complex number with a real and imaginary part.
class ComplexNumber {
  final num realPart; // The real part of the complex number.
  final num imaginaryPart; // The imaginary part of the complex number.

  const ComplexNumber(this.realPart, this.imaginaryPart);

  /// Creates a complex number from a real part, with an imaginary part of 0.
  factory ComplexNumber.fromReal(num realPart) => ComplexNumber(realPart, 0.0);

  /// Creates a complex number from an imaginary part, with a real part of 0.
  factory ComplexNumber.fromImaginary(num imaginaryPart) =>
      ComplexNumber(0.0, imaginaryPart);

  static const ComplexNumber i =
      ComplexNumber(0.0, 1.0); // Represents the imaginary unit.
  static const ComplexNumber nan =
      ComplexNumber(double.nan, double.nan); // Represents NaN complex number.
  static const ComplexNumber complexInfinity = ComplexNumber(
      double.infinity, double.infinity); // Represents complex infinity.

  static const ComplexNumber infinity =
      ComplexNumber(double.infinity, 0.0); // Represents infinity in real part.
  static const ComplexNumber negativeInfinity = ComplexNumber(
      double.negativeInfinity,
      0.0); // Represents negative infinity in real part.

  /// Checks if the complex number is a real number.
  bool get isReal => imaginaryPart == 0.0;

  /// Calculates the absolute value (magnitude) of the complex number.
  num get absasReal => isReal
      ? realPart.abs()
      : sqrt((realPart * realPart) + (imaginaryPart * imaginaryPart));

  /// Returns the absolute value as a complex number (real part only).
  ComplexNumber get abs => ComplexNumber.fromReal(absasReal);

  /// Returns the argument (angle) of the complex number as a complex number.
  ComplexNumber get argument => ComplexNumber.fromReal(argumentasReal);

  /// Calculates the argument (angle) of the complex number in radians.
  double get argumentasReal {
    if (isReal) return realPart >= 0.0 ? 0.0 : pi;
    if (realPart == 0.0) {
      return imaginaryPart > 0.0 ? pi / 2.0 : -pi / 2.0;
    }

    bool flag = realPart < 0.0;
    bool flag2 = imaginaryPart < 0.0;
    double result = atan(imaginaryPart.abs() / realPart.abs());

    if (!flag && !flag2) return result;
    if (flag && !flag2) return (3.1415926535897931 - result);
    if (flag && flag2) return (result - 3.1415926535897931);
    return -result;
  }

  /// Checks if the complex number is NaN (Not a Number).
  bool get isNan {
    if (!realPart.isNaN) return imaginaryPart.isNaN;
    return true;
  }

  /// Checks if the complex number is infinite.
  bool get isInfinity {
    if (!realPart.isInfinite) return imaginaryPart.isInfinite;
    return true;
  }

  @override
  bool operator ==(Object other) {
    if (other is ComplexNumber) {
      return realPart == other.realPart && imaginaryPart == other.imaginaryPart;
    }
    if (other is num) {
      return imaginaryPart == 0.0 && realPart == other;
    }
    return false;
  }

  @override
  int get hashCode => realPart.hashCode ^ imaginaryPart.hashCode;

  /// Adds another complex number or real number to this complex number.
  ComplexNumber operator +(Object other) {
    num real = realPart;
    num img = imaginaryPart;
    if (other is num) return ComplexNumber(realPart + other, imaginaryPart);
    if (other is ComplexNumber) {
      return ComplexNumber(real + other.realPart, img + other.imaginaryPart);
    }
    throw Exception('Other must be real/complex number');
  }

  /// Subtracts another complex number or real number from this complex number.
  ComplexNumber operator -(Object other) {
    num real = realPart;
    num img = imaginaryPart;
    if (other is num) return ComplexNumber(realPart - other, imaginaryPart);
    if (other is ComplexNumber) {
      return ComplexNumber(real - other.realPart, img - other.imaginaryPart);
    }
    throw Exception('Other must be real/complex number');
  }

  /// Multiplies this complex number by another complex number or real number.
  ComplexNumber operator *(Object other) {
    num a = realPart;
    num b = imaginaryPart;
    if (other is num) {
      return ComplexNumber(realPart * other, imaginaryPart * other);
    }
    if (other is ComplexNumber) {
      var c = other.realPart;
      var d = other.imaginaryPart;
      return ComplexNumber(a * c - b * d, a * d + b * c);
    }
    throw Exception('Other must be real/complex number');
  }

  /// Divides this complex number by another complex number or real number.
  ComplexNumber operator /(Object other) {
    num a = realPart;
    num b = imaginaryPart;
    if (other is num) {
      return ComplexNumber(realPart / other, imaginaryPart / other);
    }
    if (other is ComplexNumber) {
      var c = other.realPart;
      var d = other.imaginaryPart;
      var denominator = a * a + b * b;
      return ComplexNumber(
          (c * a + b * d) / denominator, (a * d - c * b) / denominator);
    }
    throw Exception('Other must be real/complex number');
  }

  @override
  String toString() {
    if (isReal) return realPart.toString();
    if (realPart == 0.0) return '${imaginaryPart}i';
    return '$realPart + ${imaginaryPart}i';
  }
}

/// Wrapper class for ComplexNumber, providing additional features.
class ComplexNumberWrapper extends ValueWrapper<ComplexNumber> {
  ComplexNumberWrapper(super.value);

  @override
  String get valueType => 'Complex';
}
