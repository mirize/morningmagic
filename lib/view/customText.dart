import 'package:flutter/material.dart';
import 'package:morningmagic/resources/colors.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;


  CustomText({
    @required this.text,
    @required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: AppColors.WHITE,
        fontStyle: FontStyle.normal,
        fontFamily: 'rex',
        fontSize: size,
      ),
    );
  }
}