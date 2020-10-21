import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as Math;

import 'package:morningmagic/resources/colors.dart';

class CircleProgressBarPainter extends CustomPainter {
  final double percentage;
  final double strokeWidth;
  final Color foregroundColor;

  CircleProgressBarPainter({
    @required this.foregroundColor,
    @required this.percentage,
    double strokeWidth,
  }) : this.strokeWidth = strokeWidth ?? 8;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final Size constrainedSize =
        size - Offset(this.strokeWidth, this.strokeWidth);
    final shortestSide =
        Math.min(constrainedSize.width, constrainedSize.height);
    final foregroundPaint = Paint()
      ..color = this.foregroundColor
      ..strokeWidth = this.strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final circlePaint = Paint()
      ..color = this.foregroundColor
      ..strokeWidth = this.strokeWidth * 2
      ..style = PaintingStyle.stroke;
    final radius = (shortestSide / 2);

    // Start at the top. 0 radians represents the right edge
    final double startAngle = (2 * Math.pi * 0.275);
    final double sweepAngle = (2 * Math.pi * ((this.percentage * 0.95) ?? 0));

    Offset circleOffset = createCircleOffset(
        _getXCoordinate(center.dx, radius, sweepAngle + startAngle),
        _getYCoordinate(center.dy, radius, sweepAngle + startAngle));

    final backgroundPaint = Paint()
      ..shader = LinearGradient(
              colors: [AppColors.SHADER_BOTTOM, AppColors.PINK],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)
          .createShader(Rect.fromLTRB(constrainedSize.height,
              constrainedSize.height, constrainedSize.height, 0))
      ..strokeWidth = this.strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      (2 * Math.pi * 0.95),
      false,
      backgroundPaint,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      foregroundPaint,
    );

    // draw circle shadow
    Path path = new Path();
    Offset moved = Offset(circleOffset.dx, circleOffset.dy - 5);
    path.addOval(Rect.fromCenter(center: moved, width: 33, height: 33));
    canvas.drawShadow(path, Colors.black, 5.2, true);

    canvas.drawCircle(circleOffset, 4, circlePaint);
  }

  Offset createCircleOffset(double dx, double dy) {
    return new Offset(dx, dy);
  }

  double _getXCoordinate(double x0, double radius, double angle) {
    return x0 + radius * Math.cos(angle);
  }

  double _getYCoordinate(double y0, double radius, double angle) {
    return y0 + radius * Math.sin(angle);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final oldPainter = (oldDelegate as CircleProgressBarPainter);
    return oldPainter.percentage != this.percentage ||
        oldPainter.foregroundColor != this.foregroundColor ||
        oldPainter.strokeWidth != this.strokeWidth;
  }
}
