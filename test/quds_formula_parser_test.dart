import 'package:quds_formula_parser/quds_formula_parser.dart';
import 'package:test/test.dart';

void main() {
  group('Parsing and evaluation', () {
    test('Parsing values', () {
      expect(_parseFormulaAndEvaluate('"Mohammed Asaad"'), "Mohammed Asaad");
      expect(_parseFormulaAndEvaluate('true'), true);
      expect(_parseFormulaAndEvaluate('false'), false);
      expect(_parseFormulaAndEvaluate('2.467e2'), 246.7);
      expect(_parseFormulaAndEvaluate('-5'), -5);
      expect(_parseFormulaAndEvaluate('7-9i'), ComplexNumber(7, -9));
      expect(_parseFormulaAndEvaluate("#1990-10-10#"), Date(1990, 10, 10));
      expect(_parseFormulaAndEvaluate("#13:5:04#"), Time(13, 5, 4));
      expect(_parseFormulaAndEvaluate("{5,-1}"), Point2D(5, -1));
      expect(_parseFormulaAndEvaluate("{5,-1,2}"), Point3D(5, -1, 2));
      expect(_parseFormulaAndEvaluate("'h"), Atom.fromSymbol('h'));
    });

    test('Evaluating formula output', () {
      expect(_parseFormulaAndEvaluate('9 * (7 - 5)'), 18);
      expect(_parseFormulaAndEvaluate('5 * 2-4i'), ComplexNumber(10, -20));
      expect(_parseFormulaAndEvaluate('Type(\'h) = "Atom"'), true);
      expect(_parseFormulaAndEvaluate('Len("Free Palestine")'), 14);
      expect(_parseFormulaAndEvaluate('5^Sin(0) + Min(5,8,-10,9)'), -9);
      expect(
          _parseFormulaAndEvaluate(
              'If(Len("Free Free Palestine")>10,"Big Text","Small Text")'),
          "Big Text");
      expect(_parseFormulaAndEvaluate('Day(Today()) > 2030'), false);
    });

    test('Setting variable with changing its value, with evaluating the output',
        () {
      FormulaParser parser = FormulaParser();
      parser.provider.insertVariable(Variable(symbol: 'x', value: 0));

      var formula = parser.parse("Sin(x/2)");
      var supporter = FormulaInfixToPostfixConvertor(formula: formula);
      for (double x = 0; x < 1000; x++) {
        parser.provider.setVariableValue('x', x);
        var result = supporter.evaluate().value;
        expect(result, sin(x / 2));
      }
    });
  });
}

dynamic _parseFormulaAndEvaluate(String str) {
  FormulaParser parser =
      FormulaParser(provider: FormulaProvider.defaultInstance);

  var formula = parser.parse(str);
  FormulaTermsCompleter(formula: formula);
  var supporter = FormulaInfixToPostfixConvertor(formula: formula);
  var result = supporter.evaluate();

  return result;
}
