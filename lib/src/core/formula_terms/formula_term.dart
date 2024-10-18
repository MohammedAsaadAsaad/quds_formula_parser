import 'package:quds_formula_parser/quds_formula_parser.dart';

/// An abstract class representing a term in a formula.
///
/// A `FormulaTerm` models different components within a formula, such as
/// operators, values, functions, variables, and more. It provides utility
/// methods for identifying the type of term and casting between types.
///
/// This class is intended to be extended by specific term types like
/// operators or values in formula parsing and evaluation systems.
abstract class FormulaTerm {
  /// A constant constructor for any subclass that extends `FormulaTerm`.
  FormulaTerm();

  /// An optional field indicating the position of the term in the formula.
  int? position;

  /// Returns a string representation of the formula term for displaying purposes.
  String get stringToView;

  /// Converts the formula term to a string representation.
  ///
  /// This calls the [stringToView] getter to provide a readable representation
  /// of the term.
  @override
  String toString() {
    return stringToView;
  }

  /// Checks if the formula term is a comma.
  ///
  /// **Returns**:
  /// - `true` if the term is a [Comma], otherwise `false`.
  bool get isComma => this is Comma;

  /// Checks if the formula term is an operator.
  ///
  /// **Returns**:
  /// - `true` if the term is an [Operator], otherwise `false`.
  bool get isOperator => this is Operator;

  /// Checks if the formula term is a function.
  ///
  /// **Returns**:
  /// - `true` if the term is a [FormulaFunction], otherwise `false`.
  bool get isFunction => this is FormulaFunction;

  /// Checks if the formula term is a value.
  ///
  /// **Returns**:
  /// - `true` if the term is a [FormulaValue], otherwise `false`.
  bool get isValue => this is ValueWrapper;

  /// Checks if the formula term is a variable.
  ///
  /// **Returns**:
  /// - `true` if the term is a [NamedValue], otherwise `false`.
  bool get isNamedValue => this is NamedValue;

  /// Checks if the formula term is an opening bracket.
  ///
  /// **Returns**:
  /// - `true` if the term is an [OpeningBracket], otherwise `false`.
  bool get isOpeningBracket => this is OpeningBracket;

  /// Alias for [isOpeningBracket], checks if the term is a left bracket.
  ///
  /// **Returns**:
  /// - `true` if the term is a left bracket, otherwise `false`.
  bool get isLeftBracket => isOpeningBracket;

  /// Checks if the formula term is a closing bracket.
  ///
  /// **Returns**:
  /// - `true` if the term is a [ClosingBracket], otherwise `false`.
  bool get isClosingBracket => this is ClosingBracket;

  /// Checks if the formula term represents a `null` value.
  ///
  /// **Returns**:
  /// - `true` if the term is a [NullValue], otherwise `false`.
  bool get isNull => this is NullValue;

  /// Checks if the formula term represents an "NA" (Not Available) value.
  ///
  /// **Returns**:
  /// - `true` if the term is a [NAValue], otherwise `false`.
  bool get isNAValue => this is NAValue;

  /// Alias for [isClosingBracket], checks if the term is a right bracket.
  ///
  /// **Returns**:
  /// - `true` if the term is a right bracket, otherwise `false`.
  bool get isRightBracket => isClosingBracket;

  /// Attempts to cast the formula term to a [FormulaValue].
  ///
  /// **Returns**:
  /// - If the term is a [FormulaValue], it returns the value.
  /// - If the term is a [NamedValue], it returns the associated [FormulaValue].
  /// - Throws an exception if the term is not a valid value type.
  ValueWrapper toFormulaValueType() {
    if (this is ValueWrapper) {
      return this as ValueWrapper;
    }
    if (this is NamedValue) {
      return toFormulaValue((this as NamedValue).value);
    }
    throw Exception('Not a valid value type');
  }
}

/// Converts a dynamic value to a corresponding `ValueWrapper`.
///
/// This function takes a dynamic input and wraps it into a compatible
/// wrapper type for formula parsing. Supports types such as `String`,
/// `bool`, `num`, `Date`, `Time`, and various other specialized types.
///
/// **Supported types**:
/// - `null`: Converted to [NullValue].
/// - `ValueWrapper`: Returned as-is.
/// - `String`: Wrapped in [StringWrapper].
/// - `bool`: Wrapped in [BooleanWrapper].
/// - `num` (e.g., `int`, `double`): Wrapped in [RealNumberWrapper].
/// - `ComplexNumber`: Wrapped in [ComplexNumberWrapper].
/// - `Atom`: Wrapped in [AtomWrapper].
/// - `Point2D`: Wrapped in [Point2DWrapper].
/// - `Point3D`: Wrapped in [Point3DWrapper].
/// - `Date`: Wrapped in [DateWrapper].
/// - `Time`: Wrapped in [TimeWrapper].
/// - `QudsDateTime`: Wrapped in [QudsDateTimeWrapper].
/// - `Iterable`: Wrapped in [IterableWrapper].
///
/// **Returns**:
/// - A `ValueWrapper` type that encapsulates the original value.
ValueWrapper toFormulaValue(dynamic v) {
  // Return a NullValue wrapper if the input is null.
  if (v == null) return NullValue();

  // If the input is already a ValueWrapper, return it as is.
  if (v is ValueWrapper) return v;

  // If the input is a String, wrap it in a StringWrapper.
  if (v is String) return StringWrapper(v);

  // If the input is a boolean, wrap it in a BooleanWrapper.
  if (v is bool) return BooleanWrapper(v);

  // If the input is a numeric value (int or double), wrap it in a RealNumberWrapper.
  if (v is num) return RealNumberWrapper(v);

  // If the input is a ComplexNumber, wrap it in a ComplexNumberWrapper.
  if (v is ComplexNumber) return ComplexNumberWrapper(v);

  // If the input is an Atom, wrap it in an AtomWrapper.
  if (v is Atom) return AtomWrapper(v);

  // If the input is a Point2D, wrap it in a Point2DWrapper.
  if (v is Point2D) return Point2DWrapper(v);

  // If the input is a Point3D, wrap it in a Point3DWrapper.
  if (v is Point3D) return Point3DWrapper(v);

  // If the input is a Date, wrap it in a DateWrapper.
  if (v is Date) return DateWrapper(v);

  // If the input is a Time, wrap it in a TimeWrapper.
  if (v is Time) return TimeWrapper(v);

  // If the input is a QudsDateTime, wrap it in a QudsDateTimeWrapper.
  if (v is QudsDateTime) return QudsDateTimeWrapper(v);

  // If input is iterable, wrap it in an IterableWrapper.
  if (v is Iterable) return IterableWrapper(v.toList());

  // Return the input unchanged if it doesn't match any of the types.
  return v;
}
