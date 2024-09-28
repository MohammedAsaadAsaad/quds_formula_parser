import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A function to create a point from given coordinates.
///
/// This function supports both 2D and 3D points. If two parameters are provided,
/// a 2D point is created. If three parameters are provided, a 3D point is created.
///
/// Function notations:
/// - 'Point'
/// - 'Geo.Point'
class PointFunction extends GeometryFunction {
  PointFunction() : super(functionNotations: ['Point', 'Geo.Point']);

  @override
  calculate(List<ValueWrapper> parameters) {
    var x = parameters.first.value;
    var y = parameters[1].value;
    if (parameters.length == 2) return Point2D(x, y);

    var z = parameters[2].value;
    return Point3D(x, y, z);
  }

  @override
  bool checkParameters(List<ValueWrapper> terms) {
    if (terms.length < 2 || terms.length > 3) return false;
    return terms.every((e) => e.isRealNumber);
  }
}

/// A function to extract the X coordinate from a point.
///
/// This function works with both 2D and 3D points and returns the X coordinate.
///
/// Function notations:
/// - 'Point.X'
/// - 'PointX'
/// - 'Geo.PointX'
class PointXFunction extends GeometryFunction {
  PointXFunction()
      : super(functionNotations: ['Point.X', 'PointX', 'Geo.PointX']);

  @override
  calculate(List<ValueWrapper> parameters) {
    var p = parameters.first.value;
    if (p is Point2D) return p.x;
    if (p is Point3D) return p.x;
    return NAValue();
  }

  @override
  bool checkParameters(List<ValueWrapper> terms) {
    return terms.length == 1 && terms.first.isPoint;
  }
}

/// A function to extract the Y coordinate from a point.
///
/// This function works with both 2D and 3D points and returns the Y coordinate.
///
/// Function notations:
/// - 'Point.Y'
/// - 'PointY'
/// - 'Geo.PointY'
class PointYFunction extends GeometryFunction {
  PointYFunction()
      : super(functionNotations: ['Point.Y', 'PointY', 'Geo.PointY']);

  @override
  calculate(List<ValueWrapper> parameters) {
    var p = parameters.first.value;
    if (p is Point2D) return p.y;
    if (p is Point3D) return p.y;
    return NAValue();
  }

  @override
  bool checkParameters(List<ValueWrapper> terms) {
    return terms.length == 1 && terms.first.isPoint;
  }
}

/// A function to extract the Z coordinate from a 3D point.
///
/// This function returns the Z coordinate of a 3D point.
///
/// Function notations:
/// - 'Point.Z'
/// - 'PointZ'
/// - 'Geo.PointZ'
class PointZFunction extends GeometryFunction {
  PointZFunction()
      : super(functionNotations: ['Point.Z', 'PointZ', 'Geo.PointZ']);

  @override
  calculate(List<ValueWrapper> parameters) {
    var p = parameters.first.value;
    if (p is Point3D) return p.z;
    return NAValue();
  }

  @override
  bool checkParameters(List<ValueWrapper> terms) {
    return terms.length == 1 && terms.first is Point3DWrapper;
  }
}
