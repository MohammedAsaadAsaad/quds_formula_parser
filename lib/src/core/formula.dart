import '../../quds_formula_parser.dart';

/// Represents a mathematical formula composed of various terms.
class Formula {
  List<FormulaTerm> terms = []; // The list of terms that make up the formula.
  final FormulaParser parser; // The parser used to interpret the formula.

  /// Constructs a [Formula] with the provided [parser].
  Formula({required this.parser});

  /// Calculates the result of the formula.
  ///
  /// Returns `null` if there is a parsing error.
  dynamic calculate() {
    if (errorParsingPosition != null) {
      return null; // Return null if there's a parsing error.
    }
    // Further calculation logic would go here.
  }

  int? errorParsingPosition; // The position of an error in parsing, if any.

  /// Checks if the formula has a parsing error.
  bool get hasParsingError => errorParsingPosition != null;
}
