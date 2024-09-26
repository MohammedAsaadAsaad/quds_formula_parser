import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A function to calculate the distance between two points.
///
/// This function supports both 2D and 3D points and calculates
/// the distance between the two points provided as parameters.
///
/// Function notations:
/// - 'Distance'
/// - 'Geo.Dist'
class DistanceFunction extends GeometryFunction {
  DistanceFunction() : super(functionNotations: ['Distance', 'Geo.Dist']);

  @override
  calculate(List<ValueWrapper> parameters) {
    var p1 = parameters.first.value;
    var p2 = parameters[1].value;

    if (p1 is Point2D && p2 is Point2D) return p1.calculateDistance(p2);
    if (p1 is Point3D && p2 is Point3D) return p1.calculateDistance(p2);

    return NullValue();
  }

  @override
  bool checkParameters(List<ValueWrapper> terms) {
    return terms.length == 2 &&
        (terms[0].runtimeType == terms[1].runtimeType) &&
        terms[0].isPoint &&
        terms[1].isPoint;
  }
}
