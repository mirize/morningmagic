import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as Math;

import 'package:morningmagic/resources/colors.dart';

class ArcProgressBarPainter extends CustomPainter {
  final double strokeWidth;

  ArcProgressBarPainter({
    double strokeWidth,
  }) : this.strokeWidth = strokeWidth ?? 8;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final Size constrainedSize =
        size - Offset(this.strokeWidth, this.strokeWidth);
    final shortestSide =
        Math.min(constrainedSize.width, constrainedSize.height);
    final radius = (shortestSide / 2);

    // Start at the top. 0 radians represents the right edge
    final double startAngle = (2 * Math.pi * 0.275);

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
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final oldPainter = (oldDelegate as ArcProgressBarPainter);
    return oldPainter.strokeWidth != this.strokeWidth;
  }
}
