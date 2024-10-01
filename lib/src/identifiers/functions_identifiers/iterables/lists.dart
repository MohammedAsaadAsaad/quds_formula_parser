import 'package:quds_formula_parser/quds_formula_parser.dart';

/// Registers list-related functions with the provided formula provider.
///
/// This function defines and registers functions that operate on lists,
/// such as creating a list and reversing a list.
///
/// **Parameters**:
/// - [provider]: The `FormulaProvider` instance where the list functions are registered.
void registerListsFunctions(FormulaProvider provider) {
  // Defines and registers a list-related function with the given notations and calculation method.
  void defineListsFunction(
      List<String> notations, Function(Iterable params) calculationsMethod) {
    provider.registerFunction(
        notations: notations, evaluator: calculationsMethod);
  }

  // Registers a function to create a list from the parameters.
  defineListsFunction(['List'], (params) => params);

  // Registers a function to reverse a list.
  defineListsFunction(['Reverse'], (params) => params.toList().reversed);
}
