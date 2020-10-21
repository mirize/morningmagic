import 'package:flutter/material.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/utils/progress_util.dart';
import 'package:morningmagic/view/animatedButton.dart';

import '../appLocalization.dart';

class DeleteProgressDialog extends Dialog {

  DeleteProgressDialog(this.voidCallback);

  final VoidCallback voidCallback;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height / 2.8,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context).translate("sure_delete_progress"),
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
                padding: EdgeInsets.only(top: 20),
                child: Center(
                  child: AnimatedButton(() {
                  ExerciseUtils().deleteAllProgress().then((value) {
                    voidCallback();
                  });
                    Navigator.pop(context, true);
                  }, 'rex', AppLocalizations.of(context).translate("yes"), 22,
                      null, null),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: AnimatedButton(() {
                  Navigator.pop(context, true);
                }, 'rex', AppLocalizations.of(context).translate("no"), 22,
                    null, null),
              ),
            ],
          ),
        ),
      ),
    );
  }
}