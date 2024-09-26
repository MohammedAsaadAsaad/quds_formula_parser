import '../../../quds_formula_parser.dart';

/// An abstract base class representing a bracket in a formula.
abstract class Bracket extends FormulaTerm {
  Bracket();
  // This class serves as a base for opening and closing brackets.
}

/// Represents an opening bracket in a formula.
class OpeningBracket extends Bracket {
  OpeningBracket();

  @override
  String get stringToView =>
      '('; // Returns the string representation of an opening bracket
}

/// Represents a closing bracket in a formula.
class ClosingBracket extends Bracket {
  ClosingBracket();

  @override
  String get stringToView =>
      ')'; // Returns the string representation of a closing bracket
}
