import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:morningmagic/db/model/exercise/exercise_holder.dart';
import 'package:morningmagic/db/model/exercise/exercise_title.dart';
import 'package:morningmagic/db/model/user_program/user_program.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/view/exerciseDeskButton.dart';
import 'package:random_string/random_string.dart';

import 'exerciseTrashButton.dart';

class ExerciseDragTarget extends StatefulWidget {
  @override
  ExerciseDragTargetState createState() {
    return ExerciseDragTargetState();
  }
}

class ExerciseDragTargetState extends State<ExerciseDragTarget> {
  Box box;

  @override
  void initState() {
    openMyBox().then((value) {
      box = value;
      if (box == null) {
        initAndGetBox().then((value) {
          box = value;
        });
      }
    });
    super.initState();
  }

  Future<Box> initAndGetBox() async {
    await Hive.initFlutter();
    return await Hive.openBox(Resource.BOX_NAME);
  }

  Future<Box> openMyBox() async {
    return await Hive.openBox(Resource.BOX_NAME);
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget(
      builder: (BuildContext context, List<ExerciseDeskTag> candidateData,
          List<dynamic> rejectedData) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.2,
                    bottom: MediaQuery.of(context).size.width * 0.2),
                decoration: BoxDecoration(
                    color: candidateData.isEmpty
                        ? AppColors.TRANSPARENT
                        : AppColors.TRANSPARENT_WHITE),
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  mainAxisSize: MainAxisSize.min,
//                  children: getTrashButtonsList(),
//                ),
                  child: FutureBuilder(
                    future: getTrashButtonsList(),
                    builder: (BuildContext context, AsyncSnapshot<List<ExerciseTrashTag>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          print(snapshot.error);
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: snapshot.data,
                        );
                      } else {
                        print("EMPTY !!!");
                        return Container();
                      }
                    },
                  )
              ),
            ),
          ],
        );
      },
      onAccept: (ExerciseDeskTag button) {
        print(button.text);
        saveExerciseToHolder(button);
        saveExerciseProgram(button);

        setState(() {});
      },
    );
  }

//  List<ExerciseTrashTag> getTrashButtonsList() {
//    List<ExerciseTrashTag> list = new List<ExerciseTrashTag>();
//    if (box == null) {
//      print("BOX +++ NULL");
//      return list;
//    }
//    ExerciseHolder holder = box.get(Resource.EXERCISES_HOLDER,
//        defaultValue:
//            new ExerciseHolder(List<ExerciseTitle>(), List<ExerciseTitle>()));
//
//    for (int i = 0; i < holder.freshExercises.length; i++) {
//      list.add(new ExerciseTrashTag(holder.freshExercises[i].title,
//          holder.freshExercises[i].size, holder.freshExercises[i].key, () {
//        setState(() {});
//      }));
//    }
//
//    return list;
//  }

  List<ExerciseTrashTag> doStuff() {
    List<ExerciseTrashTag> list = new List<ExerciseTrashTag>();
    UserProgram program = box.get(Resource.USER_PROGRAM_HOLDER,
        defaultValue: UserProgram(List<ExerciseTitle>()));

    ExerciseHolder holder = box.get(Resource.EXERCISES_HOLDER,
        defaultValue:
        new ExerciseHolder(List<ExerciseTitle>(), List<ExerciseTitle>()));

    holder.freshExercises.clear();
    holder.freshExercises.addAll(program.exercises);

    for (int i = 0; i < holder.freshExercises.length; i++) {
      list.add(new ExerciseTrashTag(holder.freshExercises[i].title,
          holder.freshExercises[i].size, holder.freshExercises[i].key, () {
            setState(() {});
          }));
    }
    return list;
  }

  Future<List<ExerciseTrashTag>> getTrashButtonsList() async {
    List<ExerciseTrashTag> list = List<ExerciseTrashTag>();

    box = await openMyBox();

    if (box == null) {
      box = await initAndGetBox();
      list = doStuff();
    } else {
      list = doStuff();
    }
//    openMyBox().then((value) {
//      box = value;
//      if (box == null) {
//        initAndGetBox().then((value) {
//          box = value;
//          list = doStuff();
//        });
//      } else {
//        list = doStuff();
//      }
//    });

    return list;
  }

  void saveExerciseToHolder(ExerciseDeskTag button) {
    ExerciseHolder holder = box.get(Resource.EXERCISES_HOLDER,
        defaultValue:
            new ExerciseHolder(List<ExerciseTitle>(), List<ExerciseTitle>()));

    String key = randomAlpha(5);
    holder.freshExercises.add(ExerciseTitle(button.text, button.size, key));

    print("FRESH " + holder.freshExercises.length.toString());
    print(holder.freshExercises.toString());

    box.put(Resource.EXERCISES_HOLDER, holder);
  }

  void saveExerciseProgram(ExerciseDeskTag button) {
    UserProgram program = box.get(Resource.USER_PROGRAM_HOLDER,
        defaultValue: new UserProgram(List<ExerciseTitle>()));

    String key = randomAlpha(5);
    program.exercises.add(ExerciseTitle(button.text, button.size, key));

    box.put(Resource.USER_PROGRAM_HOLDER, program);
  }
}
