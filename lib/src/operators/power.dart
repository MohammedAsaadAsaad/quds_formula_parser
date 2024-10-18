import 'package:quds_formula_parser/quds_formula_parser.dart';

class PowerOperator extends Operator {
  PowerOperator();

  @override
  calculate(ValueWrapper leftOperand, ValueWrapper rightOperand) {
    var a = leftOperand.value;
    var b = rightOperand.value;

    if (a is num && b is num) return pow(a, b);

    if (a is Fraction && b is num) {
      var v = a;
      var p = b;
      return Fraction.fromNum(pow(v.numerator, p) / pow(v.denominator, p));
    }

    if (a is bool && b is bool) return a ^ b;

    return NAValue();
  }

  /// Returns the string representation of the operator, which is `^`.
  @override
  String get stringToView => '^';

  @override
  String get toTexNotation => '^';
}
