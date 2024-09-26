import 'package:quds_formula_parser/quds_formula_parser.dart';

class YearFunction extends DateTimeFunction {
  YearFunction() : super(functionNotations: ['Year']);

  @override
  calculate(List<ValueWrapper> parameters) {
    var p = parameters.first;
    var d = p is DateWrapper
        ? p.value
        : p is QudsDateTimeWrapper
            ? p.value.date
            : null;

    return d?.year ?? NAValue();
  }

  @override
  bool checkParameters(List<ValueWrapper> terms) {
    return terms.length == 1 && (terms.first.isDate || terms.first.isDateTime);
  }
}
