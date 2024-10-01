import '../../../../quds_formula_parser.dart';

/// Registers set-related functions with the provided formula provider.
///
/// This function defines and registers functions that operate on sets, such as
/// creating a set, performing union, intersection, and difference operations.
///
/// **Parameters**:
/// - [provider]: The `FormulaProvider` instance where the set functions are registered.
void registerSetsFunctions(FormulaProvider provider) {
  // Registers a function to create a set from the parameters.
  provider.registerFunction(
      notations: ['Set'], evaluator: (params) => params.toSet());

  // Defines and registers a set-related function that operates on two sets.
  void defineTwoSetsFunction(List<String> notations,
      Function(Iterable set1, Iterable set2) calculationsMethod) {
    provider.registerFunction(
        notations: notations,
        evaluator: (params) => calculationsMethod(params.first, params.second),
        checkParameters: (params) =>
            params.isCouple &&
            params.first is Iterable &&
            params.second is Iterable);
  }

  // Registers a function to perform the union of two sets.
  defineTwoSetsFunction(
      ['Union', 'Sets.Union'], (a, b) => a.toSet().union(b.toSet()));

  // Registers a function to perform the intersection of two sets.
  defineTwoSetsFunction(['Intersect', 'Sets.Intersect'],
      (a, b) => a.toSet().intersection(b.toSet()));

  // Registers a function to perform the difference of two sets.
  defineTwoSetsFunction(
      ['Sets.Difference'], (a, b) => a.toSet().difference(b.toSet()));
}
