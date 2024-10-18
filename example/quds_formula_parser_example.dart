import 'package:quds_formula_parser/quds_formula_parser.dart';
import 'dart:io';

/// The main entry point for the program, demonstrating various formula evaluation scenarios.
void main() {
  _simplifyFormulas();

  _evaluateSimpleFormulas();

  _evaluatingWithVariables();

  _completePossibleMissingTerms();

  _dealingWithLists();

  _parseAndEvaluateWithCustomProvider();

  _changeVariableValueByFormula();

  _writeCustomFormula();
}

void _simplifyFormulas() {
  print('Simplifying formulas');
  List<String> testFormulas = [
    'x',
    'x + x',
    'x * 1',
    '1 * x',
    'x * 0',
    '0 * x',
    'x + x + x',
    '2 * x + 3 * x',
    'x^2 + x^2',
    '2 * x^2 + 3 * x^2',
    'x * x',
    'x^3 + x^3',
    'x^4 + 2 * x^4',
    '5 * x^2 - 2 * x^2',
    'x^2 * x',
    'x^2 * x^2',
    'x^2 + x^3',
    'x^4 - x^2',
    'x + x^2',
    '3 * x^2 + x^2 - 2 * x^2',
    'x + 2 * x - x',
    '4 * x - x',
    'x^3 - x^3',
    'x^4 * x',
    'x + x * 2',
    'x^2 - x^2',
    'x * x^2',
    'Sin(x + x)',
    'Sin(x + x + x)',
    '2 * x + 2 * x',
    '5 - 3 + 2',
    '(2 * x)^2',
    'x * (x + 2)',
    '5 ^ (x + 2)',
    'x^2 * 2 + 2 * x^2',
    'x^2 + 2 * x^2 + 3 * x^2',
    'x^4 - x^2 + x^4',
    'x^5 + 2 * x^5 - x^5',
    '2 * x^3 - x^3 + 3 * x^3',
    'Sin(2 * x + x) - Cos(3 * x)',
  ];

  // List<String> testFormulas = [
  //   'x ^ 4 + x ^ 4',
  //   '4 - 1',
  //   'x ^ (2*2)',
  //   'x ^ (2*2) + x ^ (6 - 2)',
  //   '5 ^ x^2 * 2',
  //   'x - 5 ^ x^2 * 2 * 2',
  //   '0.5*x^2 + 8*x^2',
  //   'Sin(8*x^3 - 1.5*x^3 + 2*x^3 - x^2)',
  //   'x - 5 * x^2 * 2',
  //   '5 * x - 5 * x ^2 + x^2*-9 - x*-9 + x - 0 * x',
  //   'Sin(x + x + 2*x^2 - 0.5*x^2)',
  //   '3 * x + x',
  //   'x + 3 * x',
  //   'x + x + x',
  //   '1 * x',
  //   'x * 1',
  //   'x + x',
  //   'x + 1.5 * x',
  //   'x * 1 + x',
  //   'x + x * 4',
  //   'Sin(x + x + x)',
  //   'Sin(x + 2 ) - Sin(x + x + x)',
  // ];
  var parser = FormulaParser();
  parser.setVariableValue('x', 0);
  parser.setVariableValue('y', 0);
  for (String formulaString in testFormulas) {
    print('Before: $formulaString');
    var result = parser.parse(formulaString);
    print('Result: ${result.formulaString}');
  }
}

/// Evaluates and prints simple formulas using the default formula provider.
void _evaluateSimpleFormulas() {
  print('\nEvaluating simple formulas');

  _parseFormulaAndEvaluate('5 + 9 / 2'); // 9.5

  _parseFormulaAndEvaluate('6 ^ 3'); // 216

  _parseFormulaAndEvaluate('true ^ false'); // True
  _parseFormulaAndEvaluate('true = false'); // False
  _parseFormulaAndEvaluate('true != false'); // True
  _parseFormulaAndEvaluate('(5 = 2) & ( 5 > 2)'); // False
  _parseFormulaAndEvaluate('(2.5 = 5/2) & ( 5 > 2)'); // True

  _parseFormulaAndEvaluate('f(555/-9)'); // 185/-3
  _parseFormulaAndEvaluate('Atom.weight(\'he)'); // 4.0026
  _parseFormulaAndEvaluate('Sin(π)'); // 0.0
  _parseFormulaAndEvaluate('5 - (2+7i)'); // 3.0 + -7.0i
  _parseFormulaAndEvaluate('Day(#2024-08-14#)'); // 14
  _parseFormulaAndEvaluate('WeekDay(#1990-10-10#)'); // 5 (Wednesday)
  _parseFormulaAndEvaluate('Year(Today())'); // 2024
  _parseFormulaAndEvaluate(
      'If(And(Year(Today())%4=0,Year(Today())%100<>0),"Leap year","Not leap year")'); // "Leap year" / "Not leap year"
  _parseFormulaAndEvaluate('Len(ToStr(15))'); // 2
  _parseFormulaAndEvaluate('Point.Y({5,-7})'); // -7
  _parseFormulaAndEvaluate('Point.Y(Point(5,-2))'); // -2
  _parseFormulaAndEvaluate('"Free" + " " + "Palestine"'); // "Free Palestine"

  _parseFormulaAndEvaluate('Intersect(Set(2,5,9),Set(5,7,2))'); // [2, 5]

  // Handling errors
  _parseFormulaAndEvaluate('4 + w5'); // Error (undefined term)
  _parseFormulaAndEvaluate('4 + '); // Error (missing right operand)
  _parseFormulaAndEvaluate('4 + ()'); // Error (empty brackets)
  _parseFormulaAndEvaluate('4 + (+)'); // Error (empty brackets)
  _parseFormulaAndEvaluate('sin 5pi - 2'); // #N/A
  _parseFormulaAndEvaluate(
      'sin((5pi))'); // sin(5pi) = 0.0 (removed the redundant brackets)
  _parseFormulaAndEvaluate('4 + * 5'); // Error (missing right operand)
  _parseFormulaAndEvaluate('*9'); // Error (missing left operand)
  _parseFormulaAndEvaluate('(4) + ((54)'); // Error (missing closing bracket)
  _parseFormulaAndEvaluate('(4) + ((54)))'); // Error (missing opening bracket)
}

/// Parses and evaluates a given formula string using the default formula provider.
///
/// **Parameters**:
/// - [str]: The formula string to be parsed and evaluated.
///
/// **Returns**:
/// - The evaluated result of the formula.
void _parseFormulaAndEvaluate(String str) {
  print('\n');
  FormulaParser parser = FormulaParser();
  var formula = parser.parse(str);
  if (formula.hasParsingError) {
    print('''Error of parsing: $str
Error in position: ${formula.errorParsingPosition},
Error details: ${formula.errorCode?.name}''');
  } else {
    var result = (parser..parse(str)).evaluate();
    print('$str => ${parser.formula!.formulaString}\n  => $result');
  }
}

/// Changes a variable's value by evaluating a formula string that sets the variable.
///
/// Demonstrates how to modify the value of a variable by parsing and evaluating a formula.
void _changeVariableValueByFormula() {
  print('\nSetting variable value by formula string');

  var provider = FormulaProvider.defaultInstance;
  FormulaParser parser = FormulaParser(provider: provider);
  String setterStr = 'SetVariable("y",8)';
  var setterFormula = parser.parse(setterStr);
  FormulaInfixToPostfixConvertor(formula: setterFormula).evaluate();

  String formulaStr = 'power(y,2)';
  var formula = parser.parse(formulaStr);
  var supporter = FormulaInfixToPostfixConvertor(formula: formula);
  print('$formulaStr = ${supporter.evaluate()}'); // 64
}

/// Evaluates a formula with a variable, changing the variable's value multiple times.
///
/// This demonstrates performance when evaluating the same formula repeatedly
/// with different variable values.
void _evaluatingWithVariables() {
  print('\nEvaluating formula with changing variable value many times');
  FormulaParser parser = FormulaParser();
  parser.insertVariable(NamedValue(symbol: 'x', value: 0));
  String formulaStr = 'power(x,2)';
  parser.parse(formulaStr);

  Stopwatch stopwatch = Stopwatch();
  stopwatch.start();
  int times = 1000000;
  for (int i = 0; i < times; i++) {
    parser.setVariableValue('x', i);
    parser.evaluate();
  }
  stopwatch.stop();
  print(
      '$formulaStr evaluating times($times) took ${stopwatch.elapsedMilliseconds} ms');
}

FormulaParser liveParser = FormulaParser();

/// Reads and evaluates a custom formula inputted by the user via the console.
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

  var formula = liveParser.parse(formulaString!);
  if (formula.errorParsingPosition == null) {
    stdout.writeln('Output: ${liveParser.evaluate()}');
  } else {
    stdout.writeln(
        'The formula has parsing error at the position: ${formula.errorParsingPosition}');
  }
  _writeCustomFormula();
}

/// Parses and evaluates formulas using a custom formula provider.
///
/// This function demonstrates how to use a custom formula provider
/// with user-defined functions for formula evaluation.
void _parseAndEvaluateWithCustomProvider() {
  print('\nParsing with evaluating with custom provider');

  // Prepare the terms provider
  FormulaProvider provider = FormulaProvider();
  provider.identifiers.addAll([
    BracketIdentifier(),
    NamedValuesIdentifier(provider: provider),
  ]);
  provider.registerFunction(
      notations: ['Randomize', 'Custom.Rnd'],
      checkParameters: (params) => params.length == 1 && params.first is num,
      evaluator: (params) {
        return params.first * Random().nextInt(100);
      });

  provider.registerFunction(
      notations: ['SinX'],
      checkParameters: (params) => params.length == 1 && params.first is num,
      evaluator: (params) {
        return sin(params.first);
      },
      manipulateResult: (r) =>
          r.abs() < 1e-6 ? 0.0 : r); // Ignore very small values

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

/// Completes missing terms in formulas and evaluates them.
///
/// This demonstrates handling incomplete formulas and ensuring proper formula completion and evaluation.
void _completePossibleMissingTerms() {
  FormulaParser parser = FormulaParser();
  parser.setVariableValue('x', 0);
  String formulaStr = 'x(-x + 5)';
  var formula = parser.parse(formulaStr);
  var supporter = FormulaInfixToPostfixConvertor(formula: formula);
  print('${formula.toString()} = ${supporter.evaluate()}');
}

void _dealingWithLists() {
  var parser = FormulaParser();
  parser
    ..parse(
        'SetVariable("lst",List("Saturday","Sunday","Monday","Tuesday","Wednesday","Thursday","Friday"))')
    ..evaluate();

  parser.parse('ElementAt(lst,WeekDay(Today()))');

  print('Today is : ${parser.evaluate()}');

  parser.parse('"Tuesday order is " + (IndexOf(lst,"Tuesday") + 1)');
  print(parser.evaluate());
}
