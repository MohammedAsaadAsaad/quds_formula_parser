import 'package:quds_formula_parser/quds_formula_parser.dart';

/// Represents a comma in a formula.
class Comma extends FormulaTerm {
  Comma();

  @override
  String get stringToView =>
      ','; // Returns the string representation of a comma

  @override
  String get toTexNotation => ',';
}
