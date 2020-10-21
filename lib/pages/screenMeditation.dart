import 'package:flutter/material.dart';
import 'package:morningmagic/appLocalization.dart';
import 'package:morningmagic/pages/timer/screenTimerMeditation.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/view/animatedButton.dart';

class MeditationScreen extends StatefulWidget {
  @override
  State createState() {
    return MediationScreenState();
  }
}

class MediationScreenState extends State<MeditationScreen> {
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: 35),
                      child: Text(
                        AppLocalizations.of(context).translate("meditation"),
                        style: TextStyle(
                          fontSize: 32,
                          fontStyle: FontStyle.normal,
                          fontFamily: "rex",
                          color: AppColors.WHITE,
                        ),
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)
                          .translate("meditation_title"),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 19,
                        fontStyle: FontStyle.italic,
                        fontFamily: "JMH",
                        color: AppColors.VIOLET,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 70,
                  child: AnimatedButton(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TimerMeditationScreen()));
                  },
                      'rex',
                      AppLocalizations.of(context).translate("next_button"),
                      22,
                      null,
                      null),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
