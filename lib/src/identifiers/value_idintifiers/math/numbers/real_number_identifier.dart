import '../../../../../quds_formula_parser.dart';

/// A singleton class to identify and parse real numbers in a formula.
///
/// This class identifies real number strings, including support for both decimal
/// and scientific notation, and converts them into [RealNumberWrapper] objects.
class RealNumberIdentifier extends ValueIdentifier<RealNumberWrapper> {
  /// Private constructor for the singleton instance of [RealNumberIdentifier].
  RealNumberIdentifier._();

  /// Singleton instance of the [RealNumberIdentifier] class.
  static final _instance = RealNumberIdentifier._();

  /// Provides access to the singleton instance of the [RealNumberIdentifier] class.
  static RealNumberIdentifier get instance => _instance;

  /// Factory constructor to ensure that only one instance of the class is created.
  factory RealNumberIdentifier() => instance;

  /// Parses the input string to identify and extract a real number.
  ///
  /// The string can represent a real number in either decimal or scientific notation.
  /// Returns a [RealNumberWrapper] object with the parsed value.
  @override
  RealNumberWrapper parse(String str) {
    return RealNumberWrapper(num.parse(str));
  }

  /// Returns the regular expression pattern used to identify real number strings.
  ///
  /// The pattern matches both decimal numbers (e.g., `123.45`) and numbers in scientific notation
  /// (e.g., `1.23E3` or `-4.56e-2`). It supports optional signs (`+` or `-`) at the beginning of the number.
  @override
  String get pattern => r"(([\+\-])?[0-9]+(\.[0-9]+)?([Ee][\+\-]?[0-9]+)?)";
}
