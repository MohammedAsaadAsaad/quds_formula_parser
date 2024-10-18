import '../../quds_formula_parser.dart';

/// Represents a mathematical formula composed of various terms.
class Formula {
  List<FormulaTerm> terms = []; // The list of terms that make up the formula.
  final FormulaParser parser; // The parser used to interpret the formula.

  /// Constructs a [Formula] with the provided [parser].
  Formula({required this.parser});

  int? errorParsingPosition; // The position of an error in parsing, if any.
  FormulaErrorCode?
      errorCode; // The type of the error found during the parsing, if any.

  /// Checks if the formula has a parsing error.
  bool get hasParsingError => errorParsingPosition != null;

  String get formulaString {
    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < terms.length; i++) {
      var curr = terms[i];
      var isOperator = curr.isOperator;
      if (isOperator) buffer.write(' ');
      buffer.write(curr.stringToView);
      if (isOperator) buffer.write(' ');
    }

    return buffer.toString();
  }

  @override
  String toString() => formulaString.toString();
}
