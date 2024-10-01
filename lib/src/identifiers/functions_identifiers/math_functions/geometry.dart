import 'package:quds_formula_parser/quds_formula_parser.dart';

/// Registers geometry-related functions with the provided formula provider.
///
/// This function defines and registers geometry operations, such as creating points (2D and 3D),
/// calculating distances between points, and extracting point coordinates.
///
/// **Parameters**:
/// - [provider]: The `FormulaProvider` instance where the geometry functions are registered.
void registerGeometryFunctions(FormulaProvider provider) {
  // Register the function to create a 2D or 3D point.
  provider.registerFunction(
      notations: ['Point'],
      evaluator: (params) {
        return params.isCouple
            ? Point2D(params.first, params.second)
            : Point3D(params.first, params.second, params.third);
      },
      checkParameters: (params) => params.isCouple || params.isTriple);

  // Register a function to calculate the distance between two points (2D or 3D).
  provider.registerFunction(
      notations: ['Distance', 'Geo.Dist'],
      evaluator: (params) {
        var p1 = params.first;
        var p2 = params.second;
        if (p1 is Point2D && p2 is Point2D) return p1.calculateDistance(p2);
        if (p1 is Point3D && p2 is Point3D) return p1.calculateDistance(p2);
        return null;
      },
      checkParameters: (params) =>
          params.isCouple && params.every((e) => e is Point2D || e is Point3D));

  // Helper method to define functions that extract point coordinates.
  void definePointMemberFunction(List<String> notations,
      dynamic Function(dynamic point) calculationMethod) {
    provider.registerFunction(
        notations: notations,
        evaluator: (params) {
          return calculationMethod(params.first);
        },
        checkParameters: (params) =>
            params.isSingle &&
            (params.first is Point2D || params.first is Point3D));
  }

  // Register functions to extract X, Y, and Z coordinates from a point.
  definePointMemberFunction(['Point.X', 'PointX', 'Geo.PointX'], (p) => p.x);
  definePointMemberFunction(['Point.Y', 'PointY', 'Geo.PointY'], (p) => p.y);
  definePointMemberFunction(['Point.Z', 'PointZ', 'Geo.PointZ'], (p) => p.z);
}
