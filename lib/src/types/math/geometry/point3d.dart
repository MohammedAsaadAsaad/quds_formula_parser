import '../../../../quds_formula_parser.dart';

/// A class representing a point in 3D space.
class Point3D {
  final num x;
  final num y;
  final num z;

  /// Creates a [Point3D] with the given [x], [y], and [z] coordinates.
  Point3D(this.x, this.y, this.z) {
    // Optional: Add validation if necessary
  }

  /// Calculates the distance to another point [p].
  double calculateDistance(Point3D p) {
    return sqrt(pow(x - p.x, 2) + pow(y - p.y, 2) + pow(z - p.z, 2));
  }

  /// Adds another point [p] to this point.
  Point3D add(Point3D p) => Point3D(x + p.x, y + p.y, z + p.z);

  Point3D operator +(Point3D other) => add(other);

  @override
  String toString() => '{$x,$y,$z}';

  @override
  int get hashCode => x.hashCode ^ y.hashCode ^ z.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Point3D) return false;
    return x == other.x && y == other.y && z == other.z;
  }
}

/// A wrapper class for the [Point3D] type used within the formula system.
class Point3DWrapper extends ValueWrapper<Point3D> {
  /// Creates a [Point3DWrapper] that wraps a [Point3D] object.
  Point3DWrapper(super.value);

  /// Returns the type of the value as `'Point3D'`.
  @override
  String get valueType => 'Point3D';

  @override
  String get toTexNotation => '(${value.x},${value.y},${value.z})';
}
