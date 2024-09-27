/// Quds Formula Parser is a powerful Dart package designed to parse, evaluate, and manipulate mathematical formulas in various forms. It supports diverse data types, including numbers, dates, and custom objects, offering a flexible solution for formula-based calculations.
///
/// For example:
/// ```dart
/// import  'package:quds_formula_parser/quds_formula_parser.dart';
///
/// void  main() {
/// FormulaParser  parser  =  FormulaParser(provider:  FormulaProvider.defaultInstance);
/// var  formula  =  parser.parse('(0.5)^Sin(pi/2)');
/// var  supporter  =  FormulaInfixToPostfixConvertor(formula:  formula);
/// var  result  =  supporter.evaluate();
/// print(result.value);
/// }
/// ```

library;

//Internal
export 'src/utilities/utilities.dart';
export 'src/core/core.dart';
export 'src/types/types.dart';
export 'src/identifiers/identifiers.dart';
export 'src/formula_supporters/formula_supporters.dart';
export 'src/operators/operators.dart';
export 'src/calculations/calculations.dart';

// External
export 'dart:math';
