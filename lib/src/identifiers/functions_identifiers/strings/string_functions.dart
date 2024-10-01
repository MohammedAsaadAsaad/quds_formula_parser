import 'package:quds_formula_parser/quds_formula_parser.dart';

/// Registers string-related functions with the provided formula provider.
///
/// This function defines and registers various string manipulation operations, such as
/// calculating the length of a string, converting cases, trimming whitespace, replacing
/// substrings, checking for substrings, and concatenating strings.
///
/// **Parameters**:
/// - [provider]: The `FormulaProvider` instance where the string functions are registered.
void registerStringFunctions(FormulaProvider provider) {
  // Helper function to define single-string-parameter functions.
  void defineStringFunction(
      List<String> notations, dynamic Function(String str) calculationMethod) {
    provider.registerFunction(
        notations: notations,
        evaluator: (params) => calculationMethod(params.first),
        checkParameters: (params) => params.isSingle && params.first is String);
  }

  // Helper function to define functions that take a list of strings.
  void defineListStringFunction(List<String> notations,
      dynamic Function(Iterable<String> params) calculationMethod) {
    provider.registerFunction(
        notations: notations,
        evaluator: (params) =>
            calculationMethod(params.map((e) => e as String)),
        checkParameters: (params) =>
            params.isNotEmpty && params.every((e) => e is String));
  }

  // Register functions for string length, case conversion, and trimming.
  defineStringFunction(
      ['Len', 'Str.Len', 'Length', 'Str.Length'], (s) => s.length);
  defineStringFunction(
      ['Lower', 'ToLower', 'Str.Lower'], (s) => s.toLowerCase());
  defineStringFunction(
      ['Upper', 'ToUpper', 'Str.Upper'], (s) => s.toUpperCase());
  defineStringFunction(['Trim', 'Str.Trim'], (s) => s.trim());
  defineStringFunction(['TrimLeft', 'Str.TrimLeft'], (s) => s.trimLeft());
  defineStringFunction(['TrimRight', 'Str.TrimRight'], (s) => s.trimRight());

  // Register a function to convert any value to its string representation.
  provider.registerFunction(
      notations: ['ToStr'],
      evaluator: (params) => toFormulaValue(params.first).stringToView,
      checkParameters: (params) => params.isSingle);

  // Register functions for replacing substrings and checking for substrings.
  provider.registerFunction(
      notations: ['Replace'],
      evaluator: (params) =>
          (params.first as String).replaceAll(params.second, params.third),
      checkParameters: (params) =>
          params.isTriple && params.every((e) => e is String));

  provider.registerFunction(
      notations: ['Contains'],
      evaluator: (params) => (params.first as String).contains(params.second),
      checkParameters: (params) =>
          params.isCouple && params.every((e) => e is String));

  provider.registerFunction(
      notations: ['StartsWith'],
      evaluator: (params) => (params.first as String).startsWith(params.second),
      checkParameters: (params) =>
          params.isCouple && params.every((e) => e is String));

  provider.registerFunction(
      notations: ['EndsWith'],
      evaluator: (params) => (params.first as String).endsWith(params.second),
      checkParameters: (params) =>
          params.isCouple && params.every((e) => e is String));

  // Register a function to concatenate a list of strings.
  defineListStringFunction(
      ['Concat', 'Str.Concat'], (ps) => ps.reduce((a, b) => a + b));
}
