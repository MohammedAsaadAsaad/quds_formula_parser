import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A wrapper class for the [bool] type.
class BooleanWrapper extends ValueWrapper<bool> {
  /// Creates a [BooleanWrapper] that wraps a [bool] value.
  BooleanWrapper(super.value);

  /// Returns the string representation of the boolean value for viewing.
  @override
  String get stringToView => value ? 'True' : 'False';

  /// Returns the type of the value as `'Boolean'`.
  @override
  String get valueType => 'Boolean';

  @override
  String get toTexNotation => value ? 'True' : 'False';
}
