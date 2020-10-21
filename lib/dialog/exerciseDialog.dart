import 'package:flutter/material.dart';
import 'package:morningmagic/appLocalization.dart';
import 'package:morningmagic/db/model/app_and_custom_exercises/exercise_name.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/utils/progress_util.dart';
import 'package:morningmagic/view/animatedButton.dart';
import 'package:random_string/random_string.dart';

class ExerciseDialog extends Dialog {

  final TextEditingController _controller;
  final VoidCallback _backCallback;
  final VoidCallback _addCallback;
  final List<ExerciseName> list;


  ExerciseDialog(this._controller, this._backCallback, this._addCallback, this.list);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height / 2.9,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context).translate("enter_your_exercise"),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 23,
                        fontFamily: 'rex',
                        fontStyle: FontStyle.normal,
                        color: AppColors.VIOLET),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10, top: 10),
                child: TextField(
                  controller: _controller,
                  minLines: 1,
                  maxLines: 1,
                  cursorColor: AppColors.LIGHT_GRAY,
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 23,
                      fontFamily: "sans-serif",
                      fontStyle: FontStyle.normal,
                      color: AppColors.VIOLET,
                      decoration: TextDecoration.none),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: AppLocalizations.of(context).translate("your_exercise"),
                    hintStyle: TextStyle(
                      color: AppColors.LIGHT_GRAY,
                    )
                  ),
                ),
              ),
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      child: AnimatedButton(() {
                        if (_controller.text.isNotEmpty) {
                          print(_controller.text);
                          ExerciseName exerciseName = ExerciseName(randomAlpha(10), _controller.text, null);
                          list.add(exerciseName);
                          ExerciseUtils().saveCustomExerciseToDB(exerciseName).then((value) {
                            _addCallback();
                            _backCallback();
                          });
                        }

                      }, "rex", AppLocalizations.of(context).translate("add_exercise"), 18, null, null),
                    ),
                    Container(
                      padding:EdgeInsets.only(top: 10),
                      child: AnimatedButton(_backCallback, "rex", AppLocalizations.of(context).translate("back_button"), 18, null, null),
                    )
                  ],
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}