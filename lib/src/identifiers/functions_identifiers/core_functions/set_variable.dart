import 'package:quds_formula_parser/quds_formula_parser.dart';

class SetVariable extends CoreFunction {
  SetVariable(this.provider) : super(functionNotations: ['SetVariable']);

  final FormulaProvider provider;

  @override
  calculate(List<ValueWrapper> parameters) {
    var symbol = parameters.first.value;
    var value = parameters[1].value;

    provider.setVariableValue(symbol, value);
    return true;
  }

  @override
  bool checkParameters(List<ValueWrapper> terms) {
    return terms.length == 2 && terms[0].isString;
  }
}
