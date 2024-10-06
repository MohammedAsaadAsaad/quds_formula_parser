import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A wrapper class for a string, extending the ValueWrapper class.
class StringWrapper extends ValueWrapper<String> {
  StringWrapper(super.value);

  /// Returns the type of value wrapped, which is 'Text'.
  @override
  String get valueType => 'Text';

  @override
  String get stringToView => '"$value"';
}
