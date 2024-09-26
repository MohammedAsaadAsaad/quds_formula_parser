/// An extension on [String] to provide methods for converting strings to numerical types.
extension TextNumberExtension on String {
  /// Converts the string to a [double].
  /// Throws a [FormatException] if the string cannot be parsed as a double.
  double toDouble() => double.parse(this);

  /// Converts the string to a [num].
  /// Throws a [FormatException] if the string cannot be parsed as a number.
  num toNum() => num.parse(this);
}
