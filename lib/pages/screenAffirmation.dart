import 'package:flutter/material.dart';
import 'package:morningmagic/appLocalization.dart';
import 'package:morningmagic/pages/timer/screenTimerAffirmation.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/view/animatedButton.dart';

class AffirmationScreen extends StatefulWidget {
  @override
  State createState() {
    return AffirmationScreenState();
  }
}

class AffirmationScreenState extends State<AffirmationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: WillPopScope(
      onWillPop: () => _onWillPop(),
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
                        AppLocalizations.of(context).translate("affirmation"),
                        style: TextStyle(
                          fontSize: 32,
                          fontFamily: "rex",
                          fontStyle: FontStyle.normal,
                          color: AppColors.WHITE,
                        ),
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)
                          .translate("affirmation_text"),
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
                  bottom: 60,
                  child: ButtonTheme(
                    minWidth: 170.0,
                    height: 50.0,
                    child: AnimatedButton(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TimerAffirmationScreen()));
                    },
                        'rex',
                        AppLocalizations.of(context).translate("next_button"),
                        null,
                        null,
                        null),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Future<bool> _onWillPop() async {
    Navigator.pushNamedAndRemoveUntil(context, '/start', (r) => false);
    return false;
  }
}
