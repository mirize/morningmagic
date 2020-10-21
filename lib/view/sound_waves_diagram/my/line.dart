import 'dart:math';

import 'package:flutter/material.dart';

import 'line_painter.dart';

class Line extends StatefulWidget {
  final double wideStep;
  final AnimationController controller;

  Line(this.wideStep, this.controller);

  @override
  State<StatefulWidget> createState() => _LineState();

  AnimationController getController() {
    return controller;
  }
}

class _LineState extends State<Line> with TickerProviderStateMixin {
  double _progress = 0.0;
  Animation<double> animation;
  final _random = new Random();
  int randomValue = 0;

  @override
  void initState() {
    randomValue = next(10, 15);

    animation = Tween(begin: 1.0, end: 0.0).animate(widget.controller)
      ..addListener(() {
        setState(() {
          _progress = animation.value;
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    if (widget.controller != null) {
      widget.controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: SizedBox(
          width: 1,
          height: 35,
          child: CustomPaint(
            size: Size(1, 35),
            painter: LinePainter(_progress, widget.wideStep, randomValue),
          )),
    );
  }

  int next(int min, int max) => min + _random.nextInt(max - min);
}
