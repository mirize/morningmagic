import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:morningmagic/appLocalization.dart';
import 'package:morningmagic/db/model/affirmation_text/affirmation_text.dart';
import 'package:morningmagic/db/model/exercise_time/exercise_time.dart';
import 'package:morningmagic/db/model/progress/affirmation_progress/affirmation_progress.dart';
import 'package:morningmagic/db/model/progress/day/day.dart';
import 'package:morningmagic/db/progress.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/pages/success/screenTimerSuccess.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/utils/reordering_util.dart';
import 'package:morningmagic/utils/string_util.dart';
import 'package:morningmagic/view/customStartSkipColumn.dart';
import 'package:morningmagic/view/customText.dart';
import 'package:morningmagic/view/custom_progress_bar/circleProgressBar.dart';

class TimerAffirmationScreen extends StatefulWidget {
  @override
  StatefulElement createElement() {
    return super.createElement();
  }

  @override
  State createState() {
    return TimerAffirmationScreenState();
  }
}

class TimerAffirmationScreenState extends State<TimerAffirmationScreen> {
  Timer _timer;
  int _time;
  int _startTime;
  int _startValue;
  String affirmationText;

  String buttonText;

  Box box;

  bool isInitialized = false;

  Future<int> getTimeAndText() async {
    await Hive.initFlutter();

    box = await Hive.openBox(Resource.BOX_NAME);
    ExerciseTime time =
        box.get(Resource.AFFIRMATION_TIME_KEY, defaultValue: ExerciseTime(0));

    AffirmationText text = box.get(Resource.AFFIRMATION_TEXT_KEY,
        defaultValue: AffirmationText(""));
    affirmationText = text.affirmationText;
    return time.time;
  }

  @override
  void initState() {
    super.initState();
    getTimeAndText().then((int value) {
      _time = value * 60;
      _startValue = value * 60;
      _startTime = value;
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
      child: Scaffold(
        body: LayoutBuilder(
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
                            top: MediaQuery.of(context).size.height / 5),
                        child: getAffirmationWidget(),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 14.3),
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
                          saveAffirmationProgress();
                          OrderUtil().getRouteById(0).then((value) {
                            Navigator.push(context, value);
                          });
                        }, () {
                          _timer.cancel();
                          saveAffirmationProgress();
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
        ),
      ),
    ));
  }

  int getPassedSeconds() {
    return _startValue - _time;
  }

  Widget getAffirmationWidget() {
    if (affirmationText != null) {
      return Container(
        padding: EdgeInsets.only(left: 5, right: 5),
        child: CustomText(
          text: affirmationText,
          size: 22,
        ),
      );
    } else {
      return Container();
    }
  }

  void saveAffirmationProgress() {
    if (getPassedSeconds() > 0) {
      AffirmationProgress affirmation =
          AffirmationProgress(getPassedSeconds(), affirmationText);
      Day day = ProgressUtil()
          .createDay(affirmation, null, null, null, null, null, null);
      ProgressUtil().updateDayList(day);
      _time = _startValue;
    }
  }

  Future<bool> _onWillPop() async {
    saveAffirmationProgress();
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
        buttonText = AppLocalizations.of(context).translate("stop");
      });
      _timer = Timer.periodic(
          oneSec,
          (Timer timer) => setState(() {
                if (_time < 1) {
                  timer.cancel();
                  saveAffirmationProgress();
                  buttonText = AppLocalizations.of(context).translate("start");
                  OrderUtil().getRouteById(0).then((value) {
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
