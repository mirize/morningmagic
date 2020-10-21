import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:morningmagic/db/model/exercise_time/exercise_time.dart';
import 'package:morningmagic/db/model/progress/day/day.dart';
import 'package:morningmagic/db/model/progress/meditation_progress/meditation_progress.dart';
import 'package:morningmagic/db/progress.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/pages/success/screenTimerSuccess.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/utils/reordering_util.dart';
import 'package:morningmagic/utils/string_util.dart';
import 'package:morningmagic/view/customStartSkipColumn.dart';
import 'package:morningmagic/view/custom_progress_bar/circleProgressBar.dart';

import '../../appLocalization.dart';
import '../screenFitnessProgram.dart';

class TimerMeditationScreen extends StatefulWidget {
  @override
  State createState() {
    return TimerMeditationScreenState();
  }
}

class TimerMeditationScreenState extends State<TimerMeditationScreen> {
  Timer _timer;
  int _time;
  int _startTime;
  int _startValue;
  bool timerSwitch = false;
  String buttonText;

  Box box;

  bool isInitialized = false;

  Future<int> getTime() async {
    await Hive.initFlutter();
    box = await Hive.openBox(Resource.BOX_NAME);
    ExerciseTime time =
        box.get(Resource.MEDITATION_TIME_KEY, defaultValue: ExerciseTime(0));
    return time.time;
  }

  @override
  void initState() {
    super.initState();
    getTime().then((int value) {
      _time = value * 60;
      _startTime = value;
      _startValue = value * 60;
      startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isInitialized) {
      isInitialized = true;
      buttonText = AppLocalizations.of(context).translate("start");
    }
    return SafeArea(
        child: WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Container(
                width: MediaQuery.of(context)
                    .size
                    .width, // match parent(all screen)
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.TOP_GRADIENT,
                    AppColors.MIDDLE_GRADIENT,
                    AppColors.BOTTOM_GRADIENT
                  ],
                )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 6),
                        child: Container(
                          child: Visibility(
                            visible: timerSwitch,
                            maintainSize: true,
                            maintainAnimation: true,
                            maintainState: true,
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate("timer_started"),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'rex',
                                  fontSize: 25,
                                  color: AppColors.WHITE),
                            ),
                          ),
                        )),
                    Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 19),
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: CircleProgressBar(
                        text: StringUtil().createTimeString(_time),
                        foregroundColor: AppColors.WHITE,
                        value: createValue(),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 30),
                      child: StartSkipColumn(() {
                        startTimer();
                      }, () {
                        if (_timer != null && _timer.isActive) {
                          buttonText =
                              AppLocalizations.of(context).translate("start");
                          _timer.cancel();
                        }
                        saveMeditationProgress();
                        OrderUtil().getRouteById(1).then((value) {
                          Navigator.push(context, value);
                        });
                      }, () {
                        _timer.cancel();
                        saveMeditationProgress();
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/start', (r) => false);
                      }, buttonText),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      )),
    ));
  }

  int getPassedSeconds() {
    return _startValue - _time;
  }

  void saveMeditationProgress() {
    if (getPassedSeconds() > 0) {
      MeditationProgress meditation = MeditationProgress(getPassedSeconds());
      Day day = ProgressUtil()
          .createDay(null, meditation, null, null, null, null, null);
      ProgressUtil().updateDayList(day);
      _time = _startValue;
    }
  }

  Future<bool> _onWillPop() async {
    saveMeditationProgress();
    if (_timer != null) {
      _timer.cancel();
    }
    return true;
  }

  double createValue() {
    if (_startTime != null) {
      return 1 - _time / (_startTime * 60);
    } else {
      return 0;
    }
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    if (_timer == null || !_timer.isActive) {
      setState(() {
        timerSwitch = true;
        buttonText = AppLocalizations.of(context).translate("stop");
      });
      _timer = Timer.periodic(
          oneSec,
          (Timer timer) => setState(() {
                if (_time < 1) {
                  timer.cancel();
                  saveMeditationProgress();
                  buttonText = AppLocalizations.of(context).translate("start");
                  OrderUtil().getRouteById(1).then((value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TimerSuccessScreen(() {
                            Navigator.push(context, value);
                          }),
                        ));
                  });
                } else {
                  _time = _time - 1;
                  print(_time);
                }
              }));
    } else if (_timer != null && _timer.isActive) {
      _timer.cancel();
      setState(() {
        timerSwitch = false;
        buttonText = AppLocalizations.of(context).translate("start");
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }
}
