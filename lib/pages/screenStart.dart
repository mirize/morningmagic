import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:morningmagic/appLocalization.dart';
import 'package:morningmagic/db/model/exercise/exercise_holder.dart';
import 'package:morningmagic/db/model/exercise/exercise_title.dart';
import 'package:morningmagic/db/model/progress/day/day_holder.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/pages/screenFAQ.dart';
import 'package:morningmagic/pages/screenProgress.dart';
import 'package:morningmagic/pages/screenSelectSequence.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/utils/reordering_util.dart';
import 'package:morningmagic/view/animatedButton.dart';

import '../askedQuestionsScreen.dart';

class StartScreen extends StatefulWidget {
  @override
  State createState() {
    return StartScreenState();
  }
}

class StartScreenState extends State<StartScreen> {
  int dayHolderSize;

  @override
  void initState() {
    getDayHolderSize().then((int value) {
      dayHolderSize = value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            width:
                MediaQuery.of(context).size.width, // match parent(all screen)
            height:
                MediaQuery.of(context).size.height, // match parent(all screen)
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
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                AnimatedButton(() {
                  OrderUtil().getRouteByPositionInList(0).then((value) {
                    Navigator.push(context, value);
                  });
                },
                    'sans-serif',
                    AppLocalizations.of(context).translate("start"),
                    null,
                    null,
                    null),
                Positioned(
                  bottom: (MediaQuery.of(context).size.height / 2) -
                      (MediaQuery.of(context).size.height / 2 / 3.3),
                  child: AnimatedButton(() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => choseWidget()));
                  },
                      "sans-serif",
                      AppLocalizations.of(context).translate("progress_item"),
                      null,
                      null,
                      null),
                ),
                Positioned(
                  bottom: (MediaQuery.of(context).size.height / 2) -
                      (MediaQuery.of(context).size.height / 2 / 2),
                  child: AnimatedButton(() {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelectSequenceScreen()));
                  },
                      "sans-serif",
                      AppLocalizations.of(context).translate("settings"),
                      null,
                      null,
                      null),
                ),
                Positioned(
                  bottom: (MediaQuery.of(context).size.height / 2) -
                      (MediaQuery.of(context).size.height / 2 / 1.4),
                  child: AnimatedButton(() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FAQScreen()));
                  },
                      "sans-serif",
                      AppLocalizations.of(context).translate("faq"),
                      null,
                      null,
                      null),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<int> getDayHolderSize() async {
    await Hive.initFlutter();
    Box box = await Hive.openBox(Resource.BOX_NAME);

    clearExercisesHolder(box);
    DayHolder dayHolder = box.get(Resource.DAYS_HOLDER);
    if (dayHolder != null) {
      return dayHolder.listOfDays.length;
    } else {
      return 0;
    }
  }

  void clearExercisesHolder(Box box) {
    print("clear EXERCISE HOLDER");

    box.put(Resource.EXERCISES_HOLDER,
        ExerciseHolder(List<ExerciseTitle>(), List<ExerciseTitle>()));
  }

  Widget choseWidget() {
    if (dayHolderSize != null && dayHolderSize > 0) {
      return AskedQuestionsScreen();
    } else {
      return ProgressScreen();
    }
  }
}
