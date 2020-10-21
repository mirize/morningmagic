import 'package:flutter/material.dart';
import 'package:morningmagic/appLocalization.dart';
import 'package:morningmagic/db/model/app_and_custom_exercises/exercise_name.dart';

import 'exerciseDeskButton.dart';

class ExerciseMenu extends StatefulWidget {

  final List<ExerciseName> list;
  final VoidCallback _voidCallback;

  ExerciseMenu(this.list, this._voidCallback);

  @override
  ExerciseMenuState createState() {
    return ExerciseMenuState();
  }
}

class ExerciseMenuState extends State<ExerciseMenu> {

  List<Widget> createExerciseColumn(List<ExerciseName> items) {
    List<Widget> list = new List<Widget>();
    List<ExerciseName> listBuffer = new List<ExerciseName>();
    listBuffer.addAll(items);

    if (listBuffer.length % 2 == 0) {
      list = fillList(list, listBuffer);
    } else {
      ExerciseName exerciseName = listBuffer[listBuffer.length -1];
      listBuffer.removeAt(listBuffer.length -1);

      list = fillList(list, listBuffer);
      list.add(createSingleRow(exerciseName));
    }

    return list;
  }

  List<Widget> fillList(List<Widget> list, List<ExerciseName> items) {

    int sideCounter = 0;

    for (int i = 0; i < items.length;) {
      int buffer = i;
      list.add(createDoubleRow(
          items[buffer],
          items[buffer + 1],
          sideCounter % 2 == 0));
      sideCounter = ++sideCounter;
      print(sideCounter);
      i = i + 2;
    }

    return list;
  }

  Widget createSingleRow(ExerciseName exerciseName) {
    double sizeOne;
    if (exerciseName.size == null) {
      sizeOne = 14;
    } else {
      sizeOne = exerciseName.size;
    }

    Row row = new Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding:
              EdgeInsets.only(right: MediaQuery.of(context).size.width / 14),
          child: ExerciseDeskButton(
            id: exerciseName.id,
            text: exerciseName.size == null ? exerciseName.title : AppLocalizations.of(context).translate(exerciseName.title),
            size: sizeOne,
            list: widget.list,
            voidCallback: widget._voidCallback,
          ),
        ),
      ],
    );

    return row;
  }

  Widget createDoubleRow(ExerciseName exerciseNameOne, ExerciseName exerciseNameTwo, bool leftSide) {
    double sizeOne;
    double sizeTwo;

    if (exerciseNameOne.size == null) {
      sizeOne = 14;
    } else {
      sizeOne = exerciseNameOne.size;
    }

    if (exerciseNameTwo.size == null) {
      sizeTwo = 14;
    } else {
      sizeTwo = exerciseNameTwo.size;
    }

    Row row = new Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              right: leftSide ? MediaQuery.of(context).size.width / 14 : 0,
              left: leftSide ? 0 : MediaQuery.of(context).size.width / 7),
          child: ExerciseDeskButton(
            id: exerciseNameOne.id,
            text: exerciseNameOne.size == null ? exerciseNameOne.title : AppLocalizations.of(context).translate(exerciseNameOne.title),
            size: sizeOne,
            list: widget.list,
            voidCallback: widget._voidCallback,
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              right: leftSide ? MediaQuery.of(context).size.width / 7 : 0,
              left: leftSide ? 0 : MediaQuery.of(context).size.width / 14),
          child: ExerciseDeskButton(
            id: exerciseNameTwo.id,
            text: exerciseNameTwo.size == null ? exerciseNameTwo.title : AppLocalizations.of(context).translate(exerciseNameTwo.title),
            size: sizeTwo,
            list: widget.list,
            voidCallback: widget._voidCallback,
          ),
        ),
      ],
    );

    return row;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: createExerciseColumn(widget.list),
    );
  }
}
