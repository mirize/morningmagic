import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:morningmagic/db/model/app_and_custom_exercises/app_exercise_holder.dart';
import 'package:morningmagic/db/model/app_and_custom_exercises/custom_exercise_holder.dart';
import 'package:morningmagic/db/model/app_and_custom_exercises/exercise_name.dart';
import 'package:morningmagic/db/model/exercise/exercise_holder.dart';
import 'package:morningmagic/db/model/exercise/exercise_title.dart';
import 'package:morningmagic/db/model/progress/day/day.dart';
import 'package:morningmagic/db/model/progress/day/day_holder.dart';
import 'package:morningmagic/db/model/user_program/user_program.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/pages/exercises/dynamic/screenDynamicExEight.dart';
import 'package:morningmagic/pages/exercises/dynamic/screenDynamicExFive.dart';
import 'package:morningmagic/pages/exercises/dynamic/screenDynamicExFour.dart';
import 'package:morningmagic/pages/exercises/dynamic/screenDynamicExNine.dart';
import 'package:morningmagic/pages/exercises/dynamic/screenDynamicExOne.dart';
import 'package:morningmagic/pages/exercises/dynamic/screenDynamicExSeven.dart';
import 'package:morningmagic/pages/exercises/dynamic/screenDynamicExSix.dart';
import 'package:morningmagic/pages/exercises/dynamic/screenDynamicExTen.dart';
import 'package:morningmagic/pages/exercises/dynamic/screenDynamicExThree.dart';
import 'package:morningmagic/pages/exercises/dynamic/screenDynamicExTwo.dart';
import 'package:morningmagic/pages/exercises/user_custom/screenDynamicCustomExercise.dart';
import 'package:morningmagic/pages/success/screenTimerSuccess.dart';
import 'package:morningmagic/utils/reordering_util.dart';
import 'package:random_string/random_string.dart';

class ExerciseUtils {
  Box box;

  void chooseExerciseAndRoute(BuildContext context, String exerciseName) {
    if (equalsIgnoreCase(exerciseName, "Потягивания") ||
        equalsIgnoreCase(exerciseName, "Stretching")) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => DynamicExerciseOneScreen()));
    } else if (equalsIgnoreCase(exerciseName, "Шаги на месте") ||
        equalsIgnoreCase(exerciseName, "March in Place")) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => DynamicExerciseTwoScreen()));
    } else if (equalsIgnoreCase(exerciseName, "Перекаты с носков на пятки") ||
        equalsIgnoreCase(exerciseName, "Heel and Toe Raises")) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DynamicExerciseThreeScreen()));
    } else if (equalsIgnoreCase(exerciseName, "Вращения") ||
        equalsIgnoreCase(exerciseName, "Rotations")) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => DynamicExerciseFourScreen()));
    } else if (equalsIgnoreCase(
            exerciseName, "Попеременные\nнаклоны и приседания") ||
        equalsIgnoreCase(exerciseName, "Alternating\nbend and squats")) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => DynamicExerciseFiveScreen()));
    } else if (equalsIgnoreCase(exerciseName, "Наклоны в стороны") ||
        equalsIgnoreCase(exerciseName, "Standing Side Bend")) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => DynamicExerciseSixScreen()));
    } else if (equalsIgnoreCase(
            exerciseName, "Попеременное\nподтягивание ног") ||
        equalsIgnoreCase(exerciseName, "Bicycle Crunch")) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DynamicExerciseSevenScreen()));
    } else if (equalsIgnoreCase(exerciseName, "«Кошечка»") ||
        equalsIgnoreCase(exerciseName, "Cat and Dog")) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DynamicExerciseEightScreen()));
    } else if (equalsIgnoreCase(exerciseName, "Отжимания") ||
        equalsIgnoreCase(exerciseName, "Press Up")) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => DynamicExerciseNineScreen()));
    } else if (equalsIgnoreCase(exerciseName, "Потягивания ") ||
        equalsIgnoreCase(exerciseName, "Hand stretching")) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => DynamicExerciseTenScreen()));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DynamicCustomExercise(exerciseName)));
      print("Custom user exercise !!!");
    }
  }

  Future<Box> initAndGetBox() async {
    await Hive.initFlutter();
    return await Hive.openBox(Resource.BOX_NAME);
  }

  Future<Box> openMyBox() async {
    return await Hive.openBox(Resource.BOX_NAME);
  }

  Future<void> deleteAllProgress() async {
    box = await openMyBox();

    if (box == null) {
      box = await initAndGetBox();
      box.put(Resource.DAYS_HOLDER, DayHolder(List<Day>()));
    } else {
      box.put(Resource.DAYS_HOLDER, DayHolder(List<Day>()));
    }
  }

  Future<void> deleteSelectedExerciseFromDB(String key) async {
    box = await openMyBox();

    if (box == null) {
      box = await initAndGetBox();

      ExerciseHolder holder = box.get(Resource.EXERCISES_HOLDER);
      if (holder != null) {
        removeItem(holder, key);
      }
      box.put(Resource.EXERCISES_HOLDER, holder);
    } else {
      ExerciseHolder holder = box.get(Resource.EXERCISES_HOLDER);
      if (holder != null) {
        removeItem(holder, key);
      }
      box.put(Resource.EXERCISES_HOLDER, holder);
    }
  }

  Future<void> deleteSelectedExerciseProgramFromDB(String key) async {
    box = await openMyBox();

    if (box == null) {
      box = await initAndGetBox();

      UserProgram program = box.get(Resource.USER_PROGRAM_HOLDER);
      if (program != null) {
        removeItemProgram(program, key);
      }
      box.put(Resource.USER_PROGRAM_HOLDER, program);
    } else {
      UserProgram program = box.get(Resource.USER_PROGRAM_HOLDER);
      if (program != null) {
        removeItemProgram(program, key);
      }
      box.put(Resource.USER_PROGRAM_HOLDER, program);
    }
  }

  void removeItemProgram(UserProgram program, String key) {
    for (int i = 0; i < program.exercises.length; i++) {
      if (key == program.exercises[i].key) {
        program.exercises.removeAt(i);
        break;
      }
    }
  }

  void removeItem(ExerciseHolder holder, String key) {
    for (int i = 0; i < holder.freshExercises.length; i++) {
      if (key == holder.freshExercises[i].key) {
        holder.freshExercises.removeAt(i);
        break;
      }
    }
  }

  Future<void> saveCustomExerciseToDB(ExerciseName exerciseName) async {
    box = await openMyBox();

    if (box == null) {
      box = await initAndGetBox();
      saveCustomExercise(exerciseName);
    } else {
      saveCustomExercise(exerciseName);
    }
  }

  void saveCustomExercise(ExerciseName exerciseName) {
    CustomExerciseHolder customExerciseHolder = box.get(
        Resource.CUSTOM_EXERCISES_HOLDER,
        defaultValue: CustomExerciseHolder(List<ExerciseName>()));

    customExerciseHolder.list.add(exerciseName);

    box.put(Resource.CUSTOM_EXERCISES_HOLDER, customExerciseHolder);
  }

  Future<void> deleteCustomExerciseFromDB(ExerciseName exerciseName) async {
    box = await openMyBox();

    if (box == null) {
      box = await initAndGetBox();
      deleteCustomExercise(exerciseName);
    } else {
      deleteCustomExercise(exerciseName);
    }
  }

  void deleteCustomExercise(ExerciseName exerciseName) {
    CustomExerciseHolder customExerciseHolder =
        box.get(Resource.CUSTOM_EXERCISES_HOLDER);

    if (customExerciseHolder != null) {
      for (int i = 0; i < customExerciseHolder.list.length; i++) {
        if (customExerciseHolder.list[i].id == exerciseName.id) {
          customExerciseHolder.list.removeAt(i);
          break;
        }
      }
    }

    box.put(Resource.CUSTOM_EXERCISES_HOLDER, customExerciseHolder);
  }

  void goNextRoute(BuildContext context) {
    openMyBox().then((value) {
      box = value;

      if (box == null) {
        initAndGetBox().then((value) {
          box = value;
          nextRoute(context);
        });
      } else {
        nextRoute(context);
      }
    });
  }

  void saveExercisesNames(Box box) {
    AppExerciseHolder appExerciseHolder = box.get(Resource.APP_EXERCISES_HOLDER,
        defaultValue: AppExerciseHolder(List<ExerciseName>()));

    if (appExerciseHolder.list.length == 0) {
      appExerciseHolder.list
          .add(ExerciseName(randomAlpha(10), "exercise_1_title", 14));
      appExerciseHolder.list
          .add(ExerciseName(randomAlpha(10), "exercise_2_title", 14));
      appExerciseHolder.list
          .add(ExerciseName(randomAlpha(10), "exercise_3_title", 11));
      appExerciseHolder.list
          .add(ExerciseName(randomAlpha(10), "exercise_4_title", 14));
      appExerciseHolder.list
          .add(ExerciseName(randomAlpha(10), "exercise_5_title", 11));
      appExerciseHolder.list
          .add(ExerciseName(randomAlpha(10), "exercise_6_title", 11));
      appExerciseHolder.list
          .add(ExerciseName(randomAlpha(10), "exercise_7_title", 11));
      appExerciseHolder.list
          .add(ExerciseName(randomAlpha(10), "exercise_8_title", 14));
      appExerciseHolder.list
          .add(ExerciseName(randomAlpha(10), "exercise_9_title", 14));
      appExerciseHolder.list
          .add(ExerciseName(randomAlpha(10), "exercise_10_title", 14));

      print("APP EXERCISES SAVED !!!");

      box.put(Resource.APP_EXERCISES_HOLDER, appExerciseHolder);
    }
  }

  void goPreviousRoute() async {
    box = await openMyBox();
    if (box == null) {
      box = await initAndGetBox();
      moveRouteToFresh();
    } else {
      moveRouteToFresh();
    }
  }

  void moveRouteToFresh() {
    ExerciseHolder holder = box.get(Resource.EXERCISES_HOLDER);
    if (holder != null && holder.skipExercises.length > 0) {
      int index = holder.skipExercises.length - 1;
      ExerciseTitle last = holder.skipExercises[index];
      holder.skipExercises.removeAt(index);
      holder.freshExercises.insert(0, last);
    }
  }

  void nextRoute(BuildContext context) {
    ExerciseHolder holder = box.get(Resource.EXERCISES_HOLDER);
    if (holder != null && holder.freshExercises.length > 0) {
      ExerciseTitle first = holder.freshExercises.first;
      holder.freshExercises.removeAt(0);
      holder.skipExercises.add(first);

      box.put(Resource.EXERCISES_HOLDER, holder);

      chooseExerciseAndRoute(context, first.title);
    } else if (holder != null &&
        holder.freshExercises.length == 0 &&
        holder.skipExercises.length > 0) {
      OrderUtil().getRouteById(2).then((value) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TimerSuccessScreen(() {
                      Navigator.push(context, value);
                    })));
      });
    }
  }

  bool equalsIgnoreCase(String a, String b) =>
      (a == null && b == null) ||
      (a != null && b != null && a.toLowerCase() == b.toLowerCase());
}
