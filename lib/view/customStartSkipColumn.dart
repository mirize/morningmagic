import 'package:flutter/material.dart';
import 'package:morningmagic/appLocalization.dart';

import 'animatedButton.dart';

class StartSkipColumn extends StatelessWidget {
  final VoidCallback startCallback;
  final GestureTapCallback gestureTapCallback;
  final GestureTapCallback mainMenuCallback;
  final String buttonText;

  StartSkipColumn(this.startCallback, this.gestureTapCallback,
      this.mainMenuCallback, this.buttonText);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child:
              AnimatedButton(startCallback, 'rex', buttonText, 15, null, null),
        ),
        Container(
          padding: EdgeInsets.only(top: 10),
          child:
              AnimatedButton(gestureTapCallback, 'rex', AppLocalizations.of(context).translate("skip"), 15, null, null),
        ),
        Container(
          padding: EdgeInsets.only(top: 10),
          child:
              AnimatedButton(mainMenuCallback, 'rex', AppLocalizations.of(context).translate("menu"), 15, null, null),
        )
      ],
    );
  }
}
