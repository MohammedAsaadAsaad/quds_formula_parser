import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:quds_formula_parser/quds_formula_parser.dart';

class Plot2D extends StatefulWidget {
  final String formulaString;
  const Plot2D({super.key, required this.formulaString});

  @override
  State<Plot2D> createState() => _Plot2DState();
}

class _Plot2DState extends State<Plot2D> {
  late FormulaParser parser;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    parser = FormulaParser()
      ..setVariableValue('x', 0.0)
      ..parse(widget.formulaString);

    var formula = parser.formula;
    if (formula != null) {
      if (formula.hasParsingError) {
        return Text(
          'Formula has error at the position: ${formula.errorParsingPosition}, ${formula.errorCode}',
          style: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        );
      }

      return Stack(
        children: [
          // Background: Palestinian flag
          Opacity(
            opacity: 0.2, // Adjust the transparency of the flag
            child: Image.asset(
              'assets/palestinian_flag.png', // Replace with your flag image
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          // Foreground: Plot
          _Plot2DPainter(parser: parser),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}

class _Plot2DPainter extends StatefulWidget {
  final FormulaParser parser;

  const _Plot2DPainter({required this.parser});

  @override
  State<StatefulWidget> createState() => _Plot2DPainterState();
}

class _Plot2DPainterState extends State<_Plot2DPainter> {
  double _scale = 1.0;
  Offset _offset = const Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    double step = 0.01 / _scale; // Scale higher, accuracy higher
    double plotScale = 30.0;
    double factor = (_scale * plotScale);

    return Listener(
      onPointerSignal: (pointerSignal) {
        if (pointerSignal is PointerScrollEvent) {
          setState(() {
            Offset focalPoint = pointerSignal.localPosition;

            Offset localFocalPoint = (focalPoint - _offset) / _scale;
            _scale =
                (_scale - pointerSignal.scrollDelta.dy * 0.01).clamp(0.5, 5.0);
            _offset = focalPoint - localFocalPoint * _scale;
          });
        }
      },
      child: GestureDetector(
        onScaleStart: (ScaleStartDetails details) {},
        onScaleUpdate: (ScaleUpdateDetails details) {
          setState(() {
            _scale = (_scale * details.scale).clamp(0.5, 5.0);
            _offset += details.focalPointDelta;
          });
        },
        child: CustomPaint(
          size: Size.infinite,
          painter: FormulaPainter(
              step: step,
              plotScale: plotScale,
              factor: factor,
              scale: _scale,
              offset: _offset,
              parser: widget.parser),
        ),
      ),
    );
  }
}

class FormulaPainter extends CustomPainter {
  final double scale;
  final Offset offset;
  final double factor;
  final double plotScale;
  final double step;

  final FormulaParser parser;
  FormulaPainter(
      {required this.scale,
      required this.factor,
      required this.offset,
      required this.plotScale,
      required this.step,
      required this.parser});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromLTRB(0, 0, size.width, size.height));

    // Translate the canvas to apply offset and scale
    canvas.translate(offset.dx + size.width / 2, offset.dy + size.height / 2);
    canvas.scale(scale);

    // Draw X and Y axes
    _drawAxes(canvas, size);

    // Draw numbers on X and Y axes with ticks
    _drawAxisNumbersWithTicks(canvas, size);

    // Plot the formula
    _plotFormula(canvas, size);
  }

  void _drawAxes(Canvas canvas, Size size) {
    final Paint axisPaint = Paint()
      ..color = Colors.grey.shade800
      ..strokeWidth = 3.0; // Make axes thicker and smoother

    // Shadow effect for the axes to make them stand out
    final Paint axisShadowPaint = Paint()
      ..color = Colors.black12
      ..strokeWidth = 6.0
      ..maskFilter =
          const MaskFilter.blur(BlurStyle.normal, 4.0); // Adding soft shadow

    // Draw shadow for the axes
    canvas.drawLine(Offset(-size.width * factor, 0),
        Offset(size.width * factor, 0), axisShadowPaint); // X-axis shadow
    canvas.drawLine(Offset(0, -size.height * factor),
        Offset(0, size.height * factor), axisShadowPaint); // Y-axis shadow

    canvas.drawLine(Offset(-size.width * factor, 0),
        Offset(size.width * factor, 0), axisPaint); // X-axis
    canvas.drawLine(Offset(0, -size.height * factor),
        Offset(0, size.height * factor), axisPaint); // Y-axis
  }

  void _drawAxisNumbersWithTicks(Canvas canvas, Size size) {
    final Paint tickPaint = Paint()
      ..color = Colors.grey.shade700
      ..strokeWidth = 1.5; // Make ticks lighter

    final textStyle = TextStyle(
        color: Colors.grey.shade900,
        fontSize: 14.0,
        fontWeight: FontWeight.w600);
    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    double tickLength = 8.0; // Longer ticks for more visibility

    // Adjust spacing between numbers based on the scale
    double baseSpacing = 70.0; // Reduced base spacing to show more numbers
    double spacing = baseSpacing / scale;

    // Avoid overly tight spacing when zoomed out
    if (spacing < 40) spacing = 40;

    // Draw X-axis numbers and ticks
    for (double i = -size.width / 2; i <= size.width / 2; i += spacing) {
      final textSpan =
          TextSpan(text: '${(i / plotScale).round()}', style: textStyle);
      textPainter.text = textSpan;
      textPainter.layout();
      textPainter.paint(
          canvas, Offset(i - textPainter.width / 2, 12)); // Adjusted Y position

      // Draw tick
      canvas.drawLine(Offset(i, -tickLength), Offset(i, tickLength), tickPaint);
    }

    // Draw Y-axis numbers and ticks
    for (double i = -size.height / 2; i <= size.height / 2; i += spacing) {
      final textSpan =
          TextSpan(text: '${(-i / plotScale).round()}', style: textStyle);
      textPainter.text = textSpan;
      textPainter.layout();
      textPainter.paint(canvas,
          Offset(12, i - textPainter.height / 2)); // Adjusted X position

      // Draw tick
      canvas.drawLine(Offset(-tickLength, i), Offset(tickLength, i), tickPaint);
    }
  }

  void _plotFormula(
    Canvas canvas,
    Size size,
  ) {
    // Gradient paint for the line
    const Gradient lineGradient = LinearGradient(
      colors: [Colors.deepPurple, Colors.cyan],
    );
    final Paint linePaint = Paint()
      ..shader = lineGradient
          .createShader(Rect.fromLTRB(0, 0, size.width, size.height))
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    Path path = Path();

    double xWidth = size.width / factor;
    double startX = (-size.width / 2 - offset.dx) / factor;
    double endX = startX + xWidth;
    startX -= 1.0;
    endX += 1.0;

    for (double x = startX; x <= endX; x += step) {
      parser.setVariableValue('x', x);
      double y = (parser.evaluate().value as num).toDouble();
      if (x == startX) {
        path.moveTo(x * plotScale, -y * plotScale); // Scale the plot
      } else {
        path.lineTo(x * plotScale, -y * plotScale); // Continue the path
      }
    }

    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
