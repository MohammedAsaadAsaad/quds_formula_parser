import 'package:quds_formula_parser/quds_formula_parser.dart';

/// Registers statistical functions with the provided formula provider.
///
/// This function defines and registers a variety of statistical operations, such as
/// calculating averages, summations, products, minimum, maximum, variance, standard
/// deviation, and other statistical metrics.
///
/// **Parameters**:
/// - [provider]: The `FormulaProvider` instance where the statistical functions are registered.
void registerStatisticalFunctions(FormulaProvider provider) {
  var sumOperator = AddOperator();
  var multiOperator = AddOperator();

  // Helper function to define statistical functions that return a numerical result.
  void defineStatisticalFunction(List<String> notations,
      num Function(Iterable params) calculationMethods) {
    provider.registerFunction(
        notations: notations,
        evaluator: (params) => calculationMethods(params),
        checkParameters: (params) => params.isNotEmpty);
  }

  // Register functions for average, product, count, max, min, median, sum, variance, etc.
  defineStatisticalFunction(
      ['Avg', 'Stats.Avg', 'Average', 'Stats.Average', 'Mean', 'Stats.Mean'],
      (params) {
    var sum = params.reduce((a, b) => sumOperator.calculate(a, b));
    return DivisionOperator()
        .calculate(sum, toFormulaValue(params.length))
        .value;
  });

  defineStatisticalFunction(['Product'], (params) {
    return params.reduce((a, b) => multiOperator.calculate(a, b));
  });

  defineStatisticalFunction(['Count', 'Stats.Count'], (ps) => ps.length);

  defineStatisticalFunction(
      ['Max', 'Stats.Max'], (ps) => ps.map((e) => e as num).max()!);

  defineStatisticalFunction(
      ['Min', 'Stats.Min'], (ps) => ps.map((e) => e as num).min()!);

  defineStatisticalFunction(
      ['Median', 'Stats.Median'], (ps) => ps.map((e) => e as num).median()!);

  defineStatisticalFunction(['Sum', 'Stats.Sum', 'Summation'],
      (ps) => ps.reduce((a, b) => sumOperator.calculate(a, b))!);

  defineStatisticalFunction(['Var', 'Stats.Var', 'Variance'],
      (ps) => ps.map((e) => e as num).variance()!);

  defineStatisticalFunction(['StDev', 'Stats.StDev', 'Variance'],
      (ps) => ps.map((e) => e as num).standardDeviation()!);

  defineStatisticalFunction(
      ['Mode', 'Stats.Mode'], (ps) => ps.map((e) => e as num).mode()!);

  // Helper function to define statistical functions that return a list or iterable.
  void defineStatisticalFunctionWithListReturn(List<String> notations,
      Iterable Function(Iterable params) calculationMethods) {
    provider.registerFunction(
        notations: notations,
        evaluator: (params) => calculationMethods(params),
        checkParameters: (params) => params.isNotEmpty);
  }

  // Register a function to reverse a list of parameters.
  defineStatisticalFunctionWithListReturn(
      ['Reverse'], (params) => params.toList().reversed);

  // Helper function to define functions that operate on two integers.
  void defineFunctionOnCoupleOfIntegers(List<String> notations,
      dynamic Function(int a, int b) calculationMethod) {
    provider.registerFunction(
        notations: notations,
        evaluator: (params) => calculationMethod(params.first, params.second),
        checkParameters: (params) =>
            params.isCouple && params.every((e) => e is int));
  }

  // Register functions for permutations and combinations.
  defineFunctionOnCoupleOfIntegers(
      ['Permutations'], (n, r) => permutations(n, r));

  defineFunctionOnCoupleOfIntegers(
      ['Combinations'], (n, r) => combinations(n, r));
}
