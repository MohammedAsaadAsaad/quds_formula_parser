import '../../../../quds_formula_parser.dart';

/// A class to identify and parse atomic symbols in a formula.
///
/// This class identifies strings representing atomic symbols (enclosed in single quotes)
/// and converts them into [AtomWrapper] objects by looking up the atom based on its symbol.
class AtomIdentifier extends ValueIdentifier<AtomWrapper> {
  /// Parses the input string to identify and extract an atom.
  ///
  /// The string is expected to be enclosed in single quotes and represent an atomic symbol
  /// (e.g., `'H'` for Hydrogen, `'O'` for Oxygen). If the symbol corresponds to a valid atom,
  /// it returns an [AtomWrapper] containing the [Atom]. Otherwise, it returns `null`.
  @override
  AtomWrapper? parse(String str) {
    var atom = Atom.fromSymbol(str.replaceAll("'", ''));
    if (atom == null) return null;
    return AtomWrapper(atom);
  }

  /// Returns the regular expression pattern used to identify atomic symbols.
  ///
  /// The pattern matches atomic symbols enclosed in single quotes (e.g., `'H'`, `'O'`).
  /// It supports atomic symbols of one or two alphanumeric characters.
  @override
  String get pattern {
    return r"'[\w]{1,2}";
  }
}
