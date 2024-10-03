import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A class to identify and parse operators in a formula.
///
/// This class matches various mathematical and comparison operators, such as addition,
/// subtraction, multiplication, division, and comparison operators. It returns the corresponding
/// operator as a [FormulaTerm].
class OperatorsIdentifiers extends FormulaTermIdentifier {
  /// Parses the input string to match it with a known operator.
  ///
  /// Takes a string [str] representing an operator, and returns the corresponding operator
  /// as a [FormulaTerm]. The supported operators include:
  /// - `+`: Addition
  /// - `-`: Subtraction
  /// - `*`, `×`: Multiplication
  /// - `/`, `÷`: Division
  /// - `%`: Modulus (remainder)
  /// - `^`: Power (exponentiation)
  /// - `>`, `<`, `>=`, `<=`, `=`, `<>`: Comparison operators
  ///
  /// If no match is found, the method returns `null`.
  @override
  FormulaTerm? parse(String str) {
    switch (str) {
      case '^':
        return PowerOperator();
      case '+':
        return AddOperator();
      case '-':
        return SubtractOperator();
      case '*':
      case '×':
        return MultiplyOperator();
      case '%':
        return ReminderOperator();
      case '/':
      case '÷':
        return DivisionOperator();
      case '>':
      case '<':
      case '>=':
      case '<=':
      case '=':
      case '==':
      case '<>':
      case '!=':
        return CompareOperator(str);
      case '&':
      case '&&':
      case '|':
      case '||':
        return LogicalOperator(str);
    }
    return null;
  }

  /// Returns the regular expression pattern used to identify operators.
  ///
  /// The pattern matches common operators like `+`, `-`, `*`, `/`, `×`, `÷`, `^`, `<>`, `<=`, `>=`, `<`, `>`, `=`, `&`, `%`.
  @override
  String get pattern => r'\+|-|\*|\/|\×|\÷|\^|!=|<>|<=|>=|<|>|=|&|%';
}
