import 'package:quds_formula_parser/quds_formula_parser.dart';

/// An abstract class representing geometry-related functions.
///
/// This class serves as a base for various geometry-related functions,
/// such as calculating distances or extracting coordinates from points.
///
/// Functions that inherit from this class include:
/// - DistanceFunction
/// - PointXFunction
/// - PointYFunction
/// - PointZFunction
/// - PointFunction
abstract class GeometryFunction extends FormulaFunction {
  GeometryFunction({required super.functionNotations});

  /// Generates a list of geometry-related functions.
  ///
  /// These functions include:
  /// - `DistanceFunction`: Calculates the distance between two points.
  /// - `PointXFunction`: Extracts the X-coordinate from a point.
  /// - `PointYFunction`: Extracts the Y-coordinate from a point.
  /// - `PointZFunction`: Extracts the Z-coordinate from a point.
  /// - `PointFunction`: Creates a point from coordinates.
  static List<GeometryFunction> generateFunction() => [
        DistanceFunction(),
        PointXFunction(),
        PointYFunction(),
        PointZFunction(),
        PointFunction(),
      ];
}
