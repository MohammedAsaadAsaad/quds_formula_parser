import '../../quds_formula_parser.dart';

/// An abstract class representing an identifier for value types in a formula.
abstract class ValueIdentifier<T extends FormulaValue>
    extends FormulaTermIdentifier {
  /// Parses a string to extract a value of type [T].
  ///
  /// This method must be implemented by subclasses to provide specific parsing logic.
  @override
  T? parse(String str) {
    throw UnimplementedError(); // Throws an error if the method is not implemented.
  }
}
