import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:morningmagic/resources/colors.dart';

class ProgressPair extends StatelessWidget {

  final String exerciseTitle;
  final String exerciseValue;

  ProgressPair(this.exerciseTitle, this.exerciseValue);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            child: Text(
              exerciseTitle,
              style: TextStyle(
                fontFamily: 'sans-serif-black',
                fontSize: 16,
                color: AppColors.VIOLET,
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
          Container(
            child: Text(
                ' – '
            ),
          ),
          Flexible(
            child: Container(
              child: Text(
                exerciseValue,
                style: TextStyle(
                  fontFamily: 'sans-serif',
                  fontSize: 16,
                  color: AppColors.VIOLET,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}