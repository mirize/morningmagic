import 'package:flutter/material.dart';
import 'package:morningmagic/resources/colors.dart';

class LinePainter extends CustomPainter {

  Paint _paint;
  double _progress;
  double wideStep;
  int randomValue;

  LinePainter(this._progress, this.wideStep, this.randomValue) {
    _paint = Paint()
      ..color = AppColors.VIOLET
      ..strokeWidth = 4.0;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(Offset(wideStep, size.height), Offset(wideStep, _progress *
        (size.height / 1.5)), _paint);

  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) {
    return oldDelegate._progress != _progress;
  }

}