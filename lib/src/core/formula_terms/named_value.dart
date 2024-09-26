import 'package:quds_formula_parser/quds_formula_parser.dart';

/// An abstract class that represents a named formula term with an associated value.
/// A `NamedValue` has a symbolic name (or identifier) and a corresponding value of type `FormulaValue`.
abstract class NamedValue extends FormulaTerm {
  /// The symbolic name or identifier for the named value.
  final String symbol;

  /// The actual value associated with the named value, which is of type `FormulaValue`.
  FormulaValue value;

  /// Constructs a `NamedValue` with a required `symbol` and an associated `value`.
  NamedValue({required this.symbol, required this.value});

  /// Returns the symbolic representation (`symbol`) of the named value for display purposes.
  @override
  String get stringToView => symbol;
}

/// A class representing a variable in a formula.
/// A `Variable` has a symbolic name and a value, which can be dynamically set or updated.
class Variable extends NamedValue {
  /// Constructs a `Variable` with a required `symbol` and an optional `value`.
  /// The `value` is converted to a `FormulaValue` using the `toFormulaValue` function.
  Variable({required super.symbol, dynamic value})
      : super(value: toFormulaValue(value));
}

/// A class representing a constant in a formula.
/// A `Constant` has a symbolic name and a fixed value that cannot change once set.
class Constant extends NamedValue {
  /// Constructs a `Constant` with a required `symbol` and a `value`.
  /// The `value` is converted to a `FormulaValue` using the `toFormulaValue` function.
  Constant({required super.symbol, dynamic value})
      : super(value: toFormulaValue(value));
}
