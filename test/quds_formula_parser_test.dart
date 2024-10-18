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

    test('Simplify formulas', () {
      expect(_parseAndSimplify('x + x'), '2 * x');
      expect(_parseAndSimplify('x * 1'), 'x');
      expect(_parseAndSimplify('1 * x'), 'x');
      expect(_parseAndSimplify('x * 0'), '0');
      expect(_parseAndSimplify('0 * x'), '0');
      expect(_parseAndSimplify('x + x + x'), '3 * x');
      expect(_parseAndSimplify('2 * x + 3 * x'), '5 * x');
      expect(_parseAndSimplify('x^2 + x^2'), '2 * x ^ 2');
      expect(_parseAndSimplify('2 * x^2 + 3 * x^2'), '5 * x ^ 2');
      expect(_parseAndSimplify('x * x'), 'x ^ 2');
      expect(_parseAndSimplify('x^4 + 2 * x^4'), '3 * x ^ 4');
      expect(_parseAndSimplify('5 * x^2 - 2 * x^2'), '3 * x ^ 2');
      expect(_parseAndSimplify('x^2 * x'), 'x ^ 3');
      expect(_parseAndSimplify('x^2 * x^2'), 'x ^ 4');
      expect(_parseAndSimplify('x^2 + x^3'), 'x ^ 2 + x ^ 3');
      expect(_parseAndSimplify('x^4 - x^2'), 'x ^ 4 - x ^ 2');
      expect(_parseAndSimplify('3 * x^2 + x^2 - 2 * x^2'), '2 * x ^ 2');
      expect(_parseAndSimplify('4 * x - x'), '3 * x');
      expect(_parseAndSimplify('x^3 - x^3'), '0');
      expect(_parseAndSimplify('x^4 * x'), 'x ^ 5');
      expect(_parseAndSimplify('Sin(x + x + x)'), 'Sin(3 * x)');
      expect(_parseAndSimplify('2 * x + x * 2'), '4 * x');
      expect(_parseAndSimplify('5 - 3 + 2'), '4');
      expect(_parseAndSimplify('(2 * x)^2'), '4 * x ^ 2');
      expect(_parseAndSimplify('Sin(2 * x + x) - Cos(3 * x)'),
          'Sin(3 * x) - Cos(3 * x)');
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
      parser.setVariables({'x': 0});
      parser.parse("Sin(x/2)");
      for (double x = 0; x < 1000; x++) {
        parser.setVariables({'x': x});
        var result = parser.evaluate().value;
        expect(result, sin(x / 2));
      }
    });
  });
}

dynamic _parseFormulaAndEvaluate(String str) {
  FormulaParser parser =
      FormulaParser(provider: FormulaProvider.defaultInstance);
  parser.parse(str);
  var result = parser.evaluate().value;

  return result;
}

String _parseAndSimplify(String formulaString) {
  FormulaParser parser = FormulaParser();
  parser.setVariables({'x': 0});
  return parser.parse(formulaString).formulaString;
}
