import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A wrapper class for the [Iterable] type used within the formula system.
///
/// This class extends [ValueWrapper] and provides support for handling iterable
/// values in formulas.
class IterableWrapper extends ValueWrapper<Iterable> {
  /// Creates an [IterableWrapper] that wraps an [Iterable] object.
  ///
  /// **Parameters**:
  /// - [value]: The [Iterable] object to be wrapped.
  IterableWrapper(super.value);

  /// Returns the type of the value as `'Iterable'`.
  @override
  String get valueType => 'Iterable';

  /// Returns a string representation of the iterable's elements.
  ///
  /// Each element in the iterable is converted to a string using its own
  /// `stringToView` method, and the entire iterable is represented as a list in string format.
  @override
  String get stringToView =>
      [for (var v in value) toFormulaValue(v).stringToView].toString();

  @override
  String get toTexNotation {
    String result = '[';
    for (var p in value) {
      result += '${toFormulaValue(p).toTexNotation},';
    }

    if (result.endsWith(',')) result = result.substring(result.length - 1, 1);

    result += ']';

    return result;
  }
}
