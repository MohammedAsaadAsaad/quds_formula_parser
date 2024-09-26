import '../../../../../quds_formula_parser.dart';

/// A class to identify and parse complex numbers in a formula.
///
/// This class identifies strings representing complex numbers in a format where the real and imaginary
/// parts are separated by a plus or minus sign (e.g., `3 + 4i`, `5 - 2i`). It converts the string into
/// a [ComplexNumberWrapper] object.
class ComplexNumberIdentifier extends ValueIdentifier<ComplexNumberWrapper> {
  /// Parses the input string to identify and extract a complex number.
  ///
  /// The expected format is a complex number string, where the real and imaginary parts are separated
  /// by a `+` or `-` sign (e.g., `3 + 4i`, `5 - 2i`). The imaginary part is expected to end with `i`.
  ///
  /// Returns a [ComplexNumberWrapper] object with the parsed real and imaginary parts.
  @override
  ComplexNumberWrapper parse(String str) {
    String img = "";
    String real = "";
    String realPattern = RealNumberIdentifier().pattern;
    String imgPattern = '$realPattern${kSpacePatternOptional}i';
    var imgRegex = RegExp(imgPattern);
    var imgMatch = imgRegex.firstMatch(str);

    if (imgMatch != null) {
      img = imgMatch.result;
      img = img.replaceAll('i', ''); // Remove the imaginary unit.
      str = str.substring(0, imgMatch.start).trim();
    }

    // Determine if the imaginary part is negative.
    bool isNegativeImg = str.endsWith('-');
    if (str.endsWith('+') || str.endsWith('-')) {
      str = str.substring(0, str.length - 1);
    }

    // Set the real part of the complex number.
    real = str;

    return ComplexNumberWrapper(ComplexNumber(double.tryParse(real) ?? 0.0,
        (isNegativeImg ? -1 : 1) * (double.tryParse(img) ?? 0.0)));
  }

  /// Returns the regular expression pattern used to identify complex number strings.
  ///
  /// The pattern matches complex numbers where the real and imaginary parts are separated by `+` or `-` and
  /// the imaginary part ends with `i` (e.g., `3 + 4i`, `5 - 2i`).
  @override
  String get pattern {
    var realPattern = RealNumberIdentifier().pattern;
    String result = realPattern;
    result = '($result)?';
    result += kSpacePatternOptional;
    result += '[\\+\\-]';
    result = '($result)?';
    result += kSpacePatternOptional;

    result += '(${realPattern + (kSpacePatternOptional)}i)';
    return result;
  }
}
