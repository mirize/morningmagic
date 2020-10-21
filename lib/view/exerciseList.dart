import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:morningmagic/db/model/exercise/exercise_holder.dart';
import 'package:morningmagic/db/model/exercise/exercise_title.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/view/exerciseTrashButton.dart';

//class ExerciseList extends StatefulWidget {
//
//  @override
//  ExerciseListState createState() {
//    return ExerciseListState();
//  }
//}
//
//class ExerciseListState extends State<ExerciseList> {
//
//  Box box;
//
//  @override
//  void initState() {
//    super.initState();
//  }
//
//  Future<Box> initAndGetBox() async {
//    await Hive.initFlutter();
//    return await Hive.openBox(Resource.BOX_NAME);
//  }
//
//  Future<Box> openMyBox() async {
//    return await Hive.openBox(Resource.BOX_NAME);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      width: MediaQuery.of(context).size.width * 0.4,
//      child: createColumnWidget(),
//    );
//  }
//
//  Widget createColumnWidget() {
//    return Container(
//      padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.21,
//          bottom: MediaQuery.of(context).size.width * 0.18),
//      child: FutureBuilder(
//        future: getBox(),
//        builder: (BuildContext context, AsyncSnapshot<Box> snapshot) {
//          if (snapshot.connectionState == ConnectionState.done) {
//            if (snapshot.hasError) {
//              print(snapshot.error);
//            }
//            List<ExerciseTrashTag> list = getTrashButtonsList(snapshot.data);
//            return Column(
//              crossAxisAlignment: CrossAxisAlignment.center,
//              mainAxisSize: MainAxisSize.min,
//              children: list,
//            );
//          } else {
//            return Container();
//          }
//        },
//      ),
//    );
//  }
//
//  List<ExerciseTrashTag> getTrashButtonsList(Box box) {
//    List<ExerciseTrashTag> list = new List<ExerciseTrashTag>();
//    ExerciseHolder holder = box.get(Resource.EXERCISES_HOLDER,
//        defaultValue: new ExerciseHolder(List<ExerciseTitle>(), List<ExerciseTitle>()));
//
//    for (int i = 0; i < holder.freshExercises.length; i++) {
//      list.add(new ExerciseTrashTag(holder.freshExercises[i].title,
//          holder.freshExercises[i].size, holder.freshExercises[i].key));
//    }
//
//    return list;
//  }
//
//  Future<Box> getBox() async {
//    if (box == null) {
//      box = await openMyBox();
//      if (box == null) {
//        box = await initAndGetBox();
//      }
//    }
//    return box;
//  }
//}
