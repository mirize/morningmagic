import 'package:flutter/material.dart';
import 'package:morningmagic/appLocalization.dart';
import 'package:morningmagic/view/animatedButton.dart';

class BottomExerciseNavigation extends StatelessWidget {
  final GestureTapCallback soundCallback;
  final VoidCallback nextCallback;

  BottomExerciseNavigation(
      {@required this.soundCallback, @required this.nextCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 15),
            child: AnimatedButton(
                soundCallback, "rex", AppLocalizations.of(context).translate("listen_to"), 20, null, null),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 40),
            child: AnimatedButton(
                nextCallback, 'rex', AppLocalizations.of(context).translate("next_exercise"), 19, 270.0, null),
          ),
        ],
      ),
    );
  }
}
