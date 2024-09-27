import 'package:quds_formula_parser/quds_formula_parser.dart';
import 'dart:io';

void main() {
  _evaluateSimpleFormulas();

  _evaluatingWithVariables();

  _completePossibleMissingTerms();

  _parseAndEvaluateWithCustomProvider();

  _changeVariableValueByFormula();

  _writeCustomFormula();
}

void _evaluateSimpleFormulas() {
  print('\nEvaluating simple formulas');

  print(_parseFormulaAndEvaluate('5 + 9 / 2')); // 9.5
  print(_parseFormulaAndEvaluate('Atom.weight(\'he)')); // 4.0026
  print(_parseFormulaAndEvaluate('Sin(π)')); // 0.0
  print(_parseFormulaAndEvaluate('5 - (2+7i)')); // 3.0 + -7.0i
  print(_parseFormulaAndEvaluate('Day(#2024-08-14#)')); // 14
  print(_parseFormulaAndEvaluate('Year(Today())')); // 2024
  print(_parseFormulaAndEvaluate(
      'If(And(Year(Today())%4=0,Year(Today())%100<>0),"Leap year","Not leap year")')); // Leap year / Not leap year
  print(_parseFormulaAndEvaluate('Point.Y({5,-7})')); // -7
  print(_parseFormulaAndEvaluate('Point.Y(Point(5,-2))')); // -2
}

dynamic _parseFormulaAndEvaluate(String str) {
  FormulaParser parser =
      FormulaParser(provider: FormulaProvider.defaultInstance);

  var formula = parser.parse(str);
  var supporter = FormulaInfixToPostfixConvertor(formula: formula);
  var result = supporter.evaluate();
  if (result is ValueWrapper) return result.value;
  return result;
}

void _changeVariableValueByFormula() {
  print('\nSetting variable value by formula string');

  var provider = FormulaProvider.defaultInstance;
  FormulaParser parser = FormulaParser(provider: provider);
  String setterStr = 'SetVariable("y",5)';
  var setterFormula = parser.parse(setterStr);
  FormulaInfixToPostfixConvertor(formula: setterFormula).evaluate();

  String formulaStr = 'power(5,2)';
  var formula = parser.parse(formulaStr);
  var supporter = FormulaInfixToPostfixConvertor(formula: formula);
  print('$formulaStr = ${supporter.evaluate()}');
}

void _evaluatingWithVariables() {
  print('\nEvaluating formula with changing variable value many times');
  var provider = FormulaProvider.defaultInstance;
  FormulaParser parser = FormulaParser(provider: provider);
  provider.insertVariable(Variable(symbol: 'x', value: 0));
  String formulaStr = 'power(x,2)';
  var formula = parser.parse(formulaStr);
  var supporter = FormulaInfixToPostfixConvertor(formula: formula);

  Stopwatch stopwatch = Stopwatch();
  stopwatch.start();
  int times = 1000000;
  for (int i = 0; i < times; i++) {
    provider.setVariableValue('x', i);
    supporter.evaluate();
  }
  stopwatch.stop();
  print(
      '$formulaStr evaluating times($times) took ${stopwatch.elapsedMilliseconds} ms');
}

void _writeCustomFormula() {
  bool cont = false;
  String? formulaString;
  while (!cont) {
    stdout.writeln('\nEnter your formula: ');
    formulaString = stdin.readLineSync();
    if (formulaString == null || formulaString.trim().isEmpty) {
      cont = false;
    } else {
      cont = true;
    }
  }
  FormulaParser parser =
      FormulaParser(provider: FormulaProvider.defaultInstance);

  var formula = parser.parse(formulaString!);
  if (formula.errorParsingPosition == null) {
    var supporter = FormulaInfixToPostfixConvertor(formula: formula);
    var result = supporter.evaluate();
    stdout.writeln('Output: $result');
  } else {
    stdout.writeln(
        'The formula has parsing error at the position: ${formula.errorParsingPosition}');
  }
  _writeCustomFormula();
}

void _parseAndEvaluateWithCustomProvider() {
  print('\nParsing with evaluating with custom provider');

  // Prepare the terms provider
  FormulaProvider provider = FormulaProvider();
  provider.identifiers.addAll([
    BracketIdentifier(),
    NamedValuesIdentifier(provider: provider),
    FunctionIdentifier(functions: [_CustomFunction()])
  ]);

  // Prepare the parser
  var parser = FormulaParser(provider: provider);
  provider.setVariableValue('x', 0);

  var formula = parser.parse('randomize(x)');

  var supporter = FormulaInfixToPostfixConvertor(formula: formula);
  for (int i = 0; i < 10; i++) {
    provider.setVariableValue('x', i);
    print(supporter.evaluate());
  }
}

class _CustomFunction extends FormulaFunction {
  _CustomFunction() : super(functionNotations: ['Custom.Rnd', 'Randomize']);

  @override
  calculate(List<ValueWrapper> parameters) {
    num arg = parameters.first.value;
    return arg * Random().nextInt(100);
  }

  @override
  bool checkParameters(List<ValueWrapper> terms) =>
      terms.length == 1 && terms.first.isRealNumber;
}

void _completePossibleMissingTerms() {
  FormulaParser parser = FormulaParser();
  parser.setVariableValue('x', 0);
  String formulaStr = 'x(-x + 5)';
  var formula = parser.parse(formulaStr);
  var supporter = FormulaInfixToPostfixConvertor(formula: formula);
  print('${formula.toString()} = ${supporter.evaluate()}');
}
