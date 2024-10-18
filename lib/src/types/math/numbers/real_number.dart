import '../../../../quds_formula_parser.dart';
import 'dart:math' as math;

/// A wrapper class for a real number, extending the ValueWrapper class.
class RealNumberWrapper extends ValueWrapper<num> {
  RealNumberWrapper(super.value);

  static final RealNumberWrapper zero = RealNumberWrapper(0);
  static final RealNumberWrapper one = RealNumberWrapper(1);

  /// Returns the type of value wrapped, which is 'Real'.
  @override
  String get valueType => 'Real';

  RealNumberWrapper operator +(RealNumberWrapper other) {
    return RealNumberWrapper(value + other.value);
  }

  RealNumberWrapper operator -(RealNumberWrapper other) {
    return RealNumberWrapper(value - other.value);
  }

  RealNumberWrapper operator *(RealNumberWrapper other) {
    return RealNumberWrapper(value * other.value);
  }

  RealNumberWrapper operator /(RealNumberWrapper other) {
    return RealNumberWrapper(value / other.value);
  }

  RealNumberWrapper operator %(RealNumberWrapper other) {
    return RealNumberWrapper(value % other.value);
  }

  RealNumberWrapper pow(num exponent) =>
      RealNumberWrapper(math.pow(exponent, exponent));

  @override
  String get toTexNotation => '$value';
}
