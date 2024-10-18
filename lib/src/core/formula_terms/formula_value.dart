import '../../../quds_formula_parser.dart';

/// Represents an "NA" (Not Available) value in a formula.
/// This is typically used to indicate missing or undefined data.
class NAValue extends ValueWrapper {
  /// Constructs an `NAValue` with a `null` value.
  NAValue() : super(null);

  /// Returns the string '#N/A' to indicate the "NA" value.
  @override
  String get stringToView => '#N/A';

  /// Returns the type of the value as `"NA"`.
  @override
  String get valueType => "NA";

  @override
  String get toTexNotation => '';
}

/// Represents a `null` value in a formula.
/// This is used to represent an explicitly `null` value.
class NullValue extends ValueWrapper {
  /// Constructs a `NullValue` with a `null` value.
  NullValue() : super(null);

  /// Returns the string 'NULL' to indicate the `null` value.
  @override
  String get stringToView => 'NULL';

  /// Returns the type of the value as `"Null"`.
  @override
  String get valueType => "Null";

  @override
  String get toTexNotation => '';
}

/// An abstract class that wraps a generic value of type `T` in a formula.
/// Subclasses of this class provide wrappers for different types of values
/// (e.g., numbers, dates, strings, etc.).
abstract class ValueWrapper<T> extends FormulaTerm {
  /// Constructs a `ValueWrapper` with the given value of type `T`.
  ValueWrapper(
    this.value,
  );

  /// The value that is wrapped by this class.
  final T value;

  /// Returns the string representation of the wrapped value for viewing purposes.
  @override
  String get stringToView => value.toString();

  /// Checks if the wrapped value is a real number.
  bool get isRealNumber => this is RealNumberWrapper;

  /// Checks if the wrapped value is a complex number.
  bool get isComplexNumber => this is ComplexNumberWrapper;

  /// Checks if the wrapped value is either a real or complex number.
  bool get isNumber => isRealNumber || isComplexNumber;

  /// Checks if the wrapped value is a date.
  bool get isDate => this is DateWrapper;

  /// Checks if the wrapped value is a time.
  bool get isTime => this is TimeWrapper;

  /// Checks if the wrapped value is a date-time.
  bool get isDateTime => this is QudsDateTimeWrapper;

  /// Checks if the wrapped value is a string.
  bool get isString => this is StringWrapper;

  /// Checks if the wrapped value is a point.
  bool get isPoint => this is Point2DWrapper || this is Point3DWrapper;

  /// Returns the type of the wrapped value as a string.
  String get valueType;
}
