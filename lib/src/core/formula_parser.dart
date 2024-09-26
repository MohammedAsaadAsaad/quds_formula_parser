import '../../quds_formula_parser.dart';

/// A parser for processing formulas using the specified `FormulaProvider`.
/// This class is responsible for interpreting the string representation of formulas
/// and breaking them down into their constituent terms.
class FormulaParser {
  /// Creates an instance of `FormulaParser` with the provided formula provider.
  FormulaParser({required this.provider});

  factory FormulaParser.defaultParser() =>
      FormulaParser(provider: FormulaProvider.defaultInstance);

  /// The `FormulaProvider` instance that contains identifiers for parsing terms.
  final FormulaProvider provider;

  /// Parses a formula represented as a string and returns a `Formula` object.
  /// This method processes the string and identifies terms, values, and functions.
  Formula parse(String str) {
    str = str.trim(); // Remove leading and trailing whitespace

    Formula result = Formula(parser: this); // Initialize the formula object
    int position = 0; // Track the current position in the input string

    bool found = false; // Flag to indicate if a term was found
    do {
      var temp = str; // Store the current state of the string
      str = temp.trimLeft(); // Remove leading whitespace
      position += temp.length - str.length; // Update position

      if (str.isEmpty) break; // Exit if the string is empty

      found = false; // Reset found flag

      if (!found) {
        // Parse values
        for (var id in provider.identifiers) {
          var r = id.getMatchString(str); // Attempt to match a term
          if (r != null) {
            var parsed = id.parse(r); // Parse the matched term
            if (parsed != null) {
              result.terms.add(parsed
                ..position = position); // Add the parsed term to the formula
              position += r.length; // Update position
              str = str.substring(
                  r.length, str.length); // Update the remaining string
              found = true; // Mark that a term was found
              break; // Exit the loop since a term was found
            }
          }
        }
      }

      if (!found) {
        // Parse functions (implementation to be added)
      }
    } while (found); // Continue parsing as long as terms are found

    if (!found) {
      result.errorParsingPosition =
          position; // Set error position if no term was found
    }

    return result; // Return the parsed formula
  }
}
