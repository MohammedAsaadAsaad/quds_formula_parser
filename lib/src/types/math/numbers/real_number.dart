import '../../../../quds_formula_parser.dart';

/// A wrapper class for a real number, extending the ValueWrapper class.
class RealNumberWrapper extends ValueWrapper<num> {
  RealNumberWrapper(super.value);

  /// Returns the type of value wrapped, which is 'Real'.
  @override
  String get valueType => 'Real';
}
