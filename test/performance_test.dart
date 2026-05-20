import 'package:quds_formula_parser/quds_formula_parser.dart';
import 'package:test/test.dart';

void main() {
  group('Performance Tests', () {
    /// Benchmark 1: Parse many simple formulas
    /// Tests the string parsing optimization improvements
    test('Parse 100000 simple formulas', () {
      FormulaParser parser = FormulaParser();
      
      Stopwatch sw = Stopwatch()..start();
      for (int i = 0; i < 100000; i++) {
        var result = parser.parse('x + 2');
        expect(result.hasParsingError, false);
      }
      sw.stop();
      
      print('✓ Parsed 100,000 simple formulas in ${sw.elapsedMilliseconds}ms');
      expect(sw.elapsedMilliseconds, lessThan(5000), 
        reason: 'Parse performance regression: should complete in < 5 seconds');
    });

    /// Benchmark 2: Parse complex nested formulas
    /// Tests identifier lookup and pattern matching optimization
    test('Parse 10000 complex nested formulas', () {
      FormulaParser parser = FormulaParser();
      
      Stopwatch sw = Stopwatch()..start();
      for (int i = 0; i < 10000; i++) {
        var result = parser.parse('((x + 2) * (y - 3)) / (z ^ 2 + 1)');
        expect(result.hasParsingError, false);
      }
      sw.stop();
      
      print('✓ Parsed 10,000 complex nested formulas in ${sw.elapsedMilliseconds}ms');
      expect(sw.elapsedMilliseconds, lessThan(10000),
        reason: 'Parse performance regression: should complete in < 10 seconds');
    });

    /// Benchmark 3: Evaluate same formula 1M times
    /// Tests stack pre-allocation and evaluation optimization
    test('Evaluate formula 1000000 times', () {
      FormulaParser parser = FormulaParser();
      parser.setVariables({'x': 0});
      parser.parse('x * 2 + 5');
      
      Stopwatch sw = Stopwatch()..start();
      for (int i = 0; i < 1000000; i++) {
        parser.setVariables({'x': i});
        var result = parser.evaluate();
        expect(result.value, i * 2 + 5);
      }
      sw.stop();
      
      print('✓ Evaluated formula 1,000,000 times in ${sw.elapsedMilliseconds}ms');
      expect(sw.elapsedMilliseconds, lessThan(10000),
        reason: 'Evaluation performance regression: should complete in < 10 seconds');
    });

    /// Benchmark 4: Function lookup with many functions
    /// Tests HashMap optimization for function identification
    test('Function lookup with 100 custom functions', () {
      FormulaProvider provider = FormulaProvider();
      
      // Register 100 custom functions
      for (int i = 0; i < 100; i++) {
        provider.registerFunction(
          notations: ['custom$i', 'c$i'],
          evaluator: (params) => (params.first as num) * i,
          checkParameters: (params) => params.length == 1 && params.first is num,
        );
      }
      
      FormulaParser parser = FormulaParser(provider: provider);
      
      Stopwatch sw = Stopwatch()..start();
      for (int i = 0; i < 10000; i++) {
        var result = parser.parse('custom50(5)');
        expect(result.hasParsingError, false);
      }
      sw.stop();
      
      print('✓ Parsed formulas with 100 functions 10,000 times in ${sw.elapsedMilliseconds}ms');
      expect(sw.elapsedMilliseconds, lessThan(5000),
        reason: 'Function lookup should be fast with HashMap optimization');
    });

    /// Benchmark 5: Mixed operations to simulate real-world usage
    test('Mixed operations benchmark', () {
      FormulaParser parser = FormulaParser();
      parser.setVariables({'x': 1, 'y': 2, 'z': 3});
      
      List<String> formulas = [
        'x + y',
        'sin(x) + cos(y)',
        '((x + y) * z) - 5',
        'sqrt(x ^ 2 + y ^ 2)',
        'if(x > y, x, y)',
      ];
      
      Stopwatch sw = Stopwatch()..start();
      for (int i = 0; i < 50000; i++) {
        for (var formula in formulas) {
          parser.parse(formula);
          parser.evaluate();
        }
      }
      sw.stop();
      
      print('✓ Completed 50,000 iterations of mixed operations in ${sw.elapsedMilliseconds}ms');
      expect(sw.elapsedMilliseconds, lessThan(15000),
        reason: 'Mixed operations should complete efficiently');
    });
  });

  group('Correctness Validation - Optimized', () {
    /// Verify that optimizations don't break existing functionality
    test('Simple arithmetic expressions maintain correctness', () {
      expect(_parseFormulaAndEvaluate('9 * (7 - 5)'), 18);
      expect(_parseFormulaAndEvaluate('5 + 3 * 2'), 11);
      expect(_parseFormulaAndEvaluate('(5 + 3) * 2'), 16);
    });

    test('Complex nested expressions maintain correctness', () {
      expect(_parseFormulaAndEvaluate('((2 + 3) * (4 + 5)) - 10'), 35);
      expect(_parseFormulaAndEvaluate('sqrt(9) + sqrt(16)'), 7);
      expect(_parseFormulaAndEvaluate('sin(0) + cos(0)'), 1);
    });

    test('Function calls maintain correctness', () {
      expect(_parseFormulaAndEvaluate('Max(5, 10, 3)'), 10);
      expect(_parseFormulaAndEvaluate('Min(5, 10, 3)'), 3);
      expect(_parseFormulaAndEvaluate('Len("Hello")'), 5);
    });

    test('Variable evaluation maintains correctness', () {
      FormulaParser parser = FormulaParser();
      parser.setVariables({'x': 5});
      parser.parse('x * 2 + 3');
      expect(parser.evaluate().value, 13);
      
      parser.setVariables({'x': 10});
      expect(parser.evaluate().value, 23);
    });

    test('Complex formula simplification maintains correctness', () {
      expect(_parseAndSimplify('x + x'), '2 * x');
      expect(_parseAndSimplify('x * 1'), 'x');
      expect(_parseAndSimplify('x * 0'), '0');
      expect(_parseAndSimplify('2 * x + 3 * x'), '5 * x');
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
