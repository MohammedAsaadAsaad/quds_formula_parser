import '../../../../quds_formula_parser.dart';

/// A class representing a point in 2D space.
class Point2D {
  /// The x-coordinate of the point.
  final num x;

  /// The y-coordinate of the point.
  final num y;

  /// Creates a [Point2D] with the given [x] and [y] coordinates.
  ///
  /// **Parameters**:
  /// - [x]: The x-coordinate of the point.
  /// - [y]: The y-coordinate of the point.
  Point2D(this.x, this.y);

  /// Calculates the distance to another point [p].
  ///
  /// **Parameters**:
  /// - [p]: The other point in 2D space.
  ///
  /// **Returns**:
  /// - The Euclidean distance between this point and [p].
  double calculateDistance(Point2D p) {
    return sqrt(pow(x - p.x, 2) + pow(y - p.y, 2));
  }

  /// Adds another point [p] to this point.
  ///
  /// **Parameters**:
  /// - [p]: The other point to be added.
  ///
  /// **Returns**:
  /// - A new [Point2D] representing the result of the addition.
  Point2D add(Point2D p) => Point2D(x + p.x, y + p.y);

  /// Operator overload for the addition of two points.
  ///
  /// This allows adding points using the `+` operator.
  ///
  /// **Returns**:
  /// - A new [Point2D] as the result of adding this point and [other].
  Point2D operator +(Point2D other) => add(other);

  /// The hash code for this point, based on the x and y coordinates.
  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  /// Compares this point to another object.
  ///
  /// **Returns**:
  /// - `true` if [other] is a [Point2D] and has the same x and y coordinates, otherwise `false`.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Point2D) return false;
    return x == other.x && y == other.y;
  }

  /// Returns a string representation of the point in the form `'{x, y}'`.
  @override
  String toString() => '{$x,$y}';
}

/// A wrapper class for the [Point2D] type used within the formula system.
class Point2DWrapper extends ValueWrapper<Point2D> {
  /// Creates a [Point2DWrapper] that wraps a [Point2D] object.
  ///
  /// **Parameters**:
  /// - [value]: The [Point2D] object to be wrapped.
  Point2DWrapper(super.value);

  /// Returns the type of the value as `'Point2D'`.
  @override
  String get valueType => 'Point2D';

  @override
  String get toTexNotation => '(${value.x},${value.y})';
}
