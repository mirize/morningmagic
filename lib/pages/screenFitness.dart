import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:morningmagic/appLocalization.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:morningmagic/db/model/app_and_custom_exercises/app_exercise_holder.dart';
import 'package:morningmagic/db/model/app_and_custom_exercises/custom_exercise_holder.dart';
import 'package:morningmagic/db/model/app_and_custom_exercises/exercise_name.dart';
import 'package:morningmagic/db/model/exercise/exercise_holder.dart';
import 'package:morningmagic/db/model/exercise/exercise_title.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/dialog/exerciseDialog.dart';
import 'package:morningmagic/pages/screenExerciseDesk.dart';
import 'package:morningmagic/pages/exercises/stanrart/screenExerciseOne.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/toastUtils.dart';
import 'package:morningmagic/utils/progress_util.dart';
import 'package:morningmagic/view/animatedButton.dart';
import 'package:morningmagic/view/exerciseMenu.dart';

class FitnessScreen extends StatefulWidget {
  @override
  State createState() {
    return FitnessScreenState();
  }
}

class FitnessScreenState extends State<FitnessScreen> {
  Box box;
  List<ExerciseName> appExercises;
  List<ExerciseName> customExercises;
  List<ExerciseName> allExercises;

  @override
  void initState() {
    openMyBox().then((value) {
      box = value;

      if (box == null) {
        initAndGetBox().then((value) {
          box = value;
          init(box);
        });
      } else {
        init(box);
      }
    });
    super.initState();
  }

  void init(Box box) {
    ExerciseUtils().saveExercisesNames(box);

    allExercises = new List<ExerciseName>();

    AppExerciseHolder appExerciseHolder =
        box.get(Resource.APP_EXERCISES_HOLDER);
    appExercises = appExerciseHolder.list;
    CustomExerciseHolder customExerciseHolder = box.get(
        Resource.CUSTOM_EXERCISES_HOLDER,
        defaultValue: CustomExerciseHolder(List<ExerciseName>()));
    customExercises = customExerciseHolder.list;

    allExercises.addAll(appExercises);
    allExercises.addAll(customExercises);

    print(customExercises);
  }

  Future<List<ExerciseName>> initExerciseList() async {
    box = await openMyBox();
    if (box == null) {
      box = await initAndGetBox();
    }

    ExerciseUtils().saveExercisesNames(box);
    List<ExerciseName> allList = new List<ExerciseName>();
    List<ExerciseName> appExercisesList = new List<ExerciseName>();
    List<ExerciseName> customExercisesList = new List<ExerciseName>();

    AppExerciseHolder appExerciseHolder =
        box.get(Resource.APP_EXERCISES_HOLDER);
    appExercisesList = appExerciseHolder.list;
    CustomExerciseHolder customExerciseHolder = box.get(
        Resource.CUSTOM_EXERCISES_HOLDER,
        defaultValue: CustomExerciseHolder(List<ExerciseName>()));
    customExercisesList = customExerciseHolder.list;

    allList.addAll(appExercisesList);
    allList.addAll(customExercisesList);

    print(customExercisesList);

    return allList;
  }

  Future<Box> initAndGetBox() async {
    await Hive.initFlutter();
    return await Hive.openBox(Resource.BOX_NAME);
  }

  Future<Box> openMyBox() async {
    return await Hive.openBox(Resource.BOX_NAME);
  }

  Future<bool> _onWillPop() async {
    clearExercisesHolder();
    return true;
  }

  void clearExercisesHolder() {
    List<ExerciseTitle> skip = List<ExerciseTitle>();
    List<ExerciseTitle> fresh = List<ExerciseTitle>();

    openMyBox().then((value) {
      box = value;
      if (box == null) {
        initAndGetBox().then((value) {
          box = value;

          box.put(Resource.EXERCISES_HOLDER, ExerciseHolder(fresh, skip));
        });
      } else {
        box.put(Resource.EXERCISES_HOLDER, ExerciseHolder(fresh, skip));
      }
    });
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
                Positioned(
                  bottom: (MediaQuery.of(context).size.height / 2),
                  child: Text(
                    AppLocalizations.of(context).translate("fitness"),
                    style: TextStyle(
                      fontSize: 32,
                      fontStyle: FontStyle.normal,
                      fontFamily: "rex",
                      color: AppColors.WHITE,
                    ),
                  ),
                ),
                Positioned(
                  bottom: (MediaQuery.of(context).size.height / 2) -
                      (MediaQuery.of(context).size.height / 2 / 2.1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(bottom: 25),
                        child: AnimatedButton(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ExerciseOneScreen()));
                        },
                            'rex',
                            AppLocalizations.of(context)
                                .translate("fitness_program"),
                            20,
                            220,
                            null),
                      ),
                      AnimatedButton(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ExerciseDeskScreen()));
                      },
                          'rex',
                          AppLocalizations.of(context)
                              .translate("fitness_my_program"),
                          20,
                          220,
                          null),
                      // Container(
                      //   padding: EdgeInsets.only(top: 15),
                      //   child: AnimatedButton(() {
                      //     goNextPage();
                      //   },
                      //       'rex',
                      //       AppLocalizations.of(context)
                      //           .translate("start_fitness_my_program"),
                      //       20,
                      //       220,
                      //       null),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openDialog() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return ExerciseDialog(TextEditingController(), () {
            Navigator.pop(context, true);
          }, () {
            setState(() {});
          }, allExercises);
        });
  }

  void goNextPage() {
    openMyBox().then((value) {
      box = value;

      if (box == null) {
        initAndGetBox().then((value) {
          box = value;
          saveDataToBox();
        });
      } else {
        saveDataToBox();
      }
    });
  }

  void saveDataToBox() {
    ExerciseHolder holder = box.get(Resource.EXERCISES_HOLDER);
    print(holder);

    if (holder != null && holder.freshExercises.length > 0) {
      ExerciseTitle first = holder.freshExercises.first;
      holder.freshExercises.removeAt(0);
      holder.skipExercises.add(first);

      box.put(Resource.EXERCISES_HOLDER, holder);
      ExerciseUtils().chooseExerciseAndRoute(context, first.title);
    } else {
      ToastUtils.showCustomToast(
          context, AppLocalizations.of(context).translate("add_exercise"));
    }
    box = null;
  }

  void clearExerciseHolder() {
    List<ExerciseTitle> skip = List<ExerciseTitle>();
    List<ExerciseTitle> fresh = List<ExerciseTitle>();

    box.put(Resource.EXERCISES_HOLDER, new ExerciseHolder(fresh, skip));
  }
}
