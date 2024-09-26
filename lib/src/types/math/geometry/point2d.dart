import '../../../../quds_formula_parser.dart';

/// A class representing a point in 2D space.
class Point2D {
  final num x;
  final num y;

  /// Creates a [Point2D] with the given [x] and [y] coordinates.
  Point2D(this.x, this.y) {
    // Optional: Add validation if necessary
  }

  /// Calculates the distance to another point [p].
  double calculateDistance(Point2D p) {
    return sqrt(pow(x - p.x, 2) + pow(y - p.y, 2));
  }

  /// Adds another point [p] to this point.
  Point2D add(Point2D p) => Point2D(x + p.x, y + p.y);

  Point2D operator +(Point2D other) => add(other);

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Point2D) return false;
    return x == other.x && y == other.y;
  }

  @override
  String toString() => '{$x,$y}';
}

/// A wrapper class for the [Point2D] type used within the formula system.
class Point2DWrapper extends ValueWrapper<Point2D> {
  /// Creates a [Point2DWrapper] that wraps a [Point2D] object.
  Point2DWrapper(super.value);

  /// Returns the type of the value as `'Point'`.
  @override
  String get valueType => 'Point';
}
