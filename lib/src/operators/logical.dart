import 'package:quds_formula_parser/quds_formula_parser.dart';

class LogicalOperator extends Operator {
  final String symbol;

  LogicalOperator(this.symbol);

  @override
  calculate(ValueWrapper leftOperand, ValueWrapper rightOperand) {
    var a = leftOperand.value;
    var b = rightOperand.value;

    dynamic result;

    switch (symbol) {
      case '&':
      case '&&':
        result = _performAnd(a, b);
        break;
      case '|':
      case '||':
        result = _performOr(a, b);
        break;
    }

    return result ?? NAValue();
  }

  dynamic _performAnd(dynamic a, dynamic b) {
    return a && b;
  }

  dynamic _performOr(dynamic a, dynamic b) {
    return a || b;
  }

  /// Returns the string representation of the operator, which is the comparison symbol.
  @override
  String get stringToView => symbol;
}
