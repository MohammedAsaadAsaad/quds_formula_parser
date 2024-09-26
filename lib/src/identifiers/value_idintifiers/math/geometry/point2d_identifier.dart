import '../../../../../quds_formula_parser.dart';

/// A class to identify and parse 2D point values in a formula.
///
/// This class identifies strings representing 2D points in a specific format (enclosed in `{}`),
/// where the point is defined by two numeric values separated by a comma (e.g., `{x, y}`).
/// It converts the string into a [Point2DWrapper] object.
class Point2dIdentifier extends ValueIdentifier<Point2DWrapper> {
  /// Parses the input string to identify and extract a 2D point.
  ///
  /// The expected format is a 2D point string enclosed in `{}` symbols, e.g., `{3.5, 4.2}`.
  /// The string must contain two numeric values separated by a comma.
  ///
  /// Returns a [Point2DWrapper] object with the parsed `x` and `y` coordinates.
  @override
  Point2DWrapper parse(String str) {
    str = str.trim();
    // Remove the enclosing braces.
    str = str.substring(1, str.length);
    str = str.substring(0, str.length - 1);

    // Split the coordinates by the comma.
    var parts = str.split(',');

    // Convert the string parts to numeric values and return the 2D point.
    return Point2DWrapper(Point2D(parts[0].toNum(), parts[1].toNum()));
  }

  /// Returns the regular expression pattern used to identify 2D point strings.
  ///
  /// The pattern matches 2D points enclosed in `{}` symbols, where the two real number values are
  /// separated by a comma (e.g., `{x, y}`).
  @override
  String get pattern {
    var realPattern = RealNumberIdentifier().pattern;
    return '{$kSpacePatternOptional$realPattern[\\,]$kSpacePatternOptional$realPattern}';
  }
}
