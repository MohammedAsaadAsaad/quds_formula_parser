import 'package:quds_formula_parser/quds_formula_parser.dart';

/// An abstract class representing a term in a formula. This can be used to model
/// various components like operators, values, functions, and variables within
/// a formula. It also provides various utility methods to identify the type
/// of the term.
abstract class FormulaTerm {
  /// A constant constructor for any subclass that extends `FormulaTerm`.
  FormulaTerm();

  int? position;

  /// Returns a string representation of the formula term for viewing purposes.
  String get stringToView;

  /// Converts the formula term to a string by calling the [stringToView] getter.
  @override
  String toString() {
    return stringToView;
  }

  /// Checks if the formula term is a comma.
  bool get isComma => this is Comma;

  /// Checks if the formula term is an operator.
  bool get isOperator => this is Operator;

  /// Checks if the formula term is a function.
  bool get isFunction => this is FormulaFunction;

  /// Checks if the formula term is a value.
  bool get isValue => this is FormulaValue;

  /// Checks if the formula term is a variable.
  bool get isVariable => this is Variable;

  /// Checks if the formula term is a constant.
  bool get isConstant => this is Constant;

  /// Checks if the formula term is an opening bracket.
  bool get isOpeningBracket => this is OpeningBracket;

  /// Alias for [isOpeningBracket], returns `true` if the term is a left bracket.
  bool get isLeftBracket => isOpeningBracket;

  /// Checks if the formula term is a closing bracket.
  bool get isClosingBracket => this is ClosingBracket;

  /// Checks if the formula term represents a `null` value.
  bool get isNull => this is NullValue;

  /// Checks if the formula term represents an "NA" (Not Available) value.
  bool get isNAValue => this is NAValue;

  /// Alias for [isClosingBracket], returns `true` if the term is a right bracket.
  bool get isRightBracket => isClosingBracket;

  /// Attempts to cast the formula term to a [FormulaValue] type. If the term is
  /// a named value, it returns the associated [FormulaValue]. Throws an exception
  /// if the term is not a valid value type.
  FormulaValue toFormulaValueType() {
    if (this is FormulaValue) {
      return this as FormulaValue;
    }
    if (this is NamedValue) {
      return (this as NamedValue).value;
    }
    throw Exception('Not valid value');
  }
}

/// Converts a given dynamic value into a corresponding `ValueWrapper` type.
/// This is useful for normalizing different types of values into a consistent
/// formula-compatible wrapper.
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

  // If the input is an Point2D, wrap it in a Point2DWrapper.
  if (v is Point2D) return Point2DWrapper(v);

  // If the input is an Point3D, wrap it in a Point2DWrapper.
  if (v is Point3D) return Point3DWrapper(v);

  // Return the input unchanged if it doesn't match any of the types.
  return v;
}
