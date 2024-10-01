import 'package:quds_formula_parser/quds_formula_parser.dart';

/// An abstract class that represents logical functions in formulas.
///
/// This class extends [FormulaFunction] and serves as a base class
/// for specific logical operations such as AND, OR, NOT, IF, and IFERROR.
abstract class LogicalFunction extends FormulaFunction<FormulaValue> {
  LogicalFunction({required super.functionNotations});

  /// Generates a list of logical functions.
  ///
  /// **Returns**:
  /// - A list of logical functions like [IfErrorFunction].
  static List<FormulaFunction> generateFunctions() => [
        IfErrorFunction(),
      ];
}

/// Registers logical functions with the provided formula provider.
///
/// This function defines and registers common logical functions such as IF, NOT, AND, OR,
/// XOR, as well as bitwise and iterable logical operations.
///
/// **Parameters**:
/// - [provider]: The `FormulaProvider` instance where the logical functions are registered.
void registerLogicalFunctions(FormulaProvider provider) {
  // Register the IF function that returns the second or third parameter based on the first (boolean).
  provider.registerFunction(
      notations: ['If'],
      evaluator: (params) {
        return params.first ? params.second : params.third;
      },
      checkParameters: (params) => params.isTriple && params.first is bool);

  // Register the NOT (or Toggle) function that negates a boolean value.
  provider.registerFunction(
      notations: ['Not', 'Toggle'],
      evaluator: (params) {
        return !params.first;
      },
      checkParameters: (params) => params.isSingle && params.first is bool);

  // Register a function that generates a random boolean value.
  provider.registerFunction(
      notations: ['RandomBool', 'Random.Bool'],
      evaluator: (params) {
        return Random().nextBool();
      },
      checkParameters: (params) => params.isEmpty);

  // Helper method to define bitwise logical functions like AND, OR, XOR.
  void defineBitwiseFunction(List<String> notations,
      bool Function(bool a, bool b) calculationsMethod) {
    provider.registerFunction(
        notations: notations,
        evaluator: (params) {
          return calculationsMethod(params.first, params.second);
        },
        checkParameters: (params) =>
            params.isCouple && params.every((e) => e is bool));
  }

  // Register bitwise AND, OR, and XOR functions.
  defineBitwiseFunction(['And'], (a, b) => a && b);
  defineBitwiseFunction(['Or'], (a, b) => a || b);
  defineBitwiseFunction(['XOR'], (a, b) => a ^ b); // a != b

  // Helper method to define logical functions operating on an iterable of booleans.
  void defineOnIterableFunction(List<String> notations,
      bool Function(Iterable<bool> params) calculationsMethod) {
    provider.registerFunction(
        notations: notations,
        evaluator: (params) {
          return calculationsMethod(params.map((e) => e as bool));
        },
        checkParameters: (params) =>
            params.isNotEmpty && params.every((e) => e is bool));
  }

  // Register functions to check if all/any values in a list of booleans are true or false.
  defineOnIterableFunction(['AllTrue'], (params) => params.every((e) => e));
  defineOnIterableFunction(['AnyTrue'], (params) {
    for (var p in params) {
      if (p) return true;
    }
    return false;
  });

  defineOnIterableFunction(['AllFalse'], (params) => params.every((e) => !e));
  defineOnIterableFunction(['AnyFalse'], (params) {
    for (var p in params) {
      if (!p) return true;
    }
    return false;
  });
}
