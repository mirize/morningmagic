import 'package:flutter/material.dart';
import 'package:morningmagic/appLocalization.dart';
import 'package:morningmagic/pages/timer/screenTimerReading.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/view/animatedButton.dart';

class ReadingScreen extends StatefulWidget {
  @override
  State createState() {
    return ReadingScreenState();
  }
}

class ReadingScreenState extends State<ReadingScreen> {
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
                        AppLocalizations.of(context).translate("reading"),
                        style: TextStyle(
                          fontSize: 32,
                          fontFamily: "rex",
                          fontStyle: FontStyle.normal,
                          color: AppColors.WHITE,
                        ),
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context).translate("reading_title"),
                      style: TextStyle(
                        fontSize: 19,
                        fontFamily: "JMH",
                        fontStyle: FontStyle.italic,
                        color: AppColors.VIOLET,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 80,
                  child: AnimatedButton(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TimerReadingScreen()));
                  },
                      'rex',
                      AppLocalizations.of(context).translate("next_button"),
                      19,
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
