import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'line.dart';

List<Line> linesList;

class LineBox extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LineBoxState();
  }

  void stopAnimation() {
    for (int i = 0; i < linesList.length; i++) {
      linesList[i].getController().stop();
    }
  }

  void playAnimation() {
    for (int i = 0; i < linesList.length; i++) {
      linesList[i].getController().repeat(reverse: true);
    }
  }
}

class LineBoxState extends State<LineBox> with TickerProviderStateMixin {
  final _random = new Random();

  @override
  void initState() {
    linesList = createLines();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: linesList,
      ),
    );
  }

  List<Line> createLines() {
    List<Line> list = List();

    double wideStep = 0;

    for (int i = 0; i < 21; i++) {
      wideStep = wideStep + 6;

      AnimationController controller = AnimationController(
          duration: Duration(milliseconds: next(500, 1000)), vsync: this);
      list.add(Line(wideStep, controller));
    }

    return list;
  }

  int next(int min, int max) => min + _random.nextInt(max - min);
}
