import 'package:flutter/material.dart';
import 'package:morningmagic/resources/colors.dart';

import 'arcProgressBarPainter.dart';

class ArcProgressBar extends StatelessWidget {
  final String text;

  const ArcProgressBar({
    Key key,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: CustomPaint(
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 45,
              fontFamily: "rex",
              fontStyle: FontStyle.normal,
              color: AppColors.LIGHT_VIOLET,
            ),
          ),
        ),
        foregroundPainter: ArcProgressBarPainter(),
      ),
    );
  }
}