import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:morningmagic/db/model/exercise/exercise_holder.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/resources/colors.dart';

import '../appLocalization.dart';
import 'exerciseTrashButton.dart';

class ExerciseTrashTarget extends StatefulWidget {

  ExerciseTrashTarget(this.callback);

  final VoidCallback callback;

  @override
  ExerciseTrashTargetState createState() {
    return ExerciseTrashTargetState();
  }
}

class ExerciseTrashTargetState extends State<ExerciseTrashTarget> {

  Box box;

  Future<Box> initAndGetBox() async {
    await Hive.initFlutter();
    return await Hive.openBox(Resource.BOX_NAME);
  }

  Future<Box> openMyBox() async {
    return await Hive.openBox(Resource.BOX_NAME);
  }

  @override
  void initState() {
    box = Hive.box(Resource.BOX_NAME);
    if  (box == null) {
      openMyBox().then((value) {
        box = value;
        if (box == null) {
          initAndGetBox().then((value) {
            box = value;
          });
        }
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<ExerciseTrashTag>(
      builder: (BuildContext context, List<ExerciseTrashTag> candidateData,
          List<dynamic> rejectedData) {
        return Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.width * 0.4,
          decoration: BoxDecoration(
              color: candidateData.isEmpty
                  ? AppColors.TRANSPARENT
                  : AppColors.TRANSPARENT_WHITE),
          child: Center(
            child: Text(
                AppLocalizations.of(context).translate("delete_exercise"),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 23,
                    fontStyle: FontStyle.normal,
                    fontFamily: 'rex',
                    color: AppColors.TRANSPARENT_VIOLET)),
          ),
        );
      },
      onAccept: (ExerciseTrashTag tag) {

        widget.callback();
      },
    );
  }


}
