import '../../../../../quds_formula_parser.dart';

/// A class to identify and parse 3D point values in a formula.
///
/// This class identifies strings representing 3D points in a specific format (enclosed in `{}`),
/// where the point is defined by three numeric values separated by commas (e.g., `{x, y, z}`).
/// It converts the string into a [Point3DWrapper] object.
class Point3dIdentifier extends ValueIdentifier<Point3DWrapper> {
  /// Parses the input string to identify and extract a 3D point.
  ///
  /// The expected format is a 3D point string enclosed in `{}` symbols, e.g., `{3.5, 4.2, 5.1}`.
  /// The string must contain three numeric values separated by commas.
  ///
  /// Returns a [Point3DWrapper] object with the parsed `x`, `y`, and `z` coordinates.
  @override
  Point3DWrapper parse(String str) {
    str = str.trim();
    // Remove the enclosing braces.
    str = str.substring(1, str.length);
    str = str.substring(0, str.length - 1);

    // Split the coordinates by commas.
    var parts = str.split(',');

    // Convert the string parts to numeric values and return the 3D point.
    return Point3DWrapper(
        Point3D(parts[0].toNum(), parts[1].toNum(), parts[2].toNum()));
  }

  /// Returns the regular expression pattern used to identify 3D point strings.
  ///
  /// The pattern matches 3D points enclosed in `{}` symbols, where the three real number values are
  /// separated by commas (e.g., `{x, y, z}`).
  @override
  String get pattern {
    var realPattern = RealNumberIdentifier().pattern;
    return '{$kSpacePatternOptional$realPattern[\\,]$kSpacePatternOptional$realPattern[\\,]$kSpacePatternOptional$realPattern}';
  }
}
