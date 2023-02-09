import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class RecordAnimation extends StatefulWidget {
  const RecordAnimation({super.key});

  @override
  State<RecordAnimation> createState() => _RecordAnimationState();
}

class _RecordAnimationState extends State<RecordAnimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class AnimationPainter extends CustomPainter {
  final double firstRippleRadius;
  final double firstRippleOpacity;
  final double firstRippleStrokeWidth;
  final double secondRippleRadius;
  final double secondRippleOpacity;
  final double secondRippleStrokeWidth;
  final double thirdRippleRadius;
  final double thirdRippleOpacity;
  final double thirdRippleStrokeWidth;
  final double centerCircleRadius;

  AnimationPainter(
    this.firstRippleRadius,
    this.firstRippleOpacity,
    this.firstRippleStrokeWidth,
    this.secondRippleRadius,
    this.secondRippleOpacity,
    this.secondRippleStrokeWidth,
    this.thirdRippleRadius,
    this.thirdRippleOpacity,
    this.thirdRippleStrokeWidth,
    this.centerCircleRadius,
  );

  @override
  void paint(Canvas canvas, Size size) {
    Color color = Color(0xFFFFC4DD);

    Paint paint = Paint();
    paint.color = color.withOpacity(firstRippleOpacity);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = firstRippleStrokeWidth;

    canvas.drawCircle(Offset.zero, firstRippleRadius, paint);

    Paint Spaint = Paint();
    Spaint.color = color.withOpacity(secondRippleOpacity);
    Spaint.style = PaintingStyle.stroke;
    Spaint.strokeWidth = secondRippleStrokeWidth;

    canvas.drawCircle(Offset.zero, secondRippleRadius, Spaint);

    Paint Tpaint = Paint();
    Tpaint.color = color.withOpacity(thirdRippleOpacity);
    Tpaint.style = PaintingStyle.stroke;
    Tpaint.strokeWidth = thirdRippleStrokeWidth;

    canvas.drawCircle(Offset.zero, thirdRippleRadius, Tpaint);
  }

  @override
  bool shouldRepaint(AnimationPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(AnimationPainter oldDelegate) => false;
}
