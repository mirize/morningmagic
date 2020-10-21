import 'dart:async';

import 'package:flutter/material.dart';
import 'package:morningmagic/appLocalization.dart';
import 'package:morningmagic/db/model/exercise_time/exercise_time.dart';
import 'package:morningmagic/db/model/progress/day/day.dart';
import 'package:morningmagic/db/model/progress/fitness_porgress/fitness_progress.dart';
import 'package:morningmagic/db/progress.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:morningmagic/utils/string_util.dart';


Timer timer;

class TimerAppBar extends StatefulWidget {

  final String exerciseName;
  final TimeAppBarState timeAppBarState = TimeAppBarState();

  TimerAppBar(this.exerciseName);

  @override
  TimeAppBarState createState() {
    return timeAppBarState;
  }

  void cancelTimer() {
    timer.cancel();
    timeAppBarState.saveFitnessProgress();
  }
}

class TimeAppBarState extends State<TimerAppBar> {

  int _time;
  int _startValue;
  Box box;

  String time;
  @override
  void initState() {
    openMyBox().then((value) {
      box = value;
      if (box == null) {
        initAndGet().then((value) {
          ExerciseTime time = box.get(Resource.FITNESS_TIME_KEY, defaultValue: ExerciseTime(3));
          _time = time.time * 60;
          _startValue = time.time * 60;
          startTimer();
        });
      } else {
        ExerciseTime time = box.get(Resource.FITNESS_TIME_KEY, defaultValue: ExerciseTime(3));
        _time = time.time * 60;
        _startValue = time.time * 60;
        startTimer();
      }
    });
    super.initState();
  }

  Future<Box> initAndGet() async {
    await Hive.initFlutter();
    return await Hive.openBox(Resource.BOX_NAME);
  }

  Future<Box> openMyBox() async {
    return await Hive.openBox(Resource.BOX_NAME);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          color: AppColors.VIOLET,
        ),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 5),
                child: Text(
                  AppLocalizations.of(context).translate("timer"),
                  style: TextStyle(
                      color: AppColors.WHITE,
                      fontSize: 14,
                      fontFamily: "rex",
                      fontStyle: FontStyle.normal
                  ),
                ),
              ),
              Text(
                StringUtil().createTimeAppBarString(_time),
                style: TextStyle(
                    color: AppColors.WHITE,
                    fontSize: 27,
                    fontFamily: "aparaj",
                    fontStyle: FontStyle.normal
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  int getPassedSeconds() {
    int result = _startValue - _time;
    if (_startValue != null && _time != null) {
      result = _startValue - _time;
    }
    return result ;
  }

  void saveFitnessProgress() {
    if (getPassedSeconds() > 0) {
      FitnessProgress fitness = FitnessProgress(getPassedSeconds(), widget.exerciseName);
      Day day = ProgressUtil().createDay(null, null, fitness, null, null, null, null);
      ProgressUtil().updateDayList(day);
      _time = _startValue;
    }
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    if (timer == null || !timer.isActive) {
      timer = Timer.periodic(
          oneSec,
              (Timer timer) => setState(() {
            if (_time < 1) {
              timer.cancel();
              saveFitnessProgress();
            } else {
              _time = _time - 1;
              print(_time);
            }
          }));
    } else if (timer != null && timer.isActive) {
      timer.cancel();
    }
  }

  void cancelTimer() {
    if (timer != null) {
      timer.cancel();
    }
  }

  @override
  void dispose() {
    super.dispose();
    cancelTimer();
  }
}